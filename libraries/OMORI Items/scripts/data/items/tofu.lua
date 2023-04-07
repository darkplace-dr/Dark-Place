local item, super = Class(HealItem, "tofu")

function item:init()
    super.init(self)

    self.name = "Tofu"
    self.use_name = nil

    self.type = "item"
    self.icon = nil

    self.effect = "Heals\n5HP"
    self.shop = nil
    self.description = "Soft cardboard, basically.\n+5HP"

    self.heal_amount = 5

    self.price = 2
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