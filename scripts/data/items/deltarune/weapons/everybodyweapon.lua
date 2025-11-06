local item, super = Class("everybodyweapon", true)

function item:init()
    super.init(self)

    self.can_equip = TableUtils.merge(self.can_equip, {
        noel = false,
    })

    self.reactions = TableUtils.merge(self.reactions, {
        noel = "(SO COOL!) I... can't...",
    })
end

function item:canEquip(character, slot_type, slot_index)
    if character.id == "noel" then
        return false
    else
        return true
    end
end

return item