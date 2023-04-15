local item, super = Class(HealItem, "hot_dog")

function item:init()
    super.init(self)

    self.name = "Hot Dog"
    self.use_name = nil

    self.type = "item"
    self.icon = nil

    self.effect = "Heals\n100HP"
    self.shop = nil
    self.description = "Better than a cold dog.\n+100HP"

    self.heal_amount = 100

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

return item