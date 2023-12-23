-- Feel free to use this as a base for any color attacks you want to use.
local ColorBullet, super = Class(Bullet)

function ColorBullet:init(x, y, dir, speed, color)
    -- Last argument = sprite path
    super.init(self, x, y, "battle/bullets/smallbullet")
    if color:lower() == "blue" then
        self.color = {0, 1, 1}
    elseif color:lower() == "orange" then
        self.color = {1,(148/255),0}
    elseif color:lower() == "green" then
        self.color = {0, 1, 0}
    end
    
    -- Amount to heal for green bullets.
    self.healing = 5

    self.mytype = color


    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
end

function ColorBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super.update(self)
end

function ColorBullet:getDebugInfo()
    local info = super.getDebugInfo(self)
    table.insert(info, "Color: " .. self.mytype)
    return info
end

--
function ColorBullet:onCollide(soul)

    -- Blue check
    if self.mytype:lower() == "blue" then
        if soul:isMoving() then
            super.onCollide(self, soul)
        end

    -- Orange check
    elseif self.mytype:lower() == "orange" then
        if not soul:isMoving() then
            super.onCollide(self, soul)
        end    

    -- Green check
    elseif self.mytype:lower() == "green" then
        self:getTarget():heal(self.healing)
        self:remove()
    
    else
        super.onCollide(self, soul)
    end

end
--]]
return ColorBullet