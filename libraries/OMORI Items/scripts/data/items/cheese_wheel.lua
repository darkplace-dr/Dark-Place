local item, super = Class(HealItem, "cheese_wheel")

function item:init()
    super.init(self)

    self.name = "Cheese Wheel"
    self.use_name = nil

    self.type = "item"
    self.icon = nil

    self.effect = "Heals\nteam\n100HP"
    self.shop = nil
    self.description = "Delicious, yet functional.\nParty +100HP"

    self.heal_amount = 100

    self.price = 250
    self.can_sell = true

    self.target = "party"
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