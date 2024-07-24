local spell, super = Class(Spell, "friend_buster")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Friend Buster"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = "Rude\nDamage"
    -- Menu description
    self.description = "Deals moderate Rude-elemental damage to\none friend. Depends on Attack & Magic."

    -- TP cost
    self.cost = 50

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"

    -- Tags that apply to this spell
    self.tags = {"rude", "damage"}
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
            local damage = math.ceil((user.chara:getStat("magic") * 5) + (user.chara:getStat("attack") * 11) - (target.chara:getStat("defense") * 3))
            if pressed then
                damage = damage + 30
                Assets.playSound("scytheburst")
            end
            if user.chara:checkWeapon("virobuster") then
                if target.health <= target.chara:getStat("health") / 2 then
                    damage = damage * 2
                end
            end
            target:flash()
            target:hurt(damage, true)
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

function spell:hasWorldUsage(chara)
    return true
end

function spell:onWorldCast(chara)
    Assets.playSound("scytheburst")
    local damage = 250
    Game.world:hurt(chara, damage)
end

return spell