local item, super = Class(HealItem, "chicken_wing")

function item:init()
    super.init(self)

    self.name = "Chicken Wing"
    self.use_name = nil

    self.type = "item"
    self.icon = nil

    self.effect = "Heals\n80HP"
    self.shop = nil
    self.description = "Wing of chicken.\n+80HP"

    self.heal_amount = 80

    self.price = 100
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

return item