local item, super = Class(HealItem, "spaghetti")

function item:init()
    super.init(self)

    self.name = "Spaghetti"
    self.use_name = nil

    self.type = "item"
    self.icon = nil

    self.effect = "Heals\n100%HP"
    self.shop = nil
    self.description = "Wet noodles slathered with chunky\nsauce. +100%HP"

    self.heal_amount = nil

    self.price = 500
    self.can_sell = true

    self.target = "ally"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {}
    self.bonus_name = nil
    self.bonus_icon = nil

    self.can_equip = {}

    self.reactions = {
        susie = "",
        ralsei = "",
        noelle = ""
    }
end

function item:onWorldUse(target)
    local amount = target:getStat("health")
    Game.world:heal(target, amount)
    return true
end

function item:onBattleUse(target)
    local amount = target:getStat("health")
    target:heal(amount)
end

return item