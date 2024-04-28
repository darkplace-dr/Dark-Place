local item, super = Class(HealItem, "borstuff/substance")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Substance"
    -- Name displayed when used in battle (optional)
    self.use_name = nil

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Damages\n5 HP"
    -- Shop description
    self.shop = "Legal.\nProbably.\nI think"
    -- Menu description
    self.description = "Nah, come on, man. Some straight like you,\ngiant stick up his ass all a sudden at\nage, what, 60, he's just gonna break bad?"

    -- Amount healed (HealItem variable)
    self.heal_amount = -5

    -- Default shop price (sell price is halved)
    self.price = 2
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {}
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}

    -- Character reactions (key = party member id)
    self.reactions = {
        susie = "W-HUH?! WHAT THE HELL?!",
        ralsei = "I've already had my fair share of this, haha.",
        noelle = "(WHERE THE FUCK DID YOU GET COCAINE)",
        kris = "yummy",
        brenda = "So... This IS legal here, right?",
        bor = "What? You want more o' that?",
        dess = "AYYYYY LETST GET FUCJKKED BABY!!!! WOSAAAAAAAAHSDFHGSDJFHK",
        berdly = "I-W-What?! I'm sorry, my friend. But even a GAMER has STANDARS.",
		jamm = "A friend with herb is a true friend.",
		mario = "Mario's got to piss."
    }
end

return item