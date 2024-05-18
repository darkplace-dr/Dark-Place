local ScreenArena, super = Class(Object)

function ScreenArena:init(arena)
    super.init(self)
    self.arena = arena

    self:setOrigin(0.5, 0.5)

    self.prev_tensionbar_layer = nil

    self.color = self.arena.color
    self.bg_color = self.arena.bg_color

    self.prev_arena_color = self.arena.color

    self.x, self.y = self.arena:getRelativePos(self.arena.width/2, self.arena.height/2)
    self.x, self.y = math.floor(self.x), math.floor(self.y)

    self.line_width = 4

    self:setShape(self.arena.shape)

    self.sprite = ArenaSprite(self)
    self:addChild(self.sprite)

    self.fader = Fader()
    self.fader.layer = BATTLE_LAYERS["top"]
    self.fader.color = {1, 1, 1, 1}
    self.fader.alpha = 0
    Game.battle:addChild(self.fader)

    self.done = false

    self.arena_flash_timer = 4
end

function ScreenArena:getCenter()
    return self:getRelativePos(self.width/2, self.height/2)
end

function ScreenArena:getBackgroundColor()
    return self.bg_color
end

function ScreenArena:setShape(shape)
    self.shape = Utils.copy(shape, true)
    self.processed_shape = Utils.copy(shape, true)

    local min_x, min_y, max_x, max_y
    for _,point in ipairs(self.shape) do
        min_x, min_y = math.min(min_x or point[1], point[1]), math.min(min_y or point[2], point[2])
        max_x, max_y = math.max(max_x or point[1], point[1]), math.max(max_y or point[2], point[2])
    end
    for _,point in ipairs(self.shape) do
        point[1] = point[1] - min_x
        point[2] = point[2] - min_y
    end
    self.width = max_x - min_x
    self.height = max_y - min_y

    self.processed_width = self.width
    self.processed_height = self.height

    self.left = math.floor(self.x - self.width/2)
    self.right = math.floor(self.x + self.width/2)
    self.top = math.floor(self.y - self.height/2)
    self.bottom = math.floor(self.y + self.height/2)

    self.triangles = love.math.triangulate(Utils.unpackPolygon(self.shape))

    self.border_line = {Utils.unpackPolygon(Utils.getPolygonOffset(self.shape, self.line_width/2))}

    self.clockwise = Utils.isPolygonClockwise(self.shape)
end

function ScreenArena:update()
    if not Utils.equal(self.processed_shape, self.shape, true) then
        self:setShape(self.shape)
    elseif self.processed_width ~= self.width or self.processed_height ~= self.height then
        self:setSize(self.width, self.height)
    end

    local r = Utils.lerp(self.prev_arena_color[1], 1, self.arena_flash_timer/4)
    local g = Utils.lerp(self.prev_arena_color[2], 1, self.arena_flash_timer/4)
    local b = Utils.lerp(self.prev_arena_color[3], 1, self.arena_flash_timer/4)

    self.arena:setColor(r, g, b)

    self.arena_flash_timer = Utils.approach(self.arena_flash_timer, 0, DTMULT)

    super.update(self)
end

function ScreenArena:onAdd(parent)
    local center_x, center_y = self:getCenter()

    local afterimage_timer = 15
    local afterimage_count = 0
    Game.battle.timer:during(3, function()
        afterimage_timer = Utils.approach(afterimage_timer, 90, DTMULT*1.25)

        local real_progress = afterimage_timer/15

        self.sprite:setScale(real_progress, real_progress)
        self.sprite.rotation = (math.pi) * (1 - real_progress)

        while afterimage_count < math.floor(afterimage_timer) - 1 do
            afterimage_count = afterimage_count + 1

            local progress = afterimage_count/15

            local afterimg = ArenaSprite(self, center_x, center_y)
            afterimg:setOrigin(0.5, 0.5)
            afterimg:setScale(progress, progress)
            afterimg:fadeOutSpeedAndRemove()
            afterimg.background = false
            afterimg.alpha = 0.8 - (0.2 * progress)
            afterimg.rotation = (math.pi) * (1 - progress)
            parent:addChild(afterimg)
            afterimg:setLayer(self.layer + (10 - progress))
        end
    end, function()
        self.done = true
        self.sprite.rotation = 0
    end)
end

function ScreenArena:fade()
    self.fader:fadeOut(function()
        Game.battle.timer:after(1, function()
            self:remove()
            Game.battle.tension_bar.layer = self.prev_tensionbar_layer
            self.fader:fadeIn(nil, {speed = 1})
        end)
    end, {fade_color = {1, 1, 1, 1}, speed = 0.5})
end

return ScreenArena