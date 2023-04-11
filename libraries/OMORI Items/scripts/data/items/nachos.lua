local item, super = Class(HealItem, "nachos")

function item:init()
    super.init(self)

    self.name = "Nachos"
    self.use_name = nil

    self.type = "item"
    self.icon = nil

    self.effect = "Heals\n75HP"
    self.shop = nil
    self.description = "Suggested serving size: 6-8 nachos.\n+75HP"

    self.heal_amount = 75

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