local spell, super = Class(Spell, "strainer")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "skldfkopw"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = "Enemy\ngo ouch"
    -- Menu description
    self.description = "Susie spent many hours coming up with this\nattack's name. When utilized, enemies go ouch."

    -- TP cost
    self.cost = 50

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"

    -- Tags that apply to this spell
    self.tags = {"rude", "damage"}
end

local function isRSusieLv20andUp()
    local sus = Game:getPartyMember("robo_susie")
    return sus and sus.level >= 20
end

function spell:getName()
    return not isRSusieLv20andUp() and "skldfkopw" or "Strainer"
end

function spell:getDescription()
    return not isRSusieLv20andUp()
        and "Susie spent many hours coming up with this\nattack's name. When utilized, enemies go ouch."
        or "In your absence, Susie refined the spell's name.\nWhen used, hurt ensues."
end

function spell:getBattleDescription()
    return not isRSusieLv20andUp()
        and "Enemy\ngo ouch"
        or "Enemy\nKiller"
end

function spell:getCastMessage(user, target)
    return "* "..user.chara:getName().." used "..self:getCastName().."!"
end

function spell:getTPCost(chara)
    local cost = super.getTPCost(self, chara)
    if chara and chara:checkWeapon("devilsknife") then
        cost = cost - 10
    end
    return cost
end

function spell:onCast(user, target)
    local buster_finished = false
    local anim_finished = false
    local function finishAnim()
        anim_finished = true
        if buster_finished then
            Game.battle:finishAction()
        end
    end
    if not user:setAnimation("battle/rude_buster", finishAnim) then
        anim_finished = false
        user:setAnimation("battle/attack", finishAnim)
    end
    Game.battle.timer:after(15/30, function()
        Assets.playSound("rudebuster_swing")
        local x, y = user:getRelativePos(user.width, user.height/2 - 10, Game.battle)
        local tx, ty = target:getRelativePos(target.width/2, target.height/2, Game.battle)
        local blast = RudeBusterBeam(false, x, y, tx, ty, function(pressed)
            local damage = math.ceil((user.chara:getStat("magic") * 5) + (user.chara:getStat("attack") * 11) - (target.defense * 3))
            if pressed then
                damage = damage + 30
                Assets.playSound("scytheburst")
            end
            target:flash()
            target:hurt(damage, user)
            buster_finished = true
            if anim_finished then
                Game.battle:finishAction()
            end
        end)
        blast.layer = BATTLE_LAYERS["above_ui"]
        Game.battle:addChild(blast)
    end)
    return false
end

return spell