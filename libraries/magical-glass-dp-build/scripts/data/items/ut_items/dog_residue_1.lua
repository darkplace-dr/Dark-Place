local item, super = Class(Item, "ut_items/dog_residue_1")

function item:init(inventory)
    super.init(self)

    -- Display name
    self.name = "Dog Residue"
    self.short_name = "DogResidu"
    self.serious_name = "D.Residue"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Whether this item is for the light world
    self.light = true

    -- Default shop sell price
    self.sell_price = 3
    -- Whether the item can be sold
    self.can_sell = true

    -- Item description text (unused by light items outside of debug menu)
    self.description = "Shiny trail left behind by a dog."

    -- Light world check text
    self.check = "Dog Item\n* Shiny trail left\nbehind by a dog."

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "none"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false
    
end

function item:onWorldUse(target)
    Game.world.timer:script(function(wait)
        Assets.playSound("item")
        wait(0.4)
        Assets.playSound("dogresidue")
    end)

    local text
    if #Game.inventory:getStorage("items") < Game.inventory:getStorage("items").max then
        text = {
            "* You used the Dog Residue.",
            "* The rest of your inventory\nfilled up with Dog Residue."
        }
    else
        text = {
            "* You used the Dog Residue.",
            "* ...",
            "* You finished using it.",
            "* An uneasy atmosphere fills\nthe room."
        }
    end
    Game.world:showText(text)

    Game.inventory:removeItem(self)
    while #Game.inventory:getStorage("items") < Game.inventory:getStorage("items").max do
        local items = {
            "ut_items/dog_salad",
            "ut_items/dog_residue_1",
            "ut_items/dog_residue_2",
            "ut_items/dog_residue_3",
            "ut_items/dog_residue_4",
            "ut_items/dog_residue_5",
            "ut_items/dog_residue_6",
        }
        Game.inventory:addItem(Utils.pick(items))
    end
    return false
end

function item:getLightBattleText(user, target)
    local text
    if #Game.inventory:getStorage("items") + 1 < Game.inventory:getStorage("items").max then
        text = {
            "* You used the Dog Residue.",
            "* The rest of your inventory\nfilled up with Dog Residue."
        }
    else
        text = {
            "* You used the Dog Residue.",
            "* ...",
            "* You finished using it.",
            "* An uneasy atmosphere fills\nthe room."
        }
    end
    return text
end

function item:onLightBattleUse(user, target)
    Game.battle.timer:script(function(wait)
        Assets.playSound("item")
        wait(0.4)
        Assets.playSound("dogresidue")
    end)

    while #Game.inventory:getStorage("items") < Game.inventory:getStorage("items").max do
        local items = {
            "ut_items/dog_salad",
            "ut_items/dog_residue_1",
            "ut_items/dog_residue_2",
            "ut_items/dog_residue_3",
            "ut_items/dog_residue_4",
            "ut_items/dog_residue_5",
            "ut_items/dog_residue_6",
        }
        Game.inventory:addItem(Utils.pick(items))
    end
    Game.battle:battleText(self:getLightBattleText(user, target))
    return true
end

function item:onBattleUse(user, target)
    Assets.playSound("dogresidue")

    while #Game.inventory:getStorage("items") < Game.inventory:getStorage("items").max do
        local items = {
            "ut_items/dog_salad",
            "ut_items/dog_residue_1",
            "ut_items/dog_residue_2",
            "ut_items/dog_residue_3",
            "ut_items/dog_residue_4",
            "ut_items/dog_residue_5",
            "ut_items/dog_residue_6",
        }
        Game.inventory:addItem(Utils.pick(items))
    end
    return true
end

return item