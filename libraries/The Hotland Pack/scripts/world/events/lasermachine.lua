local LaserMachine, super = Class(Event)

function LaserMachine:init(data)
    super.init(self, data.x, data.y, data.width, data.height)

    local properties = data.properties or {}


    self.color_options = {
        red = {1,0,0},
        green = {0,1,0},
        blue = {(20/255),(169/255),1},
        orange = {1,(148/255),0}
    }


    -- Turns the laser on or off.
    self.on = properties['on'] ~= false
    -- Controls the laser type; Red always hurts, blue hurts when moving, orange hurts when still.
    self.mode = properties['mode'] or "red"
    -- Blue lasers often move back and forth, switching directions when they hit a "bumper" trigger. Should this laser do that?
    self.moving = properties['moving'] or false
    -- How mouch damage should it do? Default is 10.
    self.damage = properties['damage'] or 10

    self.sprite = Sprite(self.on and "world/events/lasermachine/" .. self.mode or "world/events/lasermachine/off")
    self:addChild(self.sprite)
    self.sprite:setScale(2)
    self.sprite:play(1/30)

    self.siner = 0

    self.laser = Game.world:spawnBullet("machinelaser", self.x, self.y, self.height, self.mode, self.damage)

    
    if self.moving then
        self.physics.speed_x = -5
    end
    
    self:updateLaser()


end

function LaserMachine:getDebugInfo()
    local info = super.getDebugInfo(self)
    table.insert(info, "Mode: " .. self.mode)
    table.insert(info, "Damage: " .. self.damage)
    return info
end

function LaserMachine:update()
    super.update(self)

    self.laser.x = self.x
    self.laser.y = self.y
    self.siner = self.siner + 1 * DTMULT

end

function LaserMachine:updateLaser()
    self.laser.active = self.on
    self.laser.mode = self.mode
    self.laser_color = self.color_options[self.mode]
    self.sprite:set(self.on and "world/events/lasermachine/" .. self.mode or "world/events/lasermachine/off")
    if not self.on then
        self.physics.speed_x = 0
    elseif self.moving then
        -- This causes a "bug" that's also in the original game. I could fix it, but eh, can't be fucked.
        self.physics.speed_x = -5
    end


end

function LaserMachine:onEnter(player)
    if player then
        --player:explode()
    end
end



function LaserMachine:draw()
    super.draw(self)
    if self.on then
        Draw.setColor(self.laser_color, ((math.abs(math.sin((self.siner / 3))) / 2) + 0.5)) -- Could use Kristal.getTime(), but whatever
        love.graphics.rectangle("fill", 13, 32, 10, (self.laser.height)-15)
    end
end

return LaserMachine