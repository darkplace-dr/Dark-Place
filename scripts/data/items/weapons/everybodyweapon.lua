local item, super = Class("everybodyweapon", true)

function item:init()
    super.init(self)

    self.can_equip = Utils.merge(self.can_equip, {
        noel = false,
    })

    self.reactions = Utils.merge(self.reactions, {
        noel = "(SO COOL!) I... can't...",
    })
end

function item:canEquip(character, slot_type, slot_index)
    if self.can_equip[character.id] then
        return self.can_equip[character.id] 
    else
        return true
    end
end

return item