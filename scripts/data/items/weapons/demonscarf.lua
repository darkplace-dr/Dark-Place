local item, super = Class(Item, "demonscarf")

function item:init()
    super.init(self)

    -- Display name
    self.name = "DemonScarf"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/scarf"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = "Extremely\nevil."
    -- Menu description
    self.description = "A blatantly evil scarf.\nWho made this??"

    -- Default shop price (sell price is halved)
    self.price = 950
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "none"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {
        attack = 12,
        magic  = 18,
		health = -100,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Demonic"
    self.bonus_icon = "ui/menu/icon/demon"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        ralsei = true,
    }

    -- Character reactions
    self.reactions = {
        susie = "...this is too evil, even for me.",
        ralsei = "...o- okay????",
        noelle = "That thing is scary!",
        dess = "ahh evil scary demon",
        brenda = "Somebody get me some holy water.",
        noel = "(Don't eat it, Don't eat it, Don't eat it, Don't eat it, Don't eat it.)",
		jamm = "Is this Nyarla's? No? Okay then."
    }
end

function item:onEquip(character)
    character:setHealth(math.max(1, character:getHealth() - 100))
    Assets.playSound("hurt")
    return true
end

return item
