local item, super = Class(Item, "cerobas_staff")

function item:init()
    super.init(self)

    self.name = "Ceroba's Staff"

    self.type = "weapon"
    self.icon = "ui/menu/icon/staff"

    self.effect = ""
    self.shop = ""
    self.description = "Made by Ceroba Ketsukane.\nHas multiple powerful abilities."

    self.price = 400
    self.can_sell = true

    self.target = "none"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {
        attack = 2,
        magic = 3,
    }

    self.can_equip = {
        ceroba = true,
    }

    self.reactions = {
        susie = "A stick? Seriously?",
        ralsei = "Not sure if I can use this...",
        noelle = "How is that a weapon?",
        ceroba = "Back to where it belongs.",
        martlet = "This belongs to Ceroba...",
    }
end

return item