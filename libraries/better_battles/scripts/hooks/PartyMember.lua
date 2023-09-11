---@class PartyMember : PartyMember
---@overload fun(...) : PartyMember
local PartyMember, super = Class("PartyMember", true)

function PartyMember:getMaxShield()
	return self:getStat("health") / 2
end

return PartyMember