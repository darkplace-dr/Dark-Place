local CityScreen, super = Class(Event)

function CityScreen:init(data)
    super.init(self, data)

    local pr            = data.properties or {}

    -- The sprite to use for the screen, or nil for a random sprite (defaults to `nil`)
    local sprite        = pr.sprite or nil
    -- The speed at which the sprite will play (defaults to `1/2`)
    local spritespeed   = pr.sprite_speed or (1/2)

    local spritelist    = {"buy", "dolphin", "look", "person", "ad", "deals", "buy2"}
    local extra_sprites = Kristal.modCall("getScreenSprites")

    if extra_sprites == nil then
        goto skip
    end
    if type(extra_sprites) == "string" then
        table.insert(spritelist, extra_sprites)
    elseif type(extra_sprites) == "table" then
        spritelist = Utils.merge(spritelist, extra_sprites)
    end

    ::skip::

    if not sprite then
        sprite = Utils.pick(spritelist)
    end

    self:setSprite("world/events/screen/" .. sprite, spritespeed)

    self.solid = false
    self:setScale(0)


    -- Timer Variables
    self.frame_timer = 0
    self.timer = 0
    self.siner = love.math.random(30)

    -- Other Variables
    self.con = 0
    self.frame_timer_threshold = 0
    self.orig_x = self.x
    self.orig_y = self.y
end

function CityScreen:update()
    super.update(self)
    self.frame_timer = self.frame_timer + DTMULT
    self.frame_timer_threshold = 2
    if self.con == 2 then
        self.frame_timer_threshold = 4
    end

    if self.frame_timer >= self.frame_timer_threshold then
        if self.con == 0 then
            self.timer = self.timer + 1
            self:setScale(Utils.lerp(self.scale_x, 1.5, 0.5))
            if self.scale_x >= 1.25 then
                self.con = 1
            end
        end
        if self.con == 1 then
            self:setScale(Utils.lerp(self.scale_x, 1, 0.5))
            if (math.abs(self.scale_x) - 2) <= 0.05 then
                self:setScale(1)
                self.con = 2
            end
        end
        if self.con == 2 then
            self.siner = self.siner + DTMULT
            self.orig_y = self.orig_y + (math.sin(self.siner / 4) * 0.2)
            self.y_off = love.math.random(-2, 2)
            self.x_off = love.math.random(-2, 2)
            self.y = self.orig_y + self.y_off
            self.x = self.orig_x + self.x_off
        end
        self.frame_timer = 0
    end
end

return CityScreen