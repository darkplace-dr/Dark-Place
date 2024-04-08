local wave, super = Class(Wave)

function wave:init()
    super.init(self)

    self:setArenaSize(155, 130)
    self.soul_x = -4
end

function wave:canEnd()
    return false
end

return wave