local item, super = Class(Item, "voidaxe")

function item:init()
    super.init(self)

    self.name = "VoidAxe"

    self.type = "weapon"
    self.icon = "ui/menu/icon/axe"

    self.effect = ""
    self.shop = ""
    self.description = "An axe forged from the nothingness of the void.\nGrants high attack but lowers defense."

    self.price = 1500
    self.can_sell = true

    self.target = "none"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {
        attack = 15,
        defense = -5
    }
    self.bonus_name = "Defense DOWN"
    self.bonus_icon = "ui/menu/icon/down"

    self.can_equip = {
        susie = true,
    }

    self.reactions = {
        susie = "Feels weightless.",
        ralsei = "I know I'm the prince of darkness, but...",
        noelle = "It feels... cold?",
		dess = "no way jose",
        brenda = "... No.",
    }
end

return item