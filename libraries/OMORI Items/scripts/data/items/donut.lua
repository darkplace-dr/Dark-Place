local item, super = Class(HealItem, "donut")

function item:init()
    super.init(self)

    self.name = "Donut"
    self.use_name = nil

    self.type = "item"
    self.icon = nil

    self.effect = "Heals\n60%HP"
    self.shop = nil
    self.description = "Circular bread with a hole in it.\n+60%HP"

    self.heal_amount = nil

    self.price = 150
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
    local amount = target:getStat("health") * 0.6
    Game.world:heal(target, amount)
    return true
end

function item:onBattleUse(target)
    local amount = target:getStat("health") * 0.6
    target:heal(amount)
end

return item