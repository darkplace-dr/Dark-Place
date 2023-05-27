local item, super = Class(Item, "ironhook")

function item:init()
    super.init(self)

    -- Display name
    self.name = "IronHook"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/scythe"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A stylish metal hook with for the\ncold and stylish ones!"

    -- Default shop price (sell price is halved)
    self.price = 60
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "none"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {
        attack = 0,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        charkis = true,
        dess = true,
        alseri = true,
        noelle = true
    }

    -- Character reactions
    self.reactions = {
        susie = "Who do you think I am, a pirate?",
        charkis = "The original!",
        brandon = "I'm sticking to the gun, yes?",
        bor = "nah blud too late",
        dess = "well this IS! better than a friging baseball bat......",
        alseri = "Ooh, cold and stylish! Just like me!",
        goobert = "gooberth     pass",
        robo_susie = "I've already got enough metallic material on me.",
        noyno = "Nope, I ain't using this! Nope I say!!",
        ralsei = "(It's... cold...)",
        noelle = "...",
    }
end

return item