local Lib = {}

--[[  TODO:

    -- utdeltatrav bhud compat naturally

]]

function Lib:init()

    ----------------------------------------------------------------------------------
    -----  BITCH
    ----------------------------------------------------------------------------------

    print(self.info.id .. " version " .. self.info.version .. ": Getting ready...")

    if Mod.libs["moreparty"] then
        print(self.info.id .. ": MoreParty detected!")
        Lib.MOREPARTY = true
    end

    ----------------------------------------------------------------------------------
    -----  ITEM HOOKS
    ----------------------------------------------------------------------------------

    -----  NEW PROPERTIES AND CALLBACKS

    Utils.hook(Item, "init", function(orig, self)

        orig(self)

        self.bolt_count = nil
        self.bolt_speed = nil
        self.bolt_offset = 0
        self.bolt_accel = 0
        self.multibolt_variance = {0, 0}

        self.bolt_target = 0
        self.bolt_miss_threshold = nil

        self.critical_threshold = 30 -- here for ease of use and for the debug display
        self.critical_bonus = 0
        self.max_points = nil
    
    end)

    Utils.hook(Item, "getBoltCount", function(orig, self)
        return self.bolt_count
    end)

    Utils.hook(Item, "getBoltSpeed", function(orig, self)
        return self.bolt_speed
    end)

    Utils.hook(Item, "getBoltOffset", function(orig, self)
        return self.bolt_offset
    end)

    Utils.hook(Item, "getMultiboltVariance", function(orig, self)
        return self.multibolt_variance
    end)

    Utils.hook(Item, "getBoltAcceleration", function(orig, self)
        return self.bolt_accel
    end)

    Utils.hook(Item, "getBoltTarget", function(orig, self)
        return self.bolt_target
    end)

    Utils.hook(Item, "getBoltMissThreshold", function(orig, self)

        if not self.bolt_miss_threshold then
            self.bolt_miss_threshold = -5
        end

        return self.bolt_miss_threshold
    end)
 
    Utils.hook(Item, "getCriticalThreshold", function(orig, self)
        return self.critical_threshold
    end)

    Utils.hook(Item, "getCriticalBonus", function(orig, self)
        return self.critical_bonus
    end)

    Utils.hook(Item, "getMaxPoints", function(orig, self)

        if not self.max_points then
            self.max_points = self.critical_threshold * 3.5
        end

        return self.max_points
        
    end)

    ----- CALLBACKS

    Utils.hook(Item, "onHit", function(orig, self, battler, score, bolts, close)

        local attackbox
        for _,box in ipairs(Game.battle.battle_ui.attack_boxes) do
            if box.battler == battler then
                attackbox = box
                break
            end
        end

        local bolt = bolts[1]
    
        attackbox.score = attackbox.score + self:evaluateHit(battler, close)

        bolt:resetPhysics()

        self:onBoltBurst(battler, score, bolts, close)

        table.remove(bolts, 1)

        return self:checkAttackEnd(battler, attackbox.score, bolts, close)

    end)

    Utils.hook(Item, "onAttack", function(orig, self, battler, score, bolts, close)
    
        return self:evaluateScore(battler, score)
    
    end)

    Utils.hook(Item, "onDamage", function(orig, self, action, battler, enemy, score, bolts, close)

        local src = Assets.stopAndPlaySound(battler.chara:getAttackSound() or "laz_c")
        src:setPitch(battler.chara:getAttackPitch() or 1)

        self.actions_done_timer = 1.2

        local crit = action.points >= 150 --[[i lied]] and action.action ~= "AUTOATTACK"
        if crit then
            Assets.stopAndPlaySound("criticalswing")

            for i = 1, 3 do
                local sx, sy = battler:getRelativePos(battler.width, 0)
                local sparkle = Sprite("effects/criticalswing/sparkle", sx + Utils.random(50), sy + 30 + Utils.random(30))
                sparkle:play(4/30, true)
                sparkle:setScale(2)
                sparkle.layer = BATTLE_LAYERS["above_battlers"]
                sparkle.physics.speed_x = Utils.random(2, 6)
                sparkle.physics.friction = -0.25
                sparkle:fadeOutSpeedAndRemove()
                Game.battle:addChild(sparkle)
            end
        end

        battler:setAnimation("battle/attack", function()
            action.icon = nil

            if action.target and action.target.done_state then
                enemy = Game.battle:retargetEnemy()
                action.target = enemy
                if not enemy then
                    Game.battle.cancel_attack = true
                    Game.battle:finishAction(action)
                    return
                end
            end

            local damage = Utils.round(enemy:getAttackDamage(action.damage or 0, battler, action.points or 0))
            if damage < 0 then
                damage = 0
            end

            if damage > 0 then
                Game:giveTension(Utils.round(enemy:getAttackTension(action.points or 100)))

                local dmg_sprite = Sprite(battler.chara:getAttackSprite() or "effects/attack/cut")
                dmg_sprite:setOrigin(0.5, 0.5)
                if crit then
                    dmg_sprite:setScale(2.5, 2.5)
                else
                    dmg_sprite:setScale(2, 2)
                end
                dmg_sprite:setPosition(enemy:getRelativePos(enemy.width/2, enemy.height/2))
                dmg_sprite.layer = enemy.layer + 0.01
                dmg_sprite:play(1/15, false, function(s) s:remove() end)
                enemy.parent:addChild(dmg_sprite)

                local sound = enemy:getDamageSound() or "damage"
                if sound and type(sound) == "string" then
                    Assets.stopAndPlaySound(sound)
                end
                enemy:hurt(damage, battler)

                battler.chara:onAttackHit(enemy, damage)
            else
                enemy:statusMessage("msg", "miss", {battler.chara:getDamageColor()})
            end

            Game.battle:finishAction(action)

            Utils.removeFromTable(Game.battle.normal_attackers, battler)
            Utils.removeFromTable(Game.battle.auto_attackers, battler)

            if not Game.battle:retargetEnemy() then
                Game.battle.cancel_attack = true
            elseif #Game.battle.normal_attackers == 0 and #Game.battle.auto_attackers > 0 then
                local next_attacker = Game.battle.auto_attackers[1]

                local next_action = Game.battle:getActionBy(next_attacker)
                if next_action then
                    Game.battle:beginAction(next_action)
                    Game.battle:processAction(next_action)
                end
            end
        end)

    end)

    Utils.hook(Item, "onWeaponMiss", function(orig, self, battler, score, bolts, close)

        local attackbox
        for _,box in ipairs(Game.battle.battle_ui.attack_boxes) do
            if box.battler == battler then
                attackbox = box
                break
            end
        end
    
        local bolt = bolts[1]

        bolt:resetPhysics()

        bolt:fadeOutSpeedAndRemove(0.45)

        table.remove(bolts, 1)

        return self:checkAttackEnd(battler, attackbox.score, bolts, close)
    
    end)

    Utils.hook(Item, "onArmorMiss", function(orig, self, battler, score, bolts, close)

        local attackbox
        for _,box in ipairs(Game.battle.battle_ui.attack_boxes) do
            if box.battler == battler then
                attackbox = box
                break
            end
        end

        return self:checkAttackEnd(battler, attackbox.score, bolts, close)
    end)

    Utils.hook(Item, "checkAttackEnd", function(orig, self, battler, score, bolts, close)
    
        local attackbox
        for _,box in ipairs(Game.battle.battle_ui.attack_boxes) do
            if box.battler == battler then
                attackbox = box
                break
            end
        end

        if #bolts == 0 then
            attackbox.attacked = true
            return self:onAttack(battler, score, bolts, close)
        end
    
    end)

    Utils.hook(Item, "onBoltBurst", function(orig, self, battler, score, bolts, close)

        local bolt = bolts[1]

        bolt:burst()
        bolt.layer = 1
        bolt:setPosition(bolt:getRelativePos(0, 0, Game.battle.battle_ui))
        bolt:setParent(Game.battle.battle_ui)

        if battler:getBoltCount() > 1 then

            if close == 0 then
                Assets.stopAndPlaySound("victor", 1.2)
                bolt:setColor(1, 1, 0)
                bolt.burst_speed = 0.2
            elseif close >= 6 or close <= -3 then
                bolt:setColor(1, 80/255, 80/255, 1)
            else
                Assets.stopAndPlaySound("hit", 1.1)
                bolt:setColor(battler.chara:getDamageColor())
            end

        else

            if close == 0 then
                bolt:setColor(1, 1, 0)
                bolt.burst_speed = 0.2
            elseif (math.abs(close) >= 3) then
                bolt:setColor(battler.chara:getDamageColor())
            end

        end
        
    end)

    ----- EVALUATEHIT

    Utils.hook(Item, "evaluateHit", function(orig, self, battler, close)

        if battler:getBoltCount() > 1 then

            if close < -1 then

                --return 50
                return math.floor(self:getMaxPoints() / 1.4)

            elseif close < 0 then

                --return 70
                return math.floor(self:getMaxPoints() / 1.3)

            elseif close < 1 then
                
                --return 105
                return self:getMaxPoints()

            elseif close < 2 then

                --return 85
                return math.floor(self:getMaxPoints() / 1.2)

            elseif close < 3 then

                --return 70
                return math.floor(self:getMaxPoints() / 1.35)

            elseif close < 6 then

                --return 40
                return math.floor(self:getMaxPoints() / 2.1)

            elseif close < 8 then

                --return 25
                return math.floor(self:getMaxPoints() / 3.7)

            elseif close < 11 then

                --return 20
                return math.floor(self:getMaxPoints() / 4)

            else

                --return 10
                return math.floor(self:getMaxPoints() / 5)

            end

        else

            if math.abs(close) == 0 then
                return 150
            elseif math.abs(close) == 1 then
                return 120
            elseif math.abs(close) == 2 then
                return 110
            elseif math.abs(close) >= 3 then
                return 100 - (math.abs(close) * 2)
            end

        end
    end)

    ----- EVALUATESCORE

    Utils.hook(Item, "evaluateScore", function(orig, self, battler, score, bolts, close)

        if battler:getBoltCount() > 1 then

            local crit = self.critical_threshold
            local perfect_score = self:getMaxPoints() * battler:getBoltCount()
    
            if perfect_score - score <= crit then
                return 150 + self.critical_bonus
            elseif perfect_score - score <= 75 - crit then
                return 120
            elseif perfect_score - score <= 150 - crit then
                return 110
            else
                return Utils.round(score / 3)
            end

        elseif battler:getBoltCount() == 1 and score == 150 then

            return score + self.critical_bonus

        elseif battler:getBoltCount() == 1 then

            return score

        end
        
    end)

    ----------------------------------------------------------------------------------
    -----  PARTYBATTLER HOOKS
    ----------------------------------------------------------------------------------

    -----  NEW PROPERTIES AND CALLBACKS

    Utils.hook(PartyBattler, "createPartyBattlers", function(orig, self)

        orig(self)

        self.bolt_count = nil
        self.bolt_speed = nil
        self.bolt_offset = nil
    
    end)

    -- these are initialized as 0, so math.max is used to set it to 1 if no bolts are added
    Utils.hook(PartyBattler, "getBoltCount", function(orig, self)

        self.bolt_count = 0

        for _,equip in ipairs(self.chara:getEquipment()) do
            if equip:getBoltCount() then
                self.bolt_count = self.bolt_count + equip:getBoltCount()
            else
                if equip.type == "weapon" then
                    self.bolt_count = self.bolt_count + 1
                end
            end
        end

        return self.bolt_count

    end)

    -- 8 is the default speed. if you change this, i recommend setting it to a multiple of 8 so the bolts don't desync
    Utils.hook(PartyBattler, "getBoltSpeed", function(orig, self)

        self.bolt_speed = 0

        for _,equip in ipairs(self.chara:getEquipment()) do
            if equip:getBoltSpeed() then
                self.bolt_speed = self.bolt_speed + equip:getBoltSpeed()
            else
                if equip.type == "weapon" then
                    self.bolt_speed = self.bolt_speed + AttackBox.BOLTSPEED
                end
            end
        end

        return self.bolt_speed

    end)

    Utils.hook(PartyBattler, "getBoltOffset", function(orig, self)

        self.bolt_offset = 0

        for _,equip in ipairs(self.chara:getEquipment()) do
            self.bolt_offset = self.bolt_offset + equip:getBoltOffset()
        end

        return self.bolt_offset

    end)

    ----------------------------------------------------------------------------------
    -----  ATTACKBOX HOOKS  
    ----------------------------------------------------------------------------------

    -----  INIT

    Utils.hook(AttackBox, "init", function(orig, self, battler, offset, x, y)

        AttackBox.__super.init(self, x, y)
    
        self.battler = battler
        self.weapon = battler.chara:getWeapon()
        self.offset = offset + self.battler:getBoltOffset()
    
        self.head_sprite = Sprite(battler.chara:getHeadIcons().."/head", 21, 19)
        self.head_sprite:setOrigin(0.5, 0.5)
        self:addChild(self.head_sprite)
    
        self.press_sprite = Sprite("ui/battle/press", 42, 0)
        self:addChild(self.press_sprite)
    
        self.bolt_target = (80 + 2) + self.weapon:getBoltTarget()
        self.bolt_miss_threshold = self.weapon:getBoltMissThreshold()

        self.bolt_start_x = self.bolt_target + (self.offset * self.battler:getBoltSpeed())
    
        self.bolts = {}
        self.score = 0

        for i = 0, self.battler:getBoltCount() - 1 do

            local bolt

            if i == 0 then
                bolt = AttackBar(self.bolt_start_x + (i * 80), 0, 6, 38)
            else

                local min = self.weapon:getMultiboltVariance()[1]
                local max = self.weapon:getMultiboltVariance()[2]
                local bolt_variance = Utils.round(Utils.random(min, max))
                bolt = AttackBar(self.bolts[1].x + (i * (80 + bolt_variance)), 0, 6, 38)

            end

            bolt.layer = 1
            table.insert(self.bolts, bolt)
            self:addChild(bolt)
            
        end
    
        self.fade_rect = Rectangle(0, 0, SCREEN_WIDTH, 38)
        self.fade_rect:setColor(0, 0, 0, 0)
        self.fade_rect.layer = 2
        self:addChild(self.fade_rect)
    
        self.afterimage_timer = 0
        self.afterimage_count = -1
    
        self.flash = 0
    
        self.attacked = false

    end)

    -----  GETCLOSE

    Utils.hook(AttackBox, "getClose", function(orig, self)
        return Utils.round((self.bolts[1].x - self.bolt_target) / self.battler:getBoltSpeed())
    end)

    -----  HIT

    Utils.hook(AttackBox, "hit", function(orig, self)
        
        local close = self:getClose()

        for _,equip in ipairs(self.battler.chara:getEquipment()) do
            return equip:onHit(self.battler, self.score, self.bolts, close)
        end

    end)

    -----  MISS

    Utils.hook(AttackBox, "miss", function(orig, self)

        local close = self:getClose()

        for _,equip in ipairs(self.battler.chara:getEquipment()) do
            if equip.type == "armor" then
                return equip:onArmorMiss(self.battler, self.score, self.bolts, close)
            elseif equip.type == "weapon" then
                return equip:onWeaponMiss(self.battler, self.score, self.bolts, close)
            end
        end

    end)

    -----  UPDATE

    Utils.hook(AttackBox, "update", function(orig, self)
        if Game.battle.cancel_attack then
            self.fade_rect.alpha = Utils.approach(self.fade_rect.alpha, 1, DTMULT/20)
        end
    
        if not self.attacked then

            self.afterimage_timer = self.afterimage_timer + DTMULT/2

            for _,bolt in ipairs(self.bolts) do

                local accel = self.weapon:getBoltAcceleration()

                if accel > 0 then
                    bolt.physics.gravity = accel
                    bolt.physics.gravity_direction = math.pi
                    bolt:move(-(self.battler:getBoltSpeed() - 8) * DTMULT, 0)
                else
                    bolt:move(-(self.battler:getBoltSpeed()) * DTMULT, 0)
                end

                if not bolt.afterimage_count then
                    bolt.afterimage_count = 0
                end

                if self.battler:getBoltCount() == 1 and accel == 0 then
                    while math.floor(self.afterimage_timer) > self.afterimage_count do
                        self.afterimage_count = self.afterimage_count + 1

                        local afterimg

                        if Lib.MOREPARTY then
                            afterimg = AttackBar(self.bolt_start_x - (self.afterimage_count * self.battler:getBoltSpeed() * 2), 0, 6, self.realHeight)
                        else
                            afterimg = AttackBar(self.bolt_start_x - (self.afterimage_count * self.battler:getBoltSpeed() * 2), 0, 6, 38)
                        end

                        afterimg.layer = 3
                        afterimg.alpha = 0.4
                        afterimg:fadeOutSpeedAndRemove()
                        self:addChild(afterimg)
                    end
                end

            end
        end
    
        if not Game.battle.cancel_attack and Input.pressed("confirm") then
            self.flash = 1
        else
            self.flash = Utils.approach(self.flash, 0, DTMULT/5)
        end

        AttackBox.__super.update(self)
    end)

    -----  DRAW

    Utils.hook(AttackBox, "draw", function(orig, self)

        local target_color = {self.battler.chara:getAttackBarColor()}
        local box_color = {self.battler.chara:getAttackBoxColor()}
    
        if self.flash > 0 then
            box_color = Utils.lerp(box_color, {1, 1, 1}, self.flash)
        end
    
        love.graphics.setLineWidth(2)
        love.graphics.setLineStyle("rough")

        local box_height
        if Lib.MOREPARTY then
            box_height = (self.realHeight or 38) - 2
        else
            box_height = 38 - 2
        end
    
        love.graphics.setColor(box_color)
        love.graphics.rectangle("line", 80, 1, (15 * (self.battler:getBoltSpeed())) + 3, box_height)
        love.graphics.setColor(target_color)
        love.graphics.rectangle("line", self.bolt_target + 1, 1, 8, box_height)
    
        love.graphics.setLineWidth(1)
    
        AttackBox.__super.draw(self)

    end)

    ----------------------------------------------------------------------------------
    -----  BATTLE HOOKS  
    ----------------------------------------------------------------------------------

    -----  PROCESSACTION

    Utils.hook(Battle, "processAction", function(orig, self, action)

        local battler = self.party[action.character_id]
        local party_member = battler.chara -- ???
        local enemy = action.target
        local battler_weapon = battler.chara:getWeapon()
    
        self.current_processing_action = action

        local attackbox
        for _,box in ipairs(Game.battle.battle_ui.attack_boxes) do
            if box.battler == battler then
                attackbox = box
                break
            end
        end

        if action.action == "ATTACK" or action.action == "AUTOATTACK" then
            if attackbox.attacked then

                battler_weapon:onDamage(action, battler, enemy, attackbox.score, attackbox.bolts, attackbox.close)

            end
        elseif action.action == "SKIP" then
            return true -- has to be here to prevent multi-acts from softlocking, somehow they get caught on SKIP
        else
            orig(self, action)
        end
    end)

    -----  UPDATEATTACKING

    Utils.hook(Battle, "updateAttacking", function(orig, self)

        if self.cancel_attack then
            self:finishAllActions()
            self:setState("ACTIONSDONE")
            return
        end

        if not self.attack_done then
            if not self.battle_ui.attacking then
                self.battle_ui:beginAttack()
            end

            if #self.attackers == #self.auto_attackers and self.auto_attack_timer < 4 then
                self.auto_attack_timer = self.auto_attack_timer + DTMULT

                if self.auto_attack_timer >= 4 then
                    local next_attacker = self.auto_attackers[1]

                    local next_action = self:getActionBy(next_attacker)
                    if next_action then
                        self:beginAction(next_action)
                        self:processAction(next_action)
                    end
                end
            end

            local all_done = true

            for _,box in ipairs(self.battle_ui.attack_boxes) do
                if not box.attacked and box.fade_rect.alpha < 1 then

                    local close = box:getClose()

                    if close <= box.bolt_miss_threshold and #box.bolts > 1 then

                        all_done = false
                        box:miss()                 

                    elseif close <= box.bolt_miss_threshold then

                        local points = box:miss() -- lmao

                        local action = self:getActionBy(box.battler)
                        action.points = points

                        if self:processAction(action) then
                            self:finishAction(action)
                        end

                    else
                        all_done = false
                    end

                end
            end

            if #self.auto_attackers > 0 then
                all_done = false
            end

            if all_done then
                self.attack_done = true
            end
        else
            if self:allActionsDone() then
                self:setState("ACTIONSDONE")
            end
        end
    end)

    -----  DRAWDEBUG

    Utils.hook(Battle, "drawDebug", function(orig, self)
        orig(self)

        local ui = self.battle_ui

        for i, box in ipairs(self.battle_ui.attack_boxes) do
            local battler = box.battler

            if battler:getBoltCount() > 1 then
                local perfect_score = (battler.chara:getWeapon():getMaxPoints() * battler:getBoltCount())
                local crit = battler.chara:getWeapon():getCriticalThreshold()
                local crit_req = perfect_score - crit
        
                if self.state == "ATTACKING" or self.state == "ACTIONSDONE" and ui.attack_boxes[i] then

                    if perfect_score - ui.attack_boxes[i].score <= crit then
                        love.graphics.setColor(1, 1, 0, 1)
                    end

                    self:debugPrintOutline(battler.chara.name .. "'s score: " .. ui.attack_boxes[i].score .. ", (" .. crit_req .. " for a crit)", 4, ui.attack_boxes[i].y + 310)
                end
            end

        end
        
    end)

    ----------------------------------------------------------------------------------
    -----  MOREPARTY COMPAT
    ----------------------------------------------------------------------------------

    -----  BEGINATTACK

    Utils.hook(BattleUI, "beginAttack", function(orig, self)
    
        orig(self)

        if Lib.MOREPARTY then

            if #Game.party <= 3 then return end

            local height = (115 / #Game.battle.party)
		
            for _,box in ipairs(self.attack_boxes) do

                box.head_sprite.height = height + 4

                for _,bolt in ipairs(box.bolts) do
                    bolt.height = height
                end

                box.fade_rect.height = height
                box.realHeight = height

                local battler
                local name = Game:getPartyMember(box.battler.chara.id)
                for i, member in ipairs(Game.party) do
                    if member == name then
                        battler = i
                        break
                    end
                end

                box.y = 40 + (height * (battler - 1))
            end

            -- if you use k,v in for loops, i hate you

        end

    end)

    ----------------------------------------------------------------------------------
    -----  I DID IT
    ----------------------------------------------------------------------------------

    print(self.info.id .. ": Ready!")

end

return Lib