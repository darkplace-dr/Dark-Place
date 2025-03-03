local SimpleGonerBackground, super = Class(Object)

function SimpleGonerBackground:init(x, y)
    super.init(self,
        x or SCREEN_WIDTH/2, y or SCREEN_HEIGHT/2,
        -- specifically, LW dimensions
        SCREEN_WIDTH/2, SCREEN_HEIGHT/2
    )
    self:setScale(2)
    self:setOrigin(0, 0)
    self:setParallax(0, 0)

    self.piece_depth = 0

    self.timer = Timer()
    self.timer:every(40/30, function()
        self.piece_depth = self.piece_depth - 0.001
        local piece = self:addChild(GonerBackgroundPiece())
        piece.layer = self.piece_depth
    end)
    self:addChild(self.timer)
end

function SimpleGonerBackground:onAdd()
    local old_dt = DT
    local old_dtmult = DTMULT
    DT = 20/30
    DTMULT = DT * 30
    for i=1, 10 do
        self:update()
    end
    DTMULT = old_dtmult
    DT = old_dt
end

function SimpleGonerBackground:onRemove(...)
    super.onRemove(self, ...)

    self.music:stop()
end

return SimpleGonerBackground