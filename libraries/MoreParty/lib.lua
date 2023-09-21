local Lib = {}

function Lib:init()

    if Mod.libs["morebattle"] then -- Prevents the library from running when 'morebattle' is also present
        error("MoreBattle is conflicting with MoreParty, remove it to advance.")
    end
    
    Utils.hook(ActionBoxDisplay, "draw", function(orig, self)
        if #Game.party <= 3 then orig(self) return end
        
        local x = self.parent.realWidth
        
        if Game.battle.current_selecting == self.actbox.index then
            Draw.setColor(self.actbox.battler.chara:getColor())
        else
            Draw.setColor(PALETTE["action_strip"], 1)
        end

        love.graphics.setLineWidth(2)
        love.graphics.line(0  , Game:getConfig("oldUIPositions") and 2 or 1, x + 1, Game:getConfig("oldUIPositions") and 2 or 1)

        love.graphics.setLineWidth(2)
        if Game.battle.current_selecting == self.actbox.index then
            love.graphics.line(1  , 2, 1,   36)
            love.graphics.line(x, 2, x, 36)
        end

        Draw.setColor(PALETTE["action_fill"])
        love.graphics.rectangle("fill", 2, Game:getConfig("oldUIPositions") and 3 or 2, x - 3, Game:getConfig("oldUIPositions") and 34 or 35)
        
        if not Kristal.getLibConfig("moreparty", "classic_mode") then
            love.graphics.setColor(PALETTE["action_health_bg"])
            love.graphics.rectangle("fill", 118, 22 - self.actbox.data_offset, 39, 9)
            local health = (self.actbox.battler.chara:getHealth() / self.actbox.battler.chara:getStat("health")) * 39

            if health > 0 then
                love.graphics.setColor(self.actbox.battler.chara:getColor())
                love.graphics.rectangle("fill", 118, 22 - self.actbox.data_offset, math.ceil(health), 9)
            end
            
            if Mod.libs["better_battles"] and self.actbox.battler.shield then -- Compatability with 'better_battles' Library.
                Draw.setColor({128/255, 128/255, 128/255})
                love.graphics.rectangle("fill", 118, 27 - self.actbox.data_offset, math.ceil((self.actbox.battler.shield / self.actbox.battler.chara:getMaxShield()) * 39), 4)
            end
            
            local color = PALETTE["action_health_text"]
            if health <= 0 then
                color = PALETTE["action_health_text_down"]
            elseif (self.actbox.battler.chara:getHealth() <= (self.actbox.battler.chara:getStat("health") / 4)) then
                color = PALETTE["action_health_text_low"]
            else
                color = PALETTE["action_health_text"]
            end

            local health_offset = 0
            health_offset = (#tostring(self.actbox.battler.chara:getHealth()) - 1) * 8
            
            love.graphics.setColor(color)
            love.graphics.setFont(self.font)
            love.graphics.print(self.actbox.battler.chara:getHealth(), 113 - health_offset, 9 - self.actbox.data_offset)
            love.graphics.setColor(PALETTE["action_health_text"])
            love.graphics.print("/", 121, 9 - self.actbox.data_offset)
            love.graphics.setColor(color)
            local string_width = self.font:getWidth(tostring(self.actbox.battler.chara:getStat("health")))
            love.graphics.print(self.actbox.battler.chara:getStat("health"), 159 - string_width, 9 - self.actbox.data_offset)
            love.graphics.translate(-10, 0)
        else
            Draw.setColor(PALETTE["action_health_bg"])
            love.graphics.rectangle("fill", 128, 22 - self.actbox.data_offset, 76, 9)

            local health = (self.actbox.battler.chara:getHealth() / self.actbox.battler.chara:getStat("health")) * 76

            if health > 0 then
                Draw.setColor(self.actbox.battler.chara:getColor())
                love.graphics.rectangle("fill", 128, 22 - self.actbox.data_offset, math.ceil(health), 9)
            end

            if Mod.libs["better_battles"] and self.actbox.battler.shield then -- Compatability with 'better_battles' Library.
                Draw.setColor({128/255, 128/255, 128/255})
                love.graphics.rectangle("fill", 128, 27 - self.actbox.data_offset, math.ceil((self.actbox.battler.shield / self.actbox.battler.chara:getMaxShield()) * 76), 4)
            end
            
            local color = PALETTE["action_health_text"]
            if health <= 0 then
                color = PALETTE["action_health_text_down"]
            elseif (self.actbox.battler.chara:getHealth() <= (self.actbox.battler.chara:getStat("health") / 4)) then
                color = PALETTE["action_health_text_low"]
            else
                color = PALETTE["action_health_text"]
            end


            local health_offset = 0
            health_offset = (#tostring(self.actbox.battler.chara:getHealth()) - 1) * 8

            Draw.setColor(color)
            love.graphics.setFont(self.font)
            love.graphics.print(self.actbox.battler.chara:getHealth(), 152 - health_offset, 9 - self.actbox.data_offset)
            Draw.setColor(PALETTE["action_health_text"])
            love.graphics.print("/", 161, 9 - self.actbox.data_offset)
            local string_width = self.font:getWidth(tostring(self.actbox.battler.chara:getStat("health")))
            Draw.setColor(color)
            love.graphics.print(self.actbox.battler.chara:getStat("health"), 205 - string_width, 9 - self.actbox.data_offset)
        end
      
        Object.draw(self)
    end)
    
    Utils.hook(ActionBox, "drawActionBox", function(orig, self)
        if #Game.party <= 3 then orig(self) return end
        
        local x = self.realWidth
        if Game.battle.current_selecting == self.index then
            Draw.setColor(self.battler.chara:getColor())
            love.graphics.setLineWidth(2)
            love.graphics.line(1  , 2, 1,   37)
            love.graphics.line(Game:getConfig("oldUIPositions") and (x - 1) or x, 2, Game:getConfig("oldUIPositions") and (x - 1) or x, 37)
            love.graphics.line(0  , 6, x, 6 )
        end
        Draw.setColor(1, 1, 1, 1)
    end)
    
    Utils.hook(ActionBox, "drawSelectionMatrix", function(orig, self)
        if #Game.party <= 3 then orig(self) return end

        local x = self.realWidth

        -- Draw the background of the selection matrix
        Draw.setColor(0, 0, 0, 1)
        love.graphics.rectangle("fill", 2, 2, x - 3, 35)

        if Game.battle.current_selecting == self.index then
            local r,g,b,a = self.battler.chara:getColor()

            for i = 0, 11 do
                local siner = self.selection_siner + (i * (10 * math.pi))

                love.graphics.setLineWidth(2)
                Draw.setColor(r, g, b, a * math.sin(siner / 60))
                if math.cos(siner / 60) < 0 then
                    love.graphics.line(1 - (math.sin(siner / 60) * 30) + 30, 0, 1 - (math.sin(siner / 60) * 30) + 30, 37)
                    love.graphics.line(x - 1 + (math.sin(siner / 60) * 30) - 30, 0, x - 1 + (math.sin(siner / 60) * 30) - 30, 37)
                end
            end

            Draw.setColor(1, 1, 1, 1)
        end
    end)
    
    Utils.hook(BattleUI, "drawActionStrip", function(orig, self)
        orig(self)
        
        if #Game.party <= (Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4) then return end
        
        -- Draw the top line of the action strip
        Draw.setColor(PALETTE["action_strip"])
        love.graphics.rectangle("fill", 0, Game:getConfig("oldUIPositions") and -35 or -37, 640, Game:getConfig("oldUIPositions") and 3 or 2)
        -- Draw the background of the action strip
        Draw.setColor(PALETTE["action_fill"])
        love.graphics.rectangle("fill", 0, Game:getConfig("oldUIPositions") and -32 or -35, 640, Game:getConfig("oldUIPositions") and 33 or 35)
    end)
    
    Utils.hook(ActionBox, "update", function(orig, self)
        orig(self)
        
        if #Game.battle.party <= 3 or Kristal.getLibConfig("moreparty", "classic_mode") then return end

        local x = 16 + math.min((5 - #self.buttons),5) * 16
        
        for _,button in ipairs(self.buttons) do
            button.visible = (Game.battle.current_selecting == self.index)
            button.x = x
            
            x = x + 32
        end
    end)

      
    Utils.hook(AttackBox, "draw", function(orig, self, ...)
        if #Game.battle.party <= 3 then orig(self, ...) return end

        local target_color = {self.battler.chara:getAttackBarColor()}
        local box_color = {self.battler.chara:getAttackBoxColor()}

        if self.flash > 0 then
        box_color = Utils.lerp(box_color, {1, 1, 1}, self.flash)
        end

        love.graphics.setLineWidth(2)
        love.graphics.setLineStyle("rough")

        local ch1_offset = Game:getConfig("oldUIPositions")

        Draw.setColor(box_color)
        local height = math.floor(104 / #Game.battle.party)
        love.graphics.rectangle("line", 80, ch1_offset and 0 or 1, (15 * AttackBox.BOLTSPEED) + 3, height)

        Draw.setColor(target_color)
        love.graphics.rectangle("line", 83, 1, 8, height)
        Draw.setColor(0, 0, 0)
        love.graphics.rectangle("fill", 84, 2, 6, height - 2)

        love.graphics.setLineWidth(1)

        Object.draw(self)
    end)
      
    Utils.hook(BattleUI, "beginAttack", function(orig, self, ...)

        if #Game.battle.party <= 3 then orig(self, ...) return end

        local attack_order = Utils.pickMultiple(Game.battle.normal_attackers, #Game.battle.normal_attackers)

        for _,box in ipairs(self.attack_boxes) do
            box:remove()
            end
            self.attack_boxes = {}

            local last_offset = -1
            local offset = 0
            local height = math.floor(112 / #Game.battle.party)
            for i = 1, #attack_order do
            offset = offset + last_offset

            local battler = attack_order[i]
            local index = Game.battle:getPartyIndex(battler.chara.id)
            local attack_box = AttackBox(battler, 30 + offset, index, 0, 40 + (height * (index - 1)))
            attack_box.layer = -10 + (index * 0.01)
            self:addChild(attack_box)
            table.insert(self.attack_boxes, attack_box)

            if i < #attack_order and last_offset ~= 0 then
                last_offset = Utils.pick{0, 10, 15}
            else
                last_offset = Utils.pick{10, 15}
            end
        end
        self.attacking = true
    end)
      
    Utils.hook(AttackBox, "update", function(orig, self, ...)

        if self.removing or Game.battle.cancel_attack then
            self.fade_rect.alpha = Utils.approach(self.fade_rect.alpha, 1, 0.08 * DTMULT)
        end

        if not self.attacked then

            self.afterimage_timer = self.afterimage_timer + DTMULT/2
            
            if Mod.libs["ExpandedAttackLib"] then -- Compatability with 'ExpandedAttackLib' Library.
                for _,bolt in ipairs(self.bolts) do

                    local accel = self.weapon:getBoltAcceleration()

                    if accel > 0 then
                        bolt.physics.gravity = accel
                        bolt.physics.gravity_direction = math.pi
                        bolt:move(-(self.battler:getBoltSpeed() - 8) * DTMULT, 0)
                    else
                        bolt:move(-(self.battler:getBoltSpeed()) * DTMULT, 0)
                    end

                end
                while math.floor(self.afterimage_timer) > self.afterimage_count do
                    self.afterimage_count = self.afterimage_count + 1
                    for _,bolt in ipairs(self.bolts) do
                        local afterimg = AttackBar(bolt.x, 0, 6, #Game.battle.party > 3 and math.floor(112/#Game.battle.party) or 38)
                        afterimg.layer = 3
                        afterimg.alpha = 0.4
                        afterimg:fadeOutSpeedAndRemove()
                        self:addChild(afterimg)
                    end
                end
            else
                self.bolt:move(-AttackBox.BOLTSPEED * DTMULT, 0)
                while math.floor(self.afterimage_timer) > self.afterimage_count do
                    self.afterimage_count = self.afterimage_count + 1
                    local afterimg = AttackBar(self.bolt_start_x - (self.afterimage_count * AttackBox.BOLTSPEED * 2), 0, 6, #Game.battle.party > 3 and math.floor(112/#Game.battle.party) or 38)
                    afterimg.layer = 3
                    afterimg.alpha = 0.4
                    afterimg:fadeOutSpeedAndRemove()
                    self:addChild(afterimg)
                end
            end
        end

        if not Game.battle.cancel_attack and Input.pressed("confirm") then
            self.flash = 1
        else
            self.flash = Utils.approach(self.flash, 0, DTMULT/5)
        end

        Object.update(self)
    end)
    
    if not Mod.libs["ExpandedAttackLib"] then -- Compatability with 'ExpandedAttackLib' Library.
        Utils.hook(AttackBox, "init", function(orig, self, ...)
            orig(self, ...)
            if #Game.battle.party <= 3 then return end
            
            self.bolt.height = math.floor(112 / #Game.battle.party)
            self.head_sprite:setOrigin(0.5, 0.75 + (2 * (#Game.battle.party - 4) * 0.075))
            self.press_sprite:setOrigin(0, (#Game.battle.party - 4) * 0.025)
            self.head_sprite:setScale(1 - ((#Game.battle.party - 4) * 0.125))
         
        end)
    else
        Utils.hook(AttackBox, "init", function(orig, self, battler, offset, index, x, y)

            AttackBox.__super.init(self, x, y)
        
            self.battler = battler
            self.weapon = battler.chara:getWeapon()
            self.offset = offset + self.battler:getBoltOffset()
            self.index = index
        
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
                if #Game.battle.party > 3 then
                    bolt.height = math.floor(112 / #Game.battle.party)
                end
                table.insert(self.bolts, bolt)
                self:addChild(bolt)
                
            end
        
            self.fade_rect = Rectangle(0, 0, SCREEN_WIDTH, 300)
            self.fade_rect:setColor(0, 0, 0, 0)
            self.fade_rect.layer = 2
            self:addChild(self.fade_rect)
        
            self.afterimage_timer = 0
            self.afterimage_count = -1
        
            self.flash = 0
        
            self.attacked = false
            self.removing = false
            
            if #Game.battle.party <= 3 then return end
            
            self.head_sprite:setOrigin(0.5, 0.75 + (2 * (#Game.battle.party - 4) * 0.075))
            self.press_sprite:setOrigin(0, (#Game.battle.party - 4) * 0.025)
            self.head_sprite:setScale(1 - ((#Game.battle.party - 4) * 0.125))

        end)
    end
   
    Utils.hook(BattleUI, "drawState", function(orig, self, ...)
        if #Game.party <= 3 then orig(self, ...) return end
        
        if Game.battle.state == "ATTACKING" or self.attacking then
            local y = 40
            local h = math.floor((115 - (#Game.battle.party % 4)) / #Game.battle.party)
            
            local ch1_offset = Game:getConfig("oldUIPositions")
            
            for c = 1, (#Game.battle.party - 1) do
                love.graphics.setColor(PALETTE["battle_attack_lines"])
                y = y + h
                love.graphics.rectangle("fill", 79 - (ch1_offset and 2 or 0), y, 224 + (ch1_offset and 2 or 0), 2)
            end
        elseif Game.battle.state == "MENUSELECT" then
            local page = math.ceil(Game.battle.current_menu_y / 3) - 1
            local max_page = math.ceil(#Game.battle.menu_items / 6) - 1

            local x = 0
            local y = 0
            Draw.setColor(Game.battle.encounter:getSoulColor())
            Draw.draw(self.heart_sprite, 5 + ((Game.battle.current_menu_x - 1) * 230), 30 + ((Game.battle.current_menu_y - (page*3)) * 30))

            local font = Assets.getFont("main")
            love.graphics.setFont(font)

            local page_offset = page * 6
            for i = page_offset+1, math.min(page_offset+6, #Game.battle.menu_items) do
                local item = Game.battle.menu_items[i]

                Draw.setColor(1, 1, 1, 1)
                local text_offset = 0
                -- Are we able to select this?
                local able = Game.battle:canSelectMenuItem(item)
                if item.party then
                    if not able then
                        -- We're not able to select this, so make the heads gray.
                        Draw.setColor(COLORS.gray)
                    end
                    -- Head counter
                    local heads = 0
                    for index, party_id in ipairs(item.party) do
                        local chara = Game:getPartyMember(party_id)
                        if Game.battle:getPartyIndex(party_id) ~= Game.battle.current_selecting then
                            heads = heads + 1
                        end
                    end
                    for index, party_id in ipairs(item.party) do
                        local chara = Game:getPartyMember(party_id)
                        -- Draw head only if it isn't the currently selected character
                        if Game.battle:getPartyIndex(party_id) ~= Game.battle.current_selecting then
                            local ox, oy = chara:getHeadIconOffset()
                            local party = 0
                            if heads > 2 then
                                party = heads - 2
                            end
                            Draw.draw(Assets.getTexture(chara:getHeadIcons() .. "/head"), text_offset + 30 + (x * 230) + ox, 50 + (y * 30) + oy + (party ~= 0 and (3.6 + party * 2.3) or 0), 0, 1 / (1 + party * 0.35))
                            text_offset = text_offset + (30 / (1 + party * 0.5))
                        end
                    end
                end
                if item.icons then
                    if not able then
                        -- We're not able to select this, so make the heads gray.
                        Draw.setColor(COLORS.gray)
                    end

                    for _, icon in ipairs(item.icons) do
                        if type(icon) == "string" then
                            icon = {icon, false, 0, 0, nil}
                        end
                        if not icon[2] then
                            local texture = Assets.getTexture(icon[1])
                            Draw.draw(texture, text_offset + 30 + (x * 230) + (icon[3] or 0), 50 + (y * 30) + (icon[4] or 0))
                            text_offset = text_offset + (icon[5] or texture:getWidth())
                        end
                    end
                end

                if able then
                    Draw.setColor(item.color or {1, 1, 1, 1})
                else
                    Draw.setColor(COLORS.gray)
                end
                love.graphics.print(item.name, text_offset + 30 + (x * 230), 50 + (y * 30))
                text_offset = text_offset + font:getWidth(item.name)

                if item.icons then
                    if able then
                        Draw.setColor(1, 1, 1)
                    end

                    for _, icon in ipairs(item.icons) do
                        if type(icon) == "string" then
                            icon = {icon, false, 0, 0, nil}
                        end
                        if icon[2] then
                            local texture = Assets.getTexture(icon[1])
                            Draw.draw(texture, text_offset + 30 + (x * 230) + (icon[3] or 0), 50 + (y * 30) + (icon[4] or 0))
                            text_offset = text_offset + (icon[5] or texture:getWidth())
                        end
                    end
                end

                if x == 0 then
                    x = 1
                else
                    x = 0
                    y = y + 1
                end
            end

            -- Print information about currently selected item
            local tp_offset = 0
            local current_item = Game.battle.menu_items[Game.battle:getItemIndex()]
            if current_item.description then
                Draw.setColor(COLORS.gray)
                love.graphics.print(current_item.description, 260 + 240, 50)
                Draw.setColor(1, 1, 1, 1)
                _, tp_offset = current_item.description:gsub('\n', '\n')
                tp_offset = tp_offset + 1
            end

            if current_item.tp and current_item.tp ~= 0 then
                Draw.setColor(PALETTE["tension_desc"])
                love.graphics.print(math.floor((current_item.tp / Game:getMaxTension()) * 100) .. "% "..Game:getConfig("tpName"), 260 + 240, 50 + (tp_offset * 32))
                Game:setTensionPreview(current_item.tp)
            else
                Game:setTensionPreview(0)
            end

            Draw.setColor(1, 1, 1, 1)
            if page < max_page then
                Draw.draw(self.arrow_sprite, 470, 120 + (math.sin(Kristal.getTime()*6) * 2))
            end
            if page > 0 then
                Draw.draw(self.arrow_sprite, 470, 70 - (math.sin(Kristal.getTime()*6) * 2), 0, 1, -1)
            end

        else
            orig(self, ...) return
        end
    end)
    
    Utils.hook(BattleUI, "init", function(orig, self, ...)
        orig(self, ...)
        
        if #Game.party <= 3 then return end
        
        local x = 0
        local realW = ((SCREEN_WIDTH - 1) / (Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4))
        
        local e = 0
        
        for k,v in ipairs(self.action_boxes) do
            if k > (Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4) then
                v.x = x - e + (Kristal.getLibConfig("moreparty", "classic_mode") and ((6 - #Game.party) * 106.5) or ((8 - #Game.party) * 79.5))
                v.y = Game:getConfig("oldUIPositions") and 36 or 37
                v.realWidth = realW
                x = x + realW
            else
                v.x = x
                v.y = 0
                v.realWidth = realW
                x = x + realW
                e = x
            end
        end
        
        if #Game.battle.party > (Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4) then
            for k,v in ipairs(self.action_boxes) do
                v.y = v.y - (Game:getConfig("oldUIPositions") and 36 or 37)
            end
        end
    end)
    
    Utils.hook(BattleUI, "init", function(orig, self, ...)
        orig(self, ...)
        
        if #Game.party <= (Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4) then return end
        
        self.visible = false

    end)
    
    Utils.hook(BattleUI, "update", function(orig, self, ...)
        orig(self, ...)
        
        if #Game.party <= (Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4) then return end
        
        if Game.battle.current_selecting > 0 then
            self.visible = true
        end
        
        for k,v in ipairs(self.action_boxes) do
            if k == Game.battle.current_selecting then
                v:setLayer(100)
            else
                v:setLayer(-100)
            end
        end

    end)
    
    Utils.hook(Encounter, "getPartyPosition", function(orig, self, index)
        if #Game.battle.party <= 3 then return orig(self, index) end
        
        local x, y = 0, 0
        local column = 0
        local reset = 0
        local middle = 0
        local classic = (Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4)
        if #Game.battle.party > classic then
            if index <= classic then
                column = 80
            else
                reset = classic
                middle = (classic * 2 - #Game.battle.party) * ((Kristal.getLibConfig("moreparty", "classic_mode") and 40 or 35))
            end
        end
        x = 80 + column
        y = (60 / classic) + ((SCREEN_HEIGHT * .5) / classic) * (index - 1 - reset) + middle

        local battler = Game.battle.party[index]
        local ox, oy = battler.chara:getBattleOffset()
        x = x + (battler.actor:getWidth()/2 + ox) * 2
        y = y + (battler.actor:getHeight()  + oy) * 2
        return x, y
    end)
    
    Utils.hook(Battle, "createPartyBattlers", function(orig, self)
        
        for i = 1, #Game.party do
            local party_member = Game.party[i]

            if Game.world.player and Game.world.player.visible and Game.world.player.actor.id == party_member:getActor().id then
                -- Create the player battler
                local player_x, player_y = Game.world.player:getScreenPos()
                local player_battler = PartyBattler(party_member, player_x, player_y)
                player_battler:setAnimation("battle/transition")
                self:addChild(player_battler)
                table.insert(self.party,player_battler)
                table.insert(self.party_beginning_positions, {player_x, player_y})
                self.party_world_characters[party_member.id] = Game.world.player

                Game.world.player.visible = false
            else
                local found = false
                for _,follower in ipairs(Game.world.followers) do
                    if follower.visible and follower.actor.id == party_member:getActor().id then
                        local chara_x, chara_y = follower:getScreenPos()
                        local chara_battler = PartyBattler(party_member, chara_x, chara_y)
                        chara_battler:setAnimation("battle/transition")
                        self:addChild(chara_battler)
                        table.insert(self.party, chara_battler)
                        table.insert(self.party_beginning_positions, {chara_x, chara_y})
                        self.party_world_characters[party_member.id] = follower

                        follower.visible = false

                        found = true
                        break
                    end
                end
                if not found then
                    local chara_battler = PartyBattler(party_member, SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
                    chara_battler:setAnimation("transition")
                    self:addChild(chara_battler)
                    table.insert(self.party, chara_battler)
                    table.insert(self.party_beginning_positions, {chara_battler.x, chara_battler.y})
                end
            end
        end
    end)
    
   Utils.hook(DarkEquipMenu, "init", function(orig, self, ...)
        orig(self, ...)
        if #Game.party <= 3 then return end
      
        self.party:setPosition(-15, 48)
        
        if #Game.party > 4 then
            self.party:setScale(0.5)
        end
   end)
   
   Utils.hook(DarkPowerMenu, "init", function(orig, self, ...)
        orig(self, ...)
        if #Game.party <= 3 then return end
      
        self.party:setPosition(-15, 48)
        
        if #Game.party > 4 then
            self.party:setScale(0.5)
        end
   end)
   
   Utils.hook(OverworldActionBox, "draw", function(orig, self)
        if #Game.party <= 3 then orig(self) return end
        
        local double_row = false
        if #Game.party > (Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4) then
            double_row = true
        end
      
        local parent = self.parent
      
        local x = 0
        -- local w = ((108 * .5) + 212) * 2
        local realW = ((SCREEN_WIDTH - 1) / (Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4))
        local e = 0
        
        for k,v in ipairs(parent.action_boxes) do
            if k > (Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4) then
                v.x = x - e + (Kristal.getLibConfig("moreparty", "classic_mode") and ((6 - #Game.party) * 106.5) or ((8 - #Game.party) * 79.5))
                v.y = 44
                v.realWidth = realW
                x = x + realW
            else
                v.x = x
                v.y = 0
                v.realWidth = realW
                x = x + realW
                e = x
            end
        end
        
        if double_row then
            for k,v in ipairs(parent.action_boxes) do
                v.y = v.y - 44
            end
        end
      
        local string_width = self.font:getWidth(tostring(self.chara:getStat("health")))
        
        -- Draw the line at the top
      
      if self.selected then
          love.graphics.setColor(self.chara:getColor())
      else
          love.graphics.setColor(PALETTE["action_strip"])
      end

      love.graphics.setLineWidth(2)
      love.graphics.line(0, double_row and 20 or 1, realW, double_row and 20 or 1)
      local y_bar = double_row and 36 or 24
      local y_hp = double_row and 24 or 11
      
      if not Kristal.getLibConfig("moreparty", "classic_mode") then
          -- Draw health
          love.graphics.setColor(PALETTE["action_health_bg"])
          love.graphics.rectangle("fill", 118, y_bar, 39, 9)

          local health = (self.chara.health / self.chara:getStat("health")) * 39

          if health > 0 then
              love.graphics.setColor(self.chara:getColor())
              love.graphics.rectangle("fill", 118, y_bar, math.ceil(health), 9)
          end

          local color = PALETTE["action_health_text"]
          if health <= 0 then
              color = PALETTE["action_health_text_down"]
          elseif (self.chara:getHealth() <= (self.chara:getStat("health") / 4)) then
              color = PALETTE["action_health_text_low"]
          else
              color = PALETTE["action_health_text"]
          end

          local health_offset = 0
          health_offset = (#tostring(self.chara.health) - 1) * 8

          love.graphics.setColor(color)
          love.graphics.setFont(self.font)
          love.graphics.print(self.chara.health, 113 - health_offset, y_hp)
          love.graphics.setColor(PALETTE["action_health_text"])
          love.graphics.print("/", 121, y_hp)
          love.graphics.setColor(color)
          love.graphics.print(self.chara:getStat("health"), 159 - string_width, y_hp)
    else
        -- Draw health
        Draw.setColor(PALETTE["action_health_bg"])
        love.graphics.rectangle("fill", 128, y_bar, 76, 9)

        local health = (self.chara:getHealth() / self.chara:getStat("health")) * 76

        if health > 0 then
            Draw.setColor(self.chara:getColor())
            love.graphics.rectangle("fill", 128, y_bar, math.ceil(health), 9)
        end

        local color = PALETTE["action_health_text"]
        if health <= 0 then
            color = PALETTE["action_health_text_down"]
        elseif (self.chara:getHealth() <= (self.chara:getStat("health") / 4)) then
            color = PALETTE["action_health_text_low"]
        else
            color = PALETTE["action_health_text"]
        end

        local health_offset = 0
        health_offset = (#tostring(self.chara:getHealth()) - 1) * 8

        Draw.setColor(color)
        love.graphics.setFont(self.font)
        love.graphics.print(self.chara:getHealth(), 152 - health_offset, y_hp)
        Draw.setColor(PALETTE["action_health_text"])
        love.graphics.print("/", 161, y_hp)
        local string_width = self.font:getWidth(tostring(self.chara:getStat("health")))
        Draw.setColor(color)
        love.graphics.print(self.chara:getStat("health"), 205 - string_width, y_hp)
    end

      -- Draw name text if there's no sprite
      if not self.name_sprite then
          local font = Assets.getFont("name")
          love.graphics.setFont(font)
          love.graphics.setColor(1, 1, 1, 1)

          local name = self.chara:getName():upper()
          local spacing = 5 - name:len()

          local off = 0
          for i = 1, name:len() do
              local letter = name:sub(i, i)
              love.graphics.print(letter, 51 + off, 16 - 1)
              off = off + font:getWidth(letter) + spacing
          end
      end

      local reaction_x = -1

      if self.x == 0 then -- lazy check for leftmost party member
          reaction_x = 3
      end

      love.graphics.setFont(self.main_font)
      love.graphics.setColor(1, 1, 1, self.reaction_alpha / 6)
      if double_row then
        love.graphics.print(self.reaction_text, reaction_x, 46, 0, 0.5, 0.5)
        love.graphics.translate(Kristal.getLibConfig("moreparty", "classic_mode") and 0 or -10, 12)
      else
        love.graphics.print(self.reaction_text, reaction_x, 43, 0, 0.5, 0.5)
        love.graphics.translate(Kristal.getLibConfig("moreparty", "classic_mode") and 0 or -10, 0)
      end
      

        Object.draw(self)
    end)
    
   Utils.hook(HealthBar, "draw", function(orig, self)
        
        if #Game.party <= (Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4) then orig(self) return end
          
        -- Draw the black background
        Draw.setColor(PALETTE["world_fill"])
        love.graphics.rectangle("fill", 0, -23, 640, 124)
          
        Object.draw(self)
   end)
   
   Utils.hook(Shop, "draw", function(orig, self)
   
        if #Game.party <= 4 then orig(self) return end
        
        
        if not (self.state == "BUYMENU") then
            return orig(self)
        end
        self:drawBackground()

        Object.draw(self)

        love.graphics.setFont(self.font)
        if self.state == "BUYMENU" then

            while self.current_selecting - self.item_offset > 5 do
                self.item_offset = self.item_offset + 1
            end

            while self.current_selecting - self.item_offset < 1 do
                self.item_offset = self.item_offset - 1
            end

            if self.item_offset + 5 > #self.items + 1 then
                if #self.items + 1 > 5 then
                    self.item_offset = self.item_offset - 1
                end
            end

            if #self.items + 1 == 5 then
                self.item_offset = 0
            end

            -- Item type (item, key, weapon, armor)
            for i = 1 + self.item_offset, self.item_offset + math.max(4, math.min(5, #self.items)) do
                if i == math.max(4, #self.items) + 1 then break end
                local y = 220 + ((i - self.item_offset) * 40)
                local item = self.items[i]
                if not item then
                    -- If the item is null, add some empty space
                    Draw.setColor(COLORS.dkgray)
                    love.graphics.print("--------", 60, y)
                elseif item.options["stock"] and (item.options["stock"] <= 0) then
                    -- If we've depleted the stock, show a "sold out" message
                    Draw.setColor(COLORS.gray)
                    love.graphics.print("--SOLD OUT--", 60, y)
                else
                    Draw.setColor(item.options["color"])
                    love.graphics.print(item.options["name"], 60, y)
                    if not self.hide_price then
                        Draw.setColor(COLORS.white)
                        love.graphics.print(string.format(self.currency_text, item.options["price"] or 0), 60 + 240, y)
                    end
                end
            end
            Draw.setColor(COLORS.white)
            if self.item_offset == math.max(4, #self.items) - 4 then
                love.graphics.print("Exit", 60, 220 + (math.max(4, #self.items) + 1 - self.item_offset) * 40)
            end
            Draw.setColor(Game:getSoulColor())
            if not self.buy_confirming then
                Draw.draw(self.heart_sprite, 30, 230 + ((self.current_selecting - self.item_offset) * 40))
            else
                Draw.draw(self.heart_sprite, 30 + 420, 230 + 80 + 10 + (self.current_selecting_choice * 30))
                Draw.setColor(COLORS.white)
                local lines = Utils.split(string.format(self.buy_confirmation_text, string.format(self.currency_text, self.items[self.current_selecting].options["price"] or 0)), "\n")
                for i = 1, #lines do
                    love.graphics.print(lines[i], 60 + 400, 420 - 160 + ((i - 1) * 30))
                end
                love.graphics.print("Yes", 60 + 420, 420 - 80)
                love.graphics.print("No",  60 + 420, 420 - 80 + 30)
            end
            Draw.setColor(COLORS.white)

            if (self.current_selecting <= #self.items) then
                local current_item = self.items[self.current_selecting]
                local box_left, box_top = self.info_box:getBorder()

                local left = self.info_box.x - self.info_box.width - (box_left / 2) * 1.5
                local top = self.info_box.y - self.info_box.height - (box_top / 2) * 1.5
                local width = self.info_box.width + box_left * 1.5
                local height = self.info_box.height + box_top * 1.5

                Draw.pushScissor()
                Draw.scissor(left, top, width, height)

                Draw.setColor(COLORS.white)
                love.graphics.print(current_item.options["description"], left + 32, top + 20)

                if current_item.item.type == "armor" or current_item.item.type == "weapon" then
                    for i = 1, #Game.party do
                        -- Turn the index into a 2 wide grid (0-indexed)
                        local transformed_x = (i - 1) % 2
                        local transformed_y = math.floor((i - 1) / 2) - (Kristal.getLibConfig("moreparty", "classic_mode") and 0 or 0.9)

                        -- Transform the grid into coordinates
                        local offset_x = transformed_x * 100
                        local offset_y = transformed_y * (Kristal.getLibConfig("moreparty", "classic_mode") and 26 or 26)

                        local party_member = Game.party[i]
                        local can_equip = party_member:canEquip(current_item.item)
                        local head_path = ""

                        love.graphics.setFont(self.plain_font)
                        Draw.setColor(COLORS.white)

                        if can_equip then
                            head_path = Assets.getTexture(party_member:getHeadIcons() .. "/head")
                            if current_item.item.type == "armor" then
                                Draw.draw(self.stat_icons["defense_1"], offset_x + 470, offset_y + 132 + top)
                                Draw.draw(self.stat_icons["defense_2"], offset_x + 470, offset_y + 145 + top)

                                for j = 1, 2 do
                                    self:drawBonuses(party_member, party_member:getArmor(j), current_item.options["bonuses"], "defense", offset_x + 470 + 21, offset_y + 132 + ((j - 1) * 13) + top)
                                end

                            elseif current_item.item.type == "weapon" then
                                Draw.draw(self.stat_icons["attack"], offset_x + 470, offset_y + 134 + top)
                                Draw.draw(self.stat_icons["magic" ], offset_x + 470, offset_y + 146 + top)
                                self:drawBonuses(party_member, party_member:getWeapon(), current_item.options["bonuses"], "attack", offset_x + 470 + 21, offset_y + 132 + top)
                                self:drawBonuses(party_member, party_member:getWeapon(), current_item.options["bonuses"], "magic",  offset_x + 470 + 21, offset_y + 145 + top)
                            end
                        else
                            head_path = Assets.getTexture(party_member:getHeadIcons() .. "/head_error")
                        end

                        Draw.draw(head_path, offset_x + 426, offset_y + 134 + top)
                    end
                end

                Draw.popScissor()

                Draw.setColor(COLORS.white)

                if not self.hide_storage_text then
                    love.graphics.setFont(self.plain_font)

                    local current_storage = Game.inventory:getDefaultStorage(current_item.item)
                    local space = Game.inventory:getFreeSpace(current_storage)

                    if space <= 0 then
                        love.graphics.print("NO SPACE", 521, 430)
                    else
                        love.graphics.print("Space:" .. space, 521, 430)
                    end
                end
            end
        end

        if self.state == "MAINMENU" or
           self.state == "BUYMENU"  or
           self.state == "SELLMENU" or
           self.state == "SELLING"  or
           self.state == "TALKMENU" then
            Draw.setColor(COLORS.white)
            love.graphics.setFont(self.font)
            love.graphics.print(string.format(self.currency_text, self:getMoney()), 440, 420)
        end

        Draw.setColor(0, 0, 0, self.fade_alpha)
        love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
   end)
    
    print("Loaded MoreParty Library")
end

function Lib:postUpdate()
    if #Game.party > (Kristal.getLibConfig("moreparty", "classic_mode") and 6 or 8) then -- Prevents the library from running where they're more party members than supported
        local add = ""
        if Kristal.getLibConfig("moreparty", "classic_mode") then
            add = " Try disabling 'classic_mode' in lib.json."
        end
        error("Too many party members than the MoreParty library can support." .. add)
    end
end

return Lib

-- Debug Stuff

-- local keysString = ""
-- for key, value in pairs(parent) do
  -- keysString = keysString .. key .. " "
-- end
-- error(keysString)