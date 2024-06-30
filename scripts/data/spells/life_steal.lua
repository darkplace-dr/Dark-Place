local spell, super = Class(Spell, "life_steal")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Life Steal"
    -- Name displayed when cast (optional)
    self.cast_name = "the thing that hurts people"

    -- Battle description
    self.effect = "Steal\nhealth?"
    -- Menu description
    self.description = "* I AM THE DRACULA!!!\nGIVE ME YOUR HEALTH POINTS!!!!"

    -- TP cost
    self.cost = 20


    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy" or "ally"
    --self.target2 = "self"

    -- Tags that apply to this spell
    self.tags = {"hurt", "fatal"}
    --self.tags = {"hurt"}
end

function spell:onCast(user, target)
    Assets.playSound("voice/noel-'")
    Assets.playSound("break2")
    target:hurt(user.chara:getStat("magic") * 20 + 10)
    user:heal(user.chara:getStat("magic") * 20 + 10)
end

return spell