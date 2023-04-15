local item, super = Class(HealItem, "whole_pizza")

function item:init()
    super.init(self)

    self.name = "Whole Pizza"
    self.use_name = nil

    self.type = "item"
    self.icon = nil

    self.effect = "Heals\nteam\n250HP"
    self.shop = nil
    self.description = "8/8ths of a Whole Pizza.\nParty +250HP"

    self.heal_amount = 250

    self.price = 500
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