local item, super = Class(Item, "heart_locket")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Heart Locket"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Default shop sell price
    self.sell_price = 250
    -- Whether the item can be sold
    self.can_sell = true

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A heart-shaped locket that can be opened.\nInside it says \"Best Friends Forever.\""

    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil

    self.bonuses = {
        defense = 7
    }

    self.can_equip = {
        susie = false,
        mario = false,
    }

    self.reactions = {
        susie = "I don't want that!",
        kris = "?",
        noelle = "Wait is that...?",
        dess = "Wanna eat flowers?",
        berdly = {
            berdly = "Who are those kids...?",
            susie = "They look like Kris...",
            noelle = "And Asriel..."
        },
        mario = "Bleh!",
        brenda = "Oh god why is it beating.",
        ceroba = "Reminds me of Kanako...",
        noel = "oh... you found it...",
    }

    self.light_item = "ut_armors/heart_locket"
end

return item