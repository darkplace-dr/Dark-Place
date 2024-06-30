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
        susie = "A stick with a ribbon? Seriously?",
        ralsei = "Not sure if I can use this...",
        martlet = "This belongs to Ceroba...",
        noel = "I prefer cats... (I WANT IT!!!)",
        noelle = "*ding* I love the bell!",
        ceroba = "Back where it belongs.",
    }
end

function item:convertToLightEquip(chara)
    return "light/cerobas_staff"
end

return item