local item, super = Class(HealItem, "synthsoda")

function item:init()
    super.init(self)

    -- Display name
    self.name = "SynthSoda"
    -- Name displayed when used in battle (optional)
    self.use_name = nil

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Heals\n100 HP"
    -- Shop description
    self.shop = "Aesthetic\nsoft drink.\nHeals 100HP"
    -- Menu description
    self.description = "A vibrant soft drink with an aesthetic aftertaste. Makes music with each use. +100HP"

    -- Amount healed (HealItem variable)
    self.heal_amount = 100

    -- Default shop price (sell price is halved)
    self.price = 200
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
    self.can_equip = {}

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "The aftertaste packs a punch.",
        ralsei = "How elegant!",
        noelle = "Such a soothing sound...",
		jamm = "Ooh! Spine tingling, I love it!"
    }

    self.sounds = {
        ["kris"] = "synthsoda/kris",
        ["susie"] = "synthsoda/susie",
        ["ralsei"] = "synthsoda/ralsei",
        ["noelle"] = "synthsoda/noelle",
		["YOU"] = "synthsoda/you",
		["brenda"] = "synthsoda/brenda",
		["dess"] = "synthsoda/dess",
		["jamm"] = "synthsoda/jamm",
    }
end

function item:getShopDescription()
    -- Don't automatically add item type
    return self.shop
end

function item:onWorldUse(target)
    local sound = self.sounds[target.id] or ("cd_bagel/"..target.id)
    if Assets.getSound(sound) then
        Assets.playSound(sound)
    end
    return super.onWorldUse(self, target)
end

return item
