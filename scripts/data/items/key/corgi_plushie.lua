local item, super = Class(Item, "corgi_plush")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Corgi Plushie"
    -- Name displayed when used in battle (optional)
    self.use_name = nil

    -- Item type (item, key, weapon, armor)
    self.type = "key"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = "It Talks!"
    -- Menu description
    self.description = "A replica plushie of the Annoying Strawberry Corgi. It can talk too!"

    -- Default shop price (sell price is halved)
    self.price = 750
    -- Whether the item can be sold
    self.can_sell = false

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "none"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "world"
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
    self.can_equip = {}

    -- Character reactions (key = party member id)
    self.reactions = {}
end

function item:onWorldUse()
    Assets.playSound("dog_yip")
end

function item:convertToLight(inventory)
    return "light/old_cartridge"
end

return item
