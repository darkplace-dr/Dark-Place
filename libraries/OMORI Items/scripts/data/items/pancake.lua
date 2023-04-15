local item, super = Class(HealItem, "pancake")

function item:init()
    super.init(self)

    self.name = "Pancake"
    self.use_name = nil

    self.type = "item"
    self.icon = nil

    self.effect = "Heals\n150HP"
    self.shop = nil
    self.description = "Not designed to hold syrup...\n+150HP"

    self.heal_amount = 150

    self.price = 200
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