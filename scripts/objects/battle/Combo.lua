---@class Combo : Class
---@overload fun(...) : Combo
local Combo = Class()

function Combo:init()
    -- Display name
    self.name = "Test Combo"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = ""
    -- Menu description
    self.description = ""

    -- TP cost
    self.cost = 0
    -- Whether the combo can be used
    self.usable = true

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "none"

    -- Tags that apply to this combo
    self.tags = {}

    -- Other party members that are required to be in the party.
    self.party = {}
end

function Combo:getName() return self.name end
function Combo:getCastName() return self.cast_name or self:getName():upper() end

function Combo:getDescription() return self.description end
function Combo:getBattleDescription() return self.effect end

function Combo:getTPCost(chara) return self.cost end
function Combo:isUsable(chara) return self.usable end

function Combo:hasTag(tag)
    return Utils.containsValue(self.tags, tag)
end

function Combo:onCast(user, target)
    -- Returning false here allows you to call 'Game.battle:finishActionBy(user)' yourself
	Game.battle:startActCutscene(function(cutscene)
		self:doCutscene(cutscene)
	end)
end

function Combo:onStart(user, target)
    Game.battle:clearActionIcon(user)
    local result = self:onCast(user, target)
    if result or result == nil then
        Game.battle:finishActionBy(user)
    end
end

function Combo:doCutscene(cutscene) end

function Combo:onSelect(user, target) end
function Combo:onDeselect(user, target) end

return Combo