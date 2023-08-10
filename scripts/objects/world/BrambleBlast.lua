local BrambleBlast, super = Class(Object)

function BrambleBlast:init(style)
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

    self.parallax_x = 0
    self.parallax_y = 0

    if style == 3 then
        local backdrop = Sprite("world/maps/brambleblast/sky3", 0, 0)
        backdrop:setScale(2)
        backdrop.layer = WORLD_LAYERS["bottom"]
        backdrop:setWrap(true)
        backdrop.physics.speed_x = -0.3
        self:addChild(backdrop)

        local vine = Sprite("world/maps/brambleblast/vine3", 0, 0)
        vine:setWrap(true)
        vine.layer = WORLD_LAYERS["bottom"] + 1
        self:addChild(vine)
    elseif style == 2 then
        local backdrop = Sprite("world/maps/brambleblast/sky2", 0, 0)
        backdrop:setScale(2)
        backdrop.layer = WORLD_LAYERS["bottom"]
        backdrop:setWrap(true)
        backdrop.physics.speed_x = -0.3
        self:addChild(backdrop)

        local vine = Sprite("world/maps/brambleblast/vine2", 0, 0)
        vine:setWrap(true)
        vine.layer = WORLD_LAYERS["bottom"] + 1
        self:addChild(vine)
    else
        local backdrop = Sprite("world/maps/brambleblast/sky1", 0, 0)
        backdrop:setScale(2)
        backdrop.layer = WORLD_LAYERS["bottom"]
        backdrop:setWrap(true)
        backdrop.physics.speed_x = -0.3
        self:addChild(backdrop)

        local vine = Sprite("world/maps/brambleblast/vine1", 0, 0)
        vine:setWrap(true)
        vine.layer = WORLD_LAYERS["bottom"] + 1
        self:addChild(vine)
    end

end

return BrambleBlast