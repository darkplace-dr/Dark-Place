-- Instead of Item, create a HealItem, a convenient class for consumable healing items
local item, super = Class(HealItem, "corruptbit")

function item:init()
    super.init(self)

    -- Display name
    self.name = "CorruptBit"
    -- Name displayed when used in battle (optional)
    self.use_name = "HEALITEM"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "self.heal_amount = love.math.random(-100,100)"
    -- Shop description
    self.shop = "🕆︎☠︎☞︎✋︎☠︎✋︎💧︎☟︎☜︎👎︎\n☟︎☜︎✌︎☹︎✋︎❄︎☜︎💣︎\n🖃︎✍︎✍︎ ☟︎🏱︎"
    -- Menu description
    self.description = "🕆︎☠︎☞︎✋︎☠︎✋︎💧︎☟︎☜︎👎︎\n☟︎☜︎✌︎☹︎✋︎❄︎☜︎💣︎\n🖃︎✍︎✍︎ ☟︎🏱︎"

    -- Amount healed (HealItem variable) (It's "broken" on purpose)
    self.heal_amount = love.math.random(-100,100)

    -- Default shop price (sell price is halved)
    self.price = love.math.random(-100,100)
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {}
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {"dess"}

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "Pain-food. cool.",
        ralsei = "I can't taste anything.",
        noelle = "(Is this even edible?)",
        dess = "lmao it hurts",
    }
end

return item
