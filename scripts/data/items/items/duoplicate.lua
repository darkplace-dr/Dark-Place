-- Instead of Item, create a HealItem, a convenient class for consumable healing items
local item, super = Class(HealItem, "duoplica")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Duoplicate"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Heals\n40 HP"
    -- Shop description
    self.shop = "A little\nbit unstable\n+40 HP"
    -- Menu description
    self.description = "An item that can apparently duplicates.\nLet's hope there won't be an overflow. +40 HP"

    -- Amount healed (HealItem variable)
    self.heal_amount = 40

    -- Default shop price (sell price is halved)
    self.price = 400
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {}
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}
end

function item:onWorldUse(target)
    local amount = self:getWorldHealAmount(target.id)
    Game.world:heal(target, amount)
    Game.world:startCutscene(function(cutscene)
        local subject, verb = "You", "eat"
        if target.id ~= Mod:getLeader().id then
            subject = target.name
            verb = "eats"
        end
        cutscene:text("* "..subject.." "..verb.." the Duoplicate.")
        cutscene:text("* ...")
        local count = 0
        while not Game.inventory:isFull("items", false) do
            Game.inventory:addItemTo("items", "unoplica", false)
            count = count + 1
            if count > 10 then break end --safe break just in case
        end
        local texttexttext
        if count > 0 then
            texttexttext = "* Oh god, it's duplicating!!"
            for i=1,count-1 do
                texttexttext = texttexttext.."\n* Oh god, it's duplicating!!"
            end
        else
            texttexttext = "* The item tried to duplicate itself, but failed."
        end
        cutscene:text(texttexttext)
    end)
    return true
end

function item:onBattleUse(user, target)
    local count = 0
    while not Game.inventory:isFull("items", false) do
        Game.inventory:addItemTo("items", "unoplica", false)
        count = count + 1
        if count > 10 then break end --safe break just in case
    end
    return true
end

return item
