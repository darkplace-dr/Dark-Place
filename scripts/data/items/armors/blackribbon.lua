local item, super = Class(Item, "blackribbon")

function item:init()
    super.init(self)

    self.name = "BlackRibbon"

    self.type = "armor"
    self.icon = "ui/menu/icon/armor"

    self.effect = ""
    self.shop = ""
    self.description = "A pitch black ribbon.\nIncreases graze area by a lot."

    self.price = 400
    self.can_sell = true

    self.target = "none"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {
        defense = 6,

        graze_size = 0.5,
    }
    self.bonus_name = "GrazeArea"
    self.bonus_icon = "ui/menu/icon/up"

    self.can_equip = {
        susie = false,
        brenda = false
    }

    -- Character reactions
    self.reactions = {
        susie = "I DON'T WEAR RIBBONS!",
        ralsei = "This goes good with my robe!",
        noelle = "Feels like something Catti would wear...",
        dess = "i am goth now",
        brenda = "Black isn't really my style.",
    }
end

return item