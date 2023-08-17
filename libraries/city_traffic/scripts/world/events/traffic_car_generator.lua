local TrafficCarGenerator, super = Class(Event)

function TrafficCarGenerator:init(data)
    super.init(self, data)

    local pr = data["properties"]

    -- The time between cars being created, defaults to `30` (In frames, at 30fps)
    self.gen_rate       = pr["gen_rate"]        or 30
    -- The speed at which the cars this generator makes will move, defaults to `20` (in pixels per frame, at 30fps)
    self.gen_speed      = pr["gen_speed"]       or 20
    -- The interval at which a car creation will be skipped, or `0` for no skipping, defaults to `0`
    self.skip_every     = pr["skip_every"]      or 0
    -- Whether to pre-generate cars on entering the room, defaults to `true`
    self.prepopulate    = pr["prepopulate"]     or true
    -- Whether the cars spawned by the generator are walking, defaults to `false`
    self.walking        = pr["walking"]         or false
    -- Whether the cars spawned by the generator will always be walking, defaults to `false`
    self.always_walking = pr["always_walking"]  or false
    -- The type (direction) of car, defaults to `"down"` (can only be set to down please don't try to change it)
    self.car_type       = pr["car_type"]        or "down"
    -- The car sprite being used, defaults to `"traffic_car"`
    self.car_sprite     = pr["car_sprite"]      or "traffic_car"
    -- The group that this generator is in, defaults to `0`
    self.group          = pr["group"]           or 0

    self.makecar        = 0
    self.carcount       = 0
    self.timer          = 0
    self._active        = true
    self.speedadjust    = false

    Kristal.callEvent("onTrafficCarGeneratorInit", self)
end

function TrafficCarGenerator:update()
    if Kristal.callEvent("beforeTrafficCarGeneratorUpdate", self) then
        return
    end

    if self.prepopulate then
        -- This does not take skipping into account, but the same happens in DELTARUNE
        for i=0,5 do
            self:makeCar(self.x, self.y + ((self.gen_speed * self.gen_rate) * i))
        end

        self.prepopulate = false
    end

    if self._active and not Game.world.cutscene and not Game.world.menu and not Game.world.car_collision then
        self.timer = self.timer + (0.25 * DTMULT)
        if not self.walking then
            self.timer = self.timer + (0.75 * DTMULT)
        end
    end

    if (self.timer >= self.gen_rate) then
        self.carcount = self.carcount + 1
        if self.skip_every ~= 0 then
            if self.carcount % self.skip_every == 0 then
                self.makecar = 0
            else
                self.makecar = 1
            end
        else
            self.makecar = 1
        end

        if self.makecar == 1 then
            self:makeCar(self.x, self.y)

            self.makecar = 0
        end
        self.timer = 0
    end

    Kristal.callEvent("onTrafficCarGeneratorUpdate", self)
end

function TrafficCarGenerator:makeCar(x, y)
    if Kristal.callEvent("beforeTrafficCarGeneratorMakeCar") then
        return
    end
    local car = Registry.createEvent("traffic_car", {x = x, y = y})
    car.alwayswalking   = self.always_walking
    car.car_path        = self.car_sprite
    car.group           = self.group
    car.remspeed        = self.gen_speed
    car.speed           = self.gen_speed
    car.speedadjust     = self.speedadjust
    car.walking         = self.walking
    car:setDirection(self.car_type)

    Game.world:spawnObject(car)
    Kristal.callEvent("onTrafficCarGeneratorMakeCar", self, car)
end

return TrafficCarGenerator