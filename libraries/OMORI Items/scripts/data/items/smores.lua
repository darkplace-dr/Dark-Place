local item, super = Class(HealItem, "smores")

function item:init()
    super.init(self)

    self.name = "Smores"
    self.use_name = nil

    self.type = "item"
    self.icon = nil

    self.effect = "Heals\n50HP"
    self.shop = nil
    self.description = "S'more smores, please!\n+50HP"

    self.heal_amount = 50

    self.price = 60
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