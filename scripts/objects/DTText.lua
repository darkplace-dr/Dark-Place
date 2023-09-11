local DTText, super = Class(Object)

-- Types: "mercy", "damage", "dt", "msg"
-- Arg:
--    "mercy"/"damage": amount
--    "dt": list of strings
--    "msg": message sprite name ("down", "frozen", "lost", "max", "mercy", "miss", "recruit", and "up")

function DTText:init(arg, x, y)
    super.init(self, x, y)

    self:setOrigin(1, 0)

    self.color = {1, 0, 0}

    -- Halfway between UI and the layer above it
    self.layer = BATTLE_LAYERS["top"]

	self.dt_list = arg
	self.text = Utils.pick(self.dt_list)
    self.font = Assets.getFont("main_mono", 16)

    self.width = self.font:getWidth(self.text)
    self.height = self.font:getHeight()

    self.timer = 0
    self.delay = 2

    self.bounces = 0

    self.stretch = 0.2
    self.stretch_done = false

    self.start_x = nil
    self.start_y = nil

    self.physics.speed_x = 0
    self.physics.speed_y = 0
    self.start_speed_y = 0

    self.kill_timer = 0
    self.killing = false
    self.kill = 0

    self.do_once = false

    self.kill_others = false
end

function DTText:update()
    if not self.start_x then
        self.start_x = self.x
        self.start_y = self.y
    end

    super.update(self)

    self.timer = self.timer + DTMULT

    if (self.timer >= self.delay) and (not self.do_once) then
        self.do_once = true
        self.physics.speed_x = 10
        self.physics.speed_y = (-5 - (love.math.random() * 2))
        self.start_speed_y = self.physics.speed_y
    end

    if self.timer >= self.delay then
        self.physics.speed_x = Utils.approach(self.physics.speed_x, 0, DTMULT)

        if self.bounces < 2 then
            self.physics.speed_y = self.physics.speed_y + DTMULT
        end
        if (self.y > self.start_y) and (not self.killing) then
            self.y = self.start_y

            self.physics.speed_y = self.start_speed_y / 2
            self.bounces = self.bounces + 1
        end
        if (self.bounces >= 2) and (not self.killing) then
            self.physics.speed_y = 0
            self.y = self.start_y
        end

        if not self.stretch_done then
            self.stretch = self.stretch + 0.4 * DTMULT
        end

        if self.stretch >= 1.2 then
            self.stretch = 1
            self.stretch_done = true
        end

        self.kill_timer = self.kill_timer + DTMULT
        if self.kill_timer > 35 then
            self.killing = true
        end
        if self.killing then
            self.kill = self.kill + 0.08 * DTMULT
            self.y = self.y - 4 * DTMULT
        end

        if self.kill > 1 then
            self:remove()
            return
        end
    end
	
	if self.timer%2 == 0 then
		self.text = Utils.pick(self.dt_list)
		self.width = self.font:getWidth(self.text)
	end

    self:setScale(2 - self.stretch, self.stretch + self.kill)

    if Game.state == "BATTLE" then
        if self.x >= 600 then
            self.x = 600
        end
    end
end

function DTText:draw()
    if self.timer >= self.delay then
        local r, g, b, a = self:getDrawColor()
        Draw.setColor(r, g, b, a * (1 - self.kill))

        love.graphics.setFont(self.font)
        love.graphics.print(self.text, 30, 0)
    end

    super.draw(self)
end

return DTText