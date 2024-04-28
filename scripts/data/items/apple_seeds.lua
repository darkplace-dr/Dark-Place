-- Instead of Item, create a HealItem, a convenient class for consumable healing items
local item, super = Class(HealItem, "apple_seeds")

function item:init()
    super.init(self)

    -- Display name
    self.name = "AppleSeeds"
    -- Name displayed when used in battle (optional)
    self.use_name = "APPLE SEEDS"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Hurts\n?? HP"
    -- Shop description
    self.shop = nil
    -- Menu description
    self.description = "Some apple seeds. You definitely shouldn't eat these. -?? HP"

    -- Amount healed (HealItem variable)
    self.heal_amount = nil

    -- Default shop price (sell price is halved)
    self.price = 0
    -- Whether the item can be sold
    self.can_sell = false

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
        susie = "These taste... not bad?",
        ralsei = "I don't feel so well...",
        noelle = "(I feel like I'm gonna puke...)",
		dess= "yummy cyanide",
        brenda = "Why did I eat that?",
		jamm = "I could've used those for my sling..."
    }
end

function item:onWorldUse(target)
    local health_dec = 20
    if target.id == "susie" or target.id == "dess" then
        health_dec = 15
    elseif target.id == "ralsei" then
        health_dec = 30
    elseif target.id == "YOU" then
        health_dec = 50
	elseif target.id == "dess" then
        health_dec = -10
    elseif target.id == "jamm" then
        health_dec = 40
    end
    target.health = math.max(1, target.health - health_dec)
    Assets.playSound("hurt")
    return true
end

function item:onBattleUse(user, target)
    target:heal(20, {1, 0, 1})
    Assets.playSound("hurt")

    if target.poison_effect_timer then
        Game.battle.timer:cancel(target.poison_effect_timer)
    end

    local poison_left = 40
    target.poison_effect_timer = Game.battle.timer:every(10/30, function()
        if poison_left == 0 then
            return false
        end
        local char_health = target.chara:getHealth()
        if char_health > 1 then
            target.chara:setHealth(char_health - 1)
            poison_left = poison_left - 1
        else
            poison_left = 0
            return false
        end
    end)
end

return item
