local spell, super = Class(Spell, "ultimate_shoot")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "UltimatShoot"
    -- Name displayed when cast (optional)
    self.cast_name = "ULTIMATESHOOT"

    -- Battle description
    self.effect = "MURDER"
    -- Menu description
    self.description = "HOYL FUCK DID YOU JUST KILL SOMEONE OH MY GOD WHAT THE FUCK ARE YOU DOING"

    -- TP cost
    self.cost = 15

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"

    -- Tags that apply to this spell
    self.tags = {"murder"}
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
        user:setAnimation("battle/spell", finishAnim)
    end
    Game.battle.timer:after(1, function()
        Assets.playSound("rudebuster_swing")
        local x, y = user:getRelativePos(user.width, user.height/2 + 5, Game.battle)
        local tx, ty = target:getRelativePos(target.width/2, target.height/2, Game.battle)
        local blast = UltimatBeam(false, x, y, tx, ty, function(pressed)
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