local item, super = Class(HealItem, "granola_bar")

function item:init()
    super.init(self)

    self.name = "Granola Bar"
    self.use_name = nil

    self.type = "item"
    self.icon = nil

    self.effect = "Heals\n60HP"
    self.shop = nil
    self.description = "A healthy stick of grain.\n+60HP"

    self.heal_amount = 60

    self.price = 40
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