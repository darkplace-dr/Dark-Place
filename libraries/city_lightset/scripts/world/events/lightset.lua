local Lightset, super = Class(Event)

function Lightset:init(data)
    super.init(self, data)
    
    self:setSprite("world/events/lightset/city_lightset")
    self.sprite.alpha = 0
    self:setOriginExact(0, -data.height + 40)

    self.l          = data.width / self.sprite.width
    self.h          = data.height / self.sprite.height

    self.timer      = 0
    self.minitimer  = 0

    local pr    = data.properties
    
    self.mode   = pr.mode or 2

    self.sprites = {}
    for i=0, math.ceil(self.l - 1) do
        self.sprites[i] = Sprite("world/events/lightset/city_lightset", i * 40, 0)
        local sp = self.sprites[i]
        sp:setScaleOrigin(0, 1)
        self:addChild(sp)

        sp.barsiner     = Utils.random(4600)
        sp.scale_y      = Utils.random(1) * self.scale_y
        local r, g, b   = Utils.hsvToRgb((i * 255 / self.l)/255, 128/255, 255/255)
        sp.color        = {r, g, b}
    end
end

function Lightset:getDebugInfo()
    local info = super.getDebugInfo(self)
    for i, spr in pairs(self.sprites) do
        table.insert(info, "sprite ".. i .. " y_scale: " .. spr.scale_y)
    end

    return info
end

function Lightset:draw()
    self.timer = self.timer + DTMULT
    self.minitimer = self.minitimer + DTMULT
    self.timerthreshold = 12
    self.minitimerthreshold = 2
    for i=0, math.ceil(self.l - 1) do
        local sp = self.sprites[i]
        if self.mode < 2 then
            sp.scale_y = Utils.lerp(sp.scale_y, 0, 0.06 * DTMULT)
            if sp.scale_y > 0 then
                sp.scale_y = sp.scale_y - (0.02 * DTMULT)
            end
        end
        if self.mode == 2 and self.minitimer >= self.minitimerthreshold then
            sp.barsiner = sp.barsiner + 1
            sp.scale_y = (0.6 * self.h) + (math.sin(sp.barsiner / 2) * 0.3) * self.h + (math.sin(sp.barsiner / 3) * 0.1) * self.h
        end
        if self.mode == 0 then
            if sp.scale_y < (0.8 * self.h) then
                if math.floor(Utils.random(12)) == 0 then
                    sp.scale_y = self.h
                end
            end
        end
        if self.mode == 1 then
            if self.timer >= self.timerthreshold then
                sp.scale_y = math.min(sp.scale_y + Utils.random(0.5 * self.h), self.h)
            end
        end

        -- Sprite twitching/glitching prevention
        sp.scale_y = sp.scale_y - (sp.scale_y % (1/40))
        if sp.scale_y < 1/40 then
            sp.scale_y = 0
        end
    end

    if self.timer >= self.timerthreshold then
        self.timer = 0
    end
    if self.minitimer >= self.minitimerthreshold then
        self.minitimer = 0
    end
    super.draw(self)
end

return Lightset