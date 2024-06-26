local item, super = Class(HealItem, "berdly_tea")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Berdly Tea"
    -- Name displayed when used in battle (optional)
    self.use_name = nil

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Healing\nvaries"
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "It's own-flavored tea.\nThe flavor just says \"Berdly.\""
    -- Amount healed (HealItem variable)
    self.heal_amount = 50
    -- Amount this item heals for specific characters
    -- Party member this tea is from
    local tea_self = "berdly"

    self.heal_amounts = {
        ["YOU"] = Game:getPartyMember("YOU"):getOpinion(Game:getPartyMember(tea_self)),
        ["kris"] = Game:getPartyMember("kris"):getOpinion(Game:getPartyMember(tea_self)),
        ["susie"] = Game:getPartyMember("susie"):getOpinion(Game:getPartyMember(tea_self)),
        ["noelle"] = Game:getPartyMember("noelle"):getOpinion(Game:getPartyMember(tea_self)),
        ["dess"] = Game:getPartyMember("dess"):getOpinion(Game:getPartyMember(tea_self)),
        ["brenda"] = Game:getPartyMember("brenda"):getOpinion(Game:getPartyMember(tea_self)),
        ["dumbie"] = Game:getPartyMember("dumbie"):getOpinion(Game:getPartyMember(tea_self)),
        ["ostarwalker"] = Game:getPartyMember("ostarwalker"):getOpinion(Game:getPartyMember(tea_self)),
        ["berdly"] = 10,
        ["bor"] = Game:getPartyMember("bor"):getOpinion(Game:getPartyMember(tea_self)),
        ["robo_susie"] = Game:getPartyMember("robo_susie"):getOpinion(Game:getPartyMember(tea_self)),
        ["noyno"] = Game:getPartyMember("noyno"):getOpinion(Game:getPartyMember(tea_self)),
        ["iphone"] = Game:getPartyMember("iphone"):getOpinion(Game:getPartyMember(tea_self)),
        ["frisk2"] = Game:getPartyMember("frisk2"):getOpinion(Game:getPartyMember(tea_self)),
        ["alseri"] = Game:getPartyMember("alseri"):getOpinion(Game:getPartyMember(tea_self)),
        ["jamm"] = Game:getPartyMember("jamm"):getOpinion(Game:getPartyMember(tea_self)),
        ["mario"] = Game:getPartyMember("mario"):getOpinion(Game:getPartyMember(tea_self)),
        ["pauling"] = Game:getPartyMember("pauling"):getOpinion(Game:getPartyMember(tea_self)),
        ["whale"] = Game:getPartyMember("whale"):getOpinion(Game:getPartyMember(tea_self)),
    }

    -- Default shop price (sell price is halved)
    self.price = 10
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
    }
end

function item:getBattleHealAmount(id)
    -- Dont heal less than 40HP in battles
    return math.max(40, super.getBattleHealAmount(self, id))
end

return item