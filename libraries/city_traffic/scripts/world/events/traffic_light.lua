local TrafficLight, super = Class(Event)

function TrafficLight:init(data)
    super.init(self, data)

    local pr = data["properties"]

    do
        self.group      = pr["group"]       or 0

        self.siner      = 0
        self.swingtimer = 0
        self.swingcount = 0
        self.mode       = 1
        self.stop       = 0
    end

    self:setSprite("world/events/traffic/trafficlight")
    self.sprite:stop(false)
    self.sprite:setRotationOrigin(0.5, 0)
    self:setRotationOrigin(0.5, 0)
    self:setScale(2)

    self.extra_lights = {}
    for i=1, 6 do
        local light = Sprite("world/events/traffic/trafficlight")
        light:stop(false)
        light:setRotationOrigin(0.5, 0)
        self:addChild(light)

        self.extra_lights[i] = light
    end

end

function TrafficLight:update()
    if self.stop == 0 then
        self.siner = self.siner + DTMULT
        if self.mode == 1 then
            self.swingtimer = self.swingtimer + DTMULT
            if self.swingtimer >= 10 then
                self.swingcount = self.swingcount + 1
                self.swing = self.swingcount % 4
                if self.swing == 1 then
                    self.rotation = math.rad(15)
                elseif self.swing ==3 then
                    self.rotation = math.rad(-15)
                else
                    self.rotation = 0
                end
                self.swingtimer = 0
            end
        end
        for i=1, 6 do
            local light = self.extra_lights[i]
            if i < 3 then
                light:setFrame(2)
                light.alpha = math.sin(self.siner / 4)
            else
                light:setFrame(3)
                light.alpha = math.sin(2 + self.siner / 4)
            end
        end
    else
        self.rotation = 0
        for i=1, 6 do
            if i == 1 then
                self.extra_lights[i].alpha = 1
                self.extra_lights[i]:setFrame(1)
            else
                self.extra_lights[i].alpha = 0
            end
        end
    end
end

function TrafficLight:draw()
    if self.stop == 0 then
        for i=1, 6 do
            if i % 2 == 1 then
                self.sprite:draw()
            end
            self.extra_lights[i]:draw()
        end
    else
        self.sprite:draw()
        self.extra_lights[1]:draw()
    end
end

return TrafficLight