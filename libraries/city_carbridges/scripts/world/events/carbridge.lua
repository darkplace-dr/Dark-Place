local CarBridge, super = Class(Event)

function CarBridge:init(data)
    super.init(self, data)

    local pr        = data.properties

    self.direction  = pr.direction or "right"
    self.type       = pr.type or 1

    self.count      = 4
    self.timer      = 0
    self.btimer     = 0
    self.movemode   = 0
    self.dontdraw   = false

    self.path       = "world/events/carbridge/"
    self:setSprite(self.path.."carbridge_1")
end

function CarBridge:draw()
    Draw.setColor(1, 1, 1)
    Draw.draw(self.sprite.texture, 0, 0, 0, 2, 2)
    if self.dontdraw then
        return
    end

    if self.type == 0 then
        self.timer = self.timer + DTMULT
        for i=0,self.count-1 do
            local x = ((self.timer * 4) + (i * 50)) % 152
            local y = (- math.sin(x/36)) * 10

            local frames = Assets.getFrames(self.path.."traffic_car_side_legs_small")
            local frame = math.floor(self.timer / 4) + 1
            frame = Utils.clampWrap(frame, #frames)
            Draw.draw(frames[frame], x, y, 0, 2, 2)
        end
    elseif self.type == 1 then
        local image
        if self.movemode == 0 then
            self.timer = self.timer + DTMULT
            image = math.floor(self.timer / 4) + 1
        elseif self.movemode == 1 then
            image = 1
            self.btimer = self.btimer + DTMULT
            local timeradd = (math.sin(self.btimer / 3) * 1.2) + 0.8
            if timeradd > -0.6 then self.timer = self.timer + timeradd end
            if timeradd < 0.4 then image = 0 else image = 1 end
            image = self.timer / 8
        end
        for i=0, self.count-1 do
            local x = ((self.timer * 4) + (i * 60)) % 236
            local y = (- math.sin(x / 60) * 10) + 10

            local scale_x
            if self.direction == "right" then
                scale_x = 2
                x = x - 40
            elseif self.direction == "left" then
                scale_x = -2
                x = -x + 240
            end

            local frames = Assets.getFrames(self.path.."traffic_car_side_legs_small")
            image = Utils.clampWrap(image, #frames)
            Draw.draw(frames[image], x, y, 0, scale_x, 2)
        end
    end
end

return CarBridge