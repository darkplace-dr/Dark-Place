---@class Battle
local Battle, super = Class("Battle", true)

function Battle:init()
    super.init(self)

    self.freeze_xp = 0

    self.killed = false
end

return Battle