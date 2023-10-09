local NEOPonmanActor, super = Class(ActorSprite)

function NEOPonmanActor:init(actor)
    super.init(self, actor)

    self.draw_children_below = 0
    self.draw_children_above = 1

    local eye = Sprite("battle/enemies/neo_ponman/eye")
    eye.visible = true
    eye.layer = self.layer + 1
    eye.angle = 0
    eye.radius = 0

    self.eye = eye
    self:addChild(eye)

    self.addup = false
    self.timer = 0
	
    self.eyecon = 0
    self.spin_speed = 0
    self.pon_total = 2
    self.x_angle = 0
end

function NEOPonmanActor:update()
    super.update(self)

    self.timer = self.timer + DTMULT

    if self.eyecon == 0 then
        self.eye.angle = math.rad(180 + (math.sin(self.timer / 8) * 30))

        if self.eye.radius < 4 then
            self.eye.radius = self.eye.radius + 2*DTMULT
        else
            self.eye.radius = 4
        end

        if self.addup == false then
            self:setFrame(1)
        else
            self:setFrame(3)
        end

        if self.eye.angle > math.rad(200) then
            self:setFrame(0)
            self.addup = true
        end
        if self.eye.angle < math.rad(160) then
            self:setFrame(2)
            self.addup = false
        end
    end

    if self.eyecon == 10 then
        self:setFrame(1)
        self.eye.radius = self.eye.radius * 0.7
		
        if math.abs(self.eye.radius) < 0.5 then
            self.eye.radius = 0
            self.eye.angle = 0
        end
    end

    if self.eyecon == 20 then
        if self.spin_speed == 0 then
            self.spin_speed = self.spin_speed + DTMULT
        end

		if self.pon_total > 1 then
            self.timer = self.timer + self.spin_speed / 8
        else
            self.timer = self.timer + self.spin_speed / 20
        end

        self.eye.angle = math.rad(180 + (math.sin(self.timer / 8) * 70))
		
        if self.eye.radius < 4 then
            self.eye.radius = self.eye.radius + DTMULT
        end
    end

    if self.eye.angle < math.rad(0) then
        self.eye.angle = self.eye.angle + math.rad(360)*DTMULT
    end
    if self.eye.angle > math.rad(360) then
        self.eye.angle = self.eye.angle - math.rad(360)*DTMULT
    end

    self.eye.x = math.cos(self.eye.angle)*self.eye.radius + 12
    self.eye.y = math.sin(self.eye.angle)*self.eye.radius + 14
end

return NEOPonmanActor