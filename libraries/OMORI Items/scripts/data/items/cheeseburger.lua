local item, super = Class(HealItem, "cheeseburger")

function item:init()
    super.init(self)

    self.name = "Cheeseburger"
    self.use_name = nil

    self.type = "item"
    self.icon = nil

    self.effect = "Heals\n250HP"
    self.shop = nil
    self.description = "Contains all food groups, so it's healthy!\n+250HP"

    self.heal_amount = 250

    self.price = 300
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