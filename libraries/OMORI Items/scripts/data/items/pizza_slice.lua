local item, super = Class(HealItem, "pizza_slice")

function item:init()
    super.init(self)

    self.name = "Pizza Slice"
    self.use_name = nil

    self.type = "item"
    self.icon = nil

    self.effect = "Heals\n175HP"
    self.shop = nil
    self.description = "1/8th of a Whole Pizza.\n+175HP"

    self.heal_amount = 175

    self.price = 250
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