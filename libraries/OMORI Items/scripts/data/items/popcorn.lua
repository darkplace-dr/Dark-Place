local item, super = Class(HealItem, "popcorn")

function item:init()
    super.init(self)

    self.name = "Popcorn"
    self.use_name = nil

    self.type = "item"
    self.icon = nil

    self.effect = "Heals\nteam\n35HP"
    self.shop = nil
    self.description = "9/10 dentists hate it.\nParty +35HP"

    self.heal_amount = 35

    self.price = 150
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