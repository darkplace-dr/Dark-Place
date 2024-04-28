-- Instead of Item, create a HealItem, a convenient class for consumable healing items
local item, super = Class(HealItem, "gemapple")

function item:init()
    super.init(self)

    -- Display name
    self.name = "GemApple"
    -- Name displayed when used in battle (optional)
    self.use_name = "GEM APPLE"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Comletely\nuseless"
    -- Shop description
    self.shop = "You gotta buy\nthese!"
    -- Menu description
    self.description = "An apple made of gemstone.\nCompletely useless."

    -- Default shop price (sell price is halved)
    self.price = 500
    -- Whether the item can be sold
    self.can_sell = true
    
    self.refundable = false

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = "gemapple"
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
        susie = "ARGH! I think I chipped a tooth!",
        ralsei = "Um, I don't think I can eat this...",
        noelle = "Did we get scammed?",
        dess = "fucking microtransactions",
        brenda = "The hell am I supposed to do with this?!",
		jamm = "Why don't we just cut our losses and sell it next time?"
    }
end

function item:getBattleText(user, target)
    return
        "* "..user.chara:getName().." used the "..self:getUseName().."!"
        .."\n* ...but nothing happened."
end

function item:onWorldUse(target)
    if target.id ~= "susie" then
        return true
    end
    target:setHealth(math.max(1, target:getHealth() - 1))
    Assets.playSound("hurt")
    return true
end

return item
