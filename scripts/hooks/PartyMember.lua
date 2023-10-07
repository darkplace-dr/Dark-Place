---@class PartyMember
local PartyMember, super = Class("PartyMember", true)

function PartyMember:init()
    super.init(self)
end

function PartyMember:onSave(data)
    data.opinions = self.opinions
end

function PartyMember:onLoad(data)
    self.opinions = data.opinions or self.opinions
end

return PartyMember