local FirstGlitchBG, super = Class(Sprite)

function FirstGlitchBG:init()
    super.init(self)

    self.scanline_big = Sprite("world/maps/flipside/firstglitch/scanline_big", 0, -4)
    self.scanline_big:setScale(1)
    self.scanline_big.physics.speed_y = 5
    self:addChild(self.scanline_big)
	
    self.scanline_small = Sprite("world/maps/flipside/firstglitch/scanline_small", 0, 0)
    self.scanline_small:setScale(1)
    self.scanline_small.physics.speed_y = 2
    self:addChild(self.scanline_small)

    self.scanlines_random = {}
    for i = 1, 10 do
        local scanline = Sprite("world/maps/flipside/firstglitch/scanline_small", 0, 0)
        self.scanlines_random[i] = scanline
        scanline:setScale(1)
        self:addChild(scanline)
    end
    
    for _,scanline in ipairs(self.scanlines_random) do
        Game.world.timer:every(1/5, function()
            scanline.alpha = Utils.random(0, 0.8)
            scanline.y = love.math.random(0, SCREEN_HEIGHT/6)*6
        end)
        if scanline.y >= 464 then
            scanline.physics.speed_y = -1.2
        elseif scanline.y <= 0 then
            scanline.physics.speed_y = 1.2
        end
    end

    self.parallax_x = 0
    self.parallax_y = 0
	
end

function FirstGlitchBG:update()
    super.update(self)

    if self.scanline_big.y >= 454 then
        self.scanline_big.physics.speed_y = -5
    elseif self.scanline_big.y <= -4 then
        self.scanline_big.physics.speed_y = 5
    end

    if self.scanline_small.y >= 464 then
        self.scanline_small.physics.speed_y = -2
    elseif self.scanline_small.y <= 0 then
        self.scanline_small.physics.speed_y = 2
    end
end

return FirstGlitchBG
