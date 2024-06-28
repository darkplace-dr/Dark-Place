local spell, super = Class(Spell, "soul_send")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Life Giver"
    -- Name displayed when cast (optional)
    self.cast_name = "the thing that kills them for some reason!!"

    -- Battle description
    self.effect = "Heal\nAlly?"
    -- Menu description
    self.description = "* This is a weird ass spell.\nLike, it heals only one guy and then I die.\nsmh my head.."

    -- TP cost
    self.cost = 1


    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    --self.target2 = "self"

    -- Tags that apply to this spell
    self.tags = {"heal"}
    --self.tags = {"hurt"}
end

function spell:onCast(user, target)
    Assets.playSound("break1")
    target:heal(user.chara:getStat("magic") *25)
    user:hurt(user.chara:getStat("magic") *2.5)
end

return spell