---
---@class Encounter
---
---@field turn number  The number of turns elapsed in this encounter. Starts at `1`, increasing at the end of each turn.
---
---@overload fun(...) : Encounter
local Encounter, super = Class("Encounter")

function Encounter:init()
    super.init(self)
    
    self.turn = 1
end

function Encounter:onBattleInit()
    super.onBattleInit(self)

    for _, battler in ipairs(Game.battle.party) do
        for _, item in ipairs(battler.chara:getEquipment()) do
            -- This little check in every callback prevents any class that does not include Item from causing crashes by being equipped.
            if item:includes(Item) then
                item:onBattleInit(battler)
            else
                -- For the initial battle load only, print a warning to the console that this has been detected.
                print("[WARNING] Non-item detected equipped on battler " .. battler.chara.id .. ".")
            end
        end
    end
end

function Encounter:onBattleStart()
    super.onBattleStart(self)

    for _, battler in ipairs(Game.battle.party) do
        for _,item in ipairs(battler.chara:getEquipment()) do
            if item:includes(Item) then
                item:onBattleStart(battler)
            end
        end
    end
end

function Encounter:onBattleEnd()
    super.onBattleStart(self)

    for _, battler in ipairs(Game.battle.party) do
        for _,item in ipairs(battler.chara:getEquipment()) do
            if item:includes(Item) then
                item:onBattleEnd(battler)
            end

        end
        -- Empties future_heals table ready for the next encounter.
        battler.future_heals = {}
    end
end

function Encounter:onTurnStart()
    super.onTurnStart(self)
    for _, battler in ipairs(Game.battle.party) do
        for _, item in ipairs(battler.chara:getEquipment()) do
            if item:includes(Item) then
                item:onTurnStart(battler, self.turn)
            end
        end
    end
end

function Encounter:onTurnEnd()
    super.onTurnEnd()
    local party = Game.battle.party

    for _,battler in ipairs(party) do
        for _,item in ipairs(battler.chara:getEquipment()) do
            if item:includes(Item) then
                item:onTurnEnd(battler, self.turn)
            end
        end
    end

    -- The turn is advancing, so the turn number is increased.
    self.turn = self.turn + 1
end

function Encounter:onActionsStart()
    super.onActionsStart(self)
    
    for _, battler in ipairs(Game.battle.party) do
        for _, item in ipairs(battler.chara:getEquipment()) do
            if item:includes(Item) then
                item:onActionsStart(battler)
            end
        end
    end
end

function Encounter:onActionsEnd()
    super.onActionsEnd(self)
    
    for _, battler in ipairs(Game.battle.party) do
        for _, item in ipairs(battler.chara:getEquipment()) do
            if item:includes(Item) then
                item:onActionsEnd(battler)
            end
        end
    end
end

function Encounter:beforeStateChange(old, new)
    super.beforeStateChange(self, old, new)
    
    for _, battler in ipairs(Game.battle.party) do
        for _, item in ipairs(battler.chara:getEquipment()) do
            if item:includes(Item) then
                item:beforeStateChange(battler, old, new)
            end
        end
    end
end

function Encounter:onStateChange(old, new)
    super.onStateChange(self, old, new)
    
    for _, battler in ipairs(Game.battle.party) do
        for _, item in ipairs(battler.chara:getEquipment()) do
            if item:includes(Item) then
                item:onStateChange(battler, old, new)
            end
        end
    end
end

function Encounter:beforeGameOver()
    -- Represents whether an item has saved the party from losing.
    local saved = false

    for _, battler in ipairs(Game.battle.party) do
        for _, item in ipairs(battler.chara:getEquipment()) do
            -- Alternative way of writing the check for value-returning callbacks.
            if not item:includes(Item) then
                goto continue
            end
            -- If any item:beforeGameOver() returns true, gameover is stopped. 
            if item:beforeGameOver(battler) then
                saved = true
            end
            ::continue::
        end
    end
    
    -- Return saved value to gameover check.
    return saved
end

function Encounter:onGameOver()
    super.onGameOver(self)
    -- Represents whether an item has saved the party from losing.
    local saved = false

    for _, battler in ipairs(Game.battle.party) do
        for _, item in ipairs(battler.chara:getEquipment()) do
            if not item:includes(Item) then
                goto continue
            end
            -- If any item:onGameOver() returns true, gameover is stopped. 
            if item:onGameOver(battler) then
                saved = true
            end
            ::continue::
        end
    end

    -- Return saved value to gameover check.
    return saved
end

return Encounter