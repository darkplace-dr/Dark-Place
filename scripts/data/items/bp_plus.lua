local item, super = Class(Item, "bp_plus")

function item:init()
    super.init(self)

    -- Display name
    self.name = "BP Plus"
    -- Name displayed when used in battle (optional)
    self.use_name = "BP PLUS"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Use\nout of\nbattle"
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A small green gem with a plus sign on it.\nRaises maximum BP by 3."

    -- Default shop price (sell price is halved)
    self.price = 0
    -- Whether the item can be sold
    self.can_sell = false

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "none"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "world"
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

    -- Character reactions
    self.reactions = {}
end

function item:onWorldUse(target)
    Game.world:startCutscene(function (cs)
        cs:text("* (You hold the gem up in the air...)")
        Assets.playSound("badgeget_64")
        cs:text("* (Your max BP went up by 3!)")
    end)
    BadgesLib.total_bp = BadgesLib.total_bp + 3
    return true
end

function item:onBattleSelect(user, target)
    -- Do not consume (ralsei will feel bad)
    return false
end

function item:getBattleText(user, target)
    return {"* "..user.chara:getName().." used "..self:getUseName().."!", "* But nothing happened..."}
end

return item