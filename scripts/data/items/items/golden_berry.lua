-- Create an item and specify its ID (id is optional, defaults to file path)
local item, super = Class(HealItem, "golden_berry")

function item:init()
    super:init(self)

     -- Display name
    self.name = "GoldenBerry"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Heals\nMax HP"
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "An extremely rare berry you can't buy anywhere."

    -- Amount healed (HealItem variable)
    self.heal_amount = 999999

    -- Shop buy price
    self.buy_price = 500
    -- Shop sell price (usually half of buy price)
    self.sell_price = 150

    -- Consumable target mode (Should be party)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none/nil)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Character reactions (key = party member id)
    self.reactions = {
        jamm = "HAPPY 1 YEAR, DEOXYNN!",
        dess = "ew fruit",
        mario = "Blech! That tastes like shit!",
        brenda = "Is that gold paint?",
    }
end

return item
