local spell, super = Class(Spell, "wavedash")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Wavedash"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = "Elec\nDamage"
    -- Menu description
    self.description = "Wave-Dashes and deals moderate damage to one\nfoe. Depends on Attack & Magic."

    -- TP cost
    self.cost = 24

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"

    -- Tags that apply to this spell
    self.tags = {"electric", "damage"}
end

function spell:getCastMessage(user, target)
    return "* "..user.chara:getName().." used "..self:getCastName().."!"
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
    Game.battle.timer:after(0.5, function()
        Assets.playSound("halberd_flash")
    end)
    Game.battle.timer:after(1, function()
        Assets.playSound("rudebuster_swing")
        local x, y = user:getRelativePos(user.width, user.height/2 - 10, Game.battle)
        local tx, ty = target:getRelativePos(target.width/2, target.height/2, Game.battle)
        local blast = WavedashBeam(false, x, y, tx, ty, function(pressed)
            local damage = math.ceil((user.chara:getStat("magic") * 4) + (user.chara:getStat("attack") * 9) - (target.defense * 3))
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