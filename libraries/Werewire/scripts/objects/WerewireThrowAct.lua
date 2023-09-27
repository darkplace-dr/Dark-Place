local WerewireThrowAct, super = Class(Object)

function WerewireThrowAct:init(werewires)
    super:init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

    self.werewires = werewires
    self.targets = {}

    self.hit = {}

    self.angle = 0
    self.angle_speed = 2

    self.max_power = 30
    self.min_power = 15
    self.power = self.max_power

    self.throw_offset = {}
    self.throw_gravity = 1

    -- dumb fix
    self.updated_once = false

    -- WAIT, THROW, RETURN, DONE
    self.state = "WAIT"

    self.kx, self.ky = 184, 170

    self.layer = BATTLE_LAYERS["above_ui"]
    self.draw_children_above = 10
    self.debug_select = false
end

function WerewireThrowAct:setup()
    for _,werewire in ipairs(self.werewires) do
        local target_x, target_y = werewire:getRelativePos(1, 11, Game.battle)

        local target = WerewireThrowTarget(target_x, target_y)
        target.layer = werewire.layer + 0.01
        self:addChild(target)

        target.target = werewire

        table.insert(self.targets, target)
    end

    self.kris_battler = Game.battle:getPartyBattler("kris")
    self.susie_battler = Game.battle:getPartyBattler("susie")

    self.kris_battler.visible = false
    self.susie_battler.visible = false

    self.fake_susie = Sprite("acts/werewire/throw/susie_hold_kris", self.susie_battler.x, self.susie_battler.y)
    self.fake_susie:setScale(2, 2)
    self.fake_susie:setOriginExact(36, 68)
    self:addChild(self.fake_susie)

    self.throw_arrow = Sprite("acts/werewire/throw/arrow", self.kx, self.ky)
    self.throw_arrow:setScale(2, 2)
    self.throw_arrow:setOriginExact(0, 15)
    self.throw_arrow:setColor(1, 0, 0)
    self.throw_arrow.layer = 11
    self:addChild(self.throw_arrow)

    for i = 1, 42 do
        self.throw_offset[i] = 0
    end
end

function WerewireThrowAct:clear()
    self.kris_battler.visible = true
    self.susie_battler.visible = true

    self:remove()
end

function WerewireThrowAct:throw()
    self.throw_done = false

    Assets.playSound("ultraswing")

    self.fake_susie:setAnimation({"acts/werewire/throw/susie_throw", 2/30, false})

    self.fake_kris = Sprite("acts/werewire/throw/kris_thrown", self.kx, self.ky)
    self.fake_kris:setScale(2, 2)
    self.fake_kris:setOrigin(0.5, 0.5)
    self.fake_kris:setHitbox(20, 12, 35, 15)
    self.fake_kris.layer = 100
    self.fake_kris.rotation = self.angle
    self.fake_kris.physics.speed = self.power
    self.fake_kris.physics.gravity = self.throw_gravity
    self.fake_kris.physics.match_rotation = true
    self:addChild(self.fake_kris)

    self.throw_arrow.visible = false

    self.state = "THROW"

    return function() return self.state == "DONE", self.hit end
end

function WerewireThrowAct:update()
    self.updated_once = true

    if self.state == "WAIT" then
        self.angle = (self.angle + (math.rad(self.angle_speed) * DTMULT)) % math.rad(360)
        self.throw_arrow.rotation = self.angle

        local deg = math.deg(self.angle)
        if deg > 180 and deg <= 318 then
            self.angle_speed = -self.angle_speed
            self.angle = math.rad(318)
        elseif deg < 180 and deg >= 2 then
            self.angle_speed = -self.angle_speed
            self.angle = math.rad(2)
        end

        for i = 1, 42 do
            local add_y = self.throw_gravity + (self.throw_gravity * (i - 1))
            if i > 1 then
                self.throw_offset[i] = self.throw_offset[i - 1] + add_y
            else
                self.throw_offset[i] = add_y
            end
        end
    elseif self.state == "THROW" then
        for _,target in ipairs(self.targets) do
            if self.fake_kris:collidesWith(target) then
                table.insert(self.hit, target.target)
                target:slash(self.kris_battler)
            end
        end

        if self.fake_kris.x > 700 or self.fake_kris.y < -40 then
            self.fake_kris:remove()

            self.fake_kris = ActorSprite("kris")
            self.fake_kris:setPosition(-40, self.kris_battler.y)
            self.fake_kris:setSprite("battle/idle")
            self.fake_kris:setScale(2, 2)
            self.fake_kris:setOrigin(0.5, 1)
            self.fake_kris.physics.speed_x = 20
            self:addChild(self.fake_kris)

            self.state = "RETURN"
        end
    elseif self.state == "RETURN" then
        if self.fake_kris.x >= self.kris_battler.x then
            self.fake_kris.x = self.kris_battler.x
            self.fake_kris.physics.speed_x = 0

            self.state = "DONE"
        end
    end

    super:update(self)
end

function WerewireThrowAct:draw()
    super:draw(self)

    if not self.updated_once then return end

    if self.state == "WAIT" then
        local lx, ly = math.cos(self.angle) * self.power, math.sin(self.angle) * self.power

        love.graphics.setColor(Utils.mergeColor(COLORS.blue, COLORS.white, 0.5))
        love.graphics.setLineWidth(2)
        for i = 1, 12 do
            local x1 = (self.kx + (lx * (i - 1) * 2))
            local y1 = (self.ky + (ly * (i - 1) * 2)) + self.throw_offset[i * 2]

            local x2 = (self.kx + (lx * i * 2))
            local y2 = (self.ky + (ly * i * 2)) + self.throw_offset[(i + 1) * 2]

            love.graphics.circle("fill", x1, y1, 4)
            love.graphics.line(x1, y1-1, x2, y2-1)
        end
    end

    love.graphics.setColor(1, 1, 1)
end

return WerewireThrowAct