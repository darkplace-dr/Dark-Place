local item, super = Class(Item, "patient_blade")

function item:init()
    super.init(self)

    -- Display name
    self.name = "PatientBlade"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/sword"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = "...\na virtue."
    -- Menu description
    self.description = "I hope this was worth it.\nGives more TP when guarding."

    -- Default shop price (sell price is halved)
    self.price = 500
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
        attack = 7,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Patience UP"
    self.bonus_icon = "ui/menu/icon/up"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        kris = true,
        YOU = true
    }

    -- Character reactions
    self.reactions = {
        susie = "Wow, this is awful.", --someone would yell at me if I kept the original reaction for Susie
        ralsei = "I can't handle the anticipation!",
        noelle = "... ... ...",
        brenda = "This was NOT worth it.",
		jamm = "What? I'm not a patient guy."
    }
	
end

function item:convertToLightEquip(chara)
    return "light/illegal_pencil"
end

function item:onBattleUpdate(battler)
	--if Game.battle:getActionBy(battler) == "DEFEND" then
		--Game.battle.tension = Game.battle.tension + 100
	--end
end

return item