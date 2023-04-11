local item, super = Class(HealItem, "fries")

function item:init()
    super.init(self)

    self.name = "Fries"
    self.use_name = nil

    self.type = "item"
    self.icon = nil

    self.effect = "Heals\nteam\n60HP"
    self.shop = nil
    self.description = "From France, wherever that is...\nParty +60HP"

    self.heal_amount = 60

    self.price = 200
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