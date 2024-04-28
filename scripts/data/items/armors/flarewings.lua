local item, super = Class(Item, "flarewings")

function item:init()
    super.init(self)

    -- Display name
    self.name = "FlareWings"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Wings that are made of purple flames.\nNot good for flying, but damage is reflected."

    -- Default shop price (sell price is halved)
    self.price = 0
    -- Whether the item can be sold
    self.can_sell = false

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
        defense = 6,
        magic = 2,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Counter"
    self.bonus_icon = "ui/menu/icon/fire"

    self.thorns_chance = 1
    self.thorns_damage_proportion = 0.4

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}

    -- Character reactions
    self.reactions = {
        susie = "Hell yeah, these are so badass!",
        ralsei = "I'm so sweaty...",
        noelle = "J-Jeez, they're kind of hot...", -- Not in THAT way you pervert >:[
        dess = "wouldn't it be funny if i conquered the universe with these?",
        brenda = "Thankfully the crown isn't included."
    }
end

return item