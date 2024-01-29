local LightArena, super = Class(Object)

function LightArena:init(x, y, shape)
    super.init(self, x, y)

    self:setOrigin(0.5, 1)

    self.x = math.floor(self.x)
    self.y = math.floor(self.y)

    self.color = {1, 1, 1}
    self.bg_color = {0, 0, 0}

    self.home_x = self.x
    self.home_y = self.y
    self.init_width = 565
    self.init_height = 130

    self.collider = ColliderGroup(self)

    self.line_width = 5 -- must call setShape again if u change this
    self:setShape(shape or {{0, 0}, {self.init_width, 0}, {self.init_width, self.init_height}, {0, self.init_height}})

    self.sprite = ArenaSprite(self)
    self.sprite.color = {0, 0, 0}
    self.sprite.layer = BATTLE_LAYERS["below_ui"]
    self:addChild(self.sprite)

    self.sprite_border = ArenaSprite(self)
    self.sprite_border:setOrigin(0.5, 1)
    self.sprite_border.background = false
    self.sprite_border.layer = BATTLE_LAYERS["above_bullets"]
    Game.battle:addChild(self.sprite_border)

    self.mask = ArenaMask(1, 0, 0, self)
    self.mask.layer = BATTLE_LAYERS["above_ui"]
    self:addChild(self.mask)

    self.target_shape = {}
    self.target_position = {}

    self.target_shape_callback = nil
    self.target_position_callback = nil
end

function LightArena:setSize(width, height)
    self:setShape{{0, 0}, {width, 0}, {width, height}, {0, height}}
end

function LightArena:setShape(shape)
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

    self.left = math.floor(self.x - self.width / 2)
    self.right = math.floor(self.x + self.width / 2)
    self.top = math.floor(self.y - self.height)
    self.bottom = math.floor(self.y)

    self.triangles = love.math.triangulate(Utils.unpackPolygon(self.shape))

    self.border_line = {Utils.unpackPolygon(Utils.getPolygonOffset(self.shape, self.line_width/2))}

    self.clockwise = Utils.isPolygonClockwise(self.shape)

    self.area_collider = PolygonCollider(self, Utils.copy(shape, true))

    self.collider.colliders = {}
    for _,v in ipairs(Utils.getPolygonEdges(self.shape)) do
        table.insert(self.collider.colliders, LineCollider(self, v[1][1], v[1][2], v[2][1], v[2][2]))
    end
end

function LightArena:setBorderColor(r, g, b, a)
    self.border.color = {r, g, b, a or 1}
end

function LightArena:setBackgroundColor(r, g, b, a)
    self.bg_color = {r, g, b, a or 1}
end

function LightArena:getBorderColor()
    return self.border.color
end

function LightArena:getBackgroundColor()
    return self.bg_color
end

function LightArena:getCenter()
    return self:getRelativePos(self.width/2, self.height/2)
end

function LightArena:getTopLeft() return self:getRelativePos(0, 0) end
function LightArena:getTopRight() return self:getRelativePos(self.width, 0) end
function LightArena:getBottomLeft() return self:getRelativePos(0, self.height) end
function LightArena:getBottomRight() return self:getRelativePos(self.width, self.height) end

function LightArena:getLeft() local x, y = self:getTopLeft(); return x end
function LightArena:getRight() local x, y = self:getBottomRight(); return x end
function LightArena:getTop() local x, y = self:getTopLeft(); return y end
function LightArena:getBottom() local x, y = self:getBottomRight(); return y end

function LightArena:onAdd(parent)
    self.sprite:setScale(1)
    self.sprite.alpha = 1
    self.sprite.rotation = math.pi
end

function LightArena:onRemove(parent)
end

function LightArena:isNotTransitioning()
    return #self.target_shape == 0 and #self.target_position == 0
end

function LightArena:update()
    if #self.target_shape > 0 then
        if not Utils.equal(self.width, self.target_shape[1], true) then
            self.width = Utils.approach(self.width, self.target_shape[1], DTMULT * 30)
        end

        if not Utils.equal(self.height, self.target_shape[2], true) then
            self.height = Utils.approach(self.height, self.target_shape[2], DTMULT * 30)
        end

        if Utils.equal(self.width, self.target_shape[1], true) and Utils.equal(self.height, self.target_shape[2], true) then
            self:setSize(self.target_shape[1], self.target_shape[2])
            self.target_shape = {}
            if self.target_shape_callback then
                self.target_shape_callback()
                self.target_shape_callback = nil
            end
        end
    end

    if #self.target_position > 0 then
        if self.move_soul and Game.battle.soul then
            Game.battle.soul:setPosition(self:getCenter())
        end

        if not Utils.equal(self.x, self.target_position[1], true) then
            self.x = Utils.approach(self.x, self.target_position[1], math.ceil(DTMULT * 15))
        end

        if not Utils.equal(self.y, self.target_position[2], true) then
            self.y = Utils.approach(self.y, self.target_position[2], math.ceil(DTMULT * 15))
        end

        if Utils.equal(self.x, self.target_position[1], true) and Utils.equal(self.y, self.target_position[2], true) then
            self:setSize(self.width, self.height) -- needs to be called so top, bottom, left, and right work
            self.x = self.target_position[1]
            self.y = self.target_position[2]
            self.target_position = {}
            if self.target_position_callback then
                self.target_position_callback()
                self.target_position_callback = nil
            end
        end
    end

    if not Utils.equal(self.processed_shape, self.shape, true) then
        self:setShape(self.shape)
    elseif self.processed_width ~= self.width or self.processed_height ~= self.height then
        self:setSize(self.width, self.height)
    end

    super:update(self)

    if NOCLIP then return end

    local soul = Game.battle.soul
    if soul and Game.battle.soul.collidable then
        Object.startCache()
        local angle_diff = self.clockwise and -(math.pi/2) or (math.pi/2)
        for _,line in ipairs(self.collider.colliders) do
            local angle
            while soul:collidesWith(line) do
                if not angle then
                    local x1, y1 = self:getRelativePos(line.x, line.y, Game.battle)
                    local x2, y2 = self:getRelativePos(line.x2, line.y2, Game.battle)
                    angle = Utils.angle(x1, y1, x2, y2)
                end
                Object.uncache(soul)
                soul:setPosition(
                    soul.x + (math.cos(angle + angle_diff)),
                    soul.y + (math.sin(angle + angle_diff))
                )
            end
        end
        Object.endCache()
    end
end

function LightArena:changeShape(shape, callback)
    self.target_shape = shape
    self.target_shape_callback = callback
end

function LightArena:changePosition(pos, move_soul, callback)
    self.target_position = pos
    self.move_soul = move_soul or true
    self.target_position_callback = callback
end

function LightArena:drawMask()
    love.graphics.push()
    self.sprite:preDraw()
    self.sprite:drawBackground()
    self.sprite:postDraw()
    love.graphics.pop()
end

function LightArena:preDraw()
    super.preDraw(self)
    self.sprite_border.x = self.x
    self.sprite_border.y = self.y
    self.sprite_border.width = self.sprite.width-1
end

function LightArena:draw()
    super.draw(self)

    if DEBUG_RENDER and self.collider then
        self.collider:draw(0, 0, 1)
    end
end

return LightArena