local item, super = Class(HealItem, "fish_taco")

function item:init()
    super.init(self)

    self.name = "Fish Taco"
    self.use_name = nil

    self.type = "item"
    self.icon = nil

    self.effect = "Heals\n200HP"
    self.shop = nil
    self.description = "Aquatic taco.\n+200HP"

    self.heal_amount = 200

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