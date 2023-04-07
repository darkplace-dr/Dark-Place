local item, super = Class(HealItem, "chocolate")

function item:init()
    super.init(self)

    self.name = "Chocolate"
    self.use_name = nil

    self.type = "item"
    self.icon = nil

    self.effect = "Heals\n40%HP"
    self.shop = nil
    self.description = "Chocolate!? Oh, it's baking chocolate...\n+40%HP"

    self.heal_amount = nil

    self.price = 50
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
    local amount = target:getStat("health") * 0.4
    Game.world:heal(target, amount)
    return true
end

function item:onBattleUse(target)
    local amount = target:getStat("health") * 0.4
    target:heal(amount)
end

return item