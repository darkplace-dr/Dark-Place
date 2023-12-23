local ColorSlash, super = Class(Bullet)

function ColorSlash:init(x, y, dir, speed, color)
    -- Last argument = sprite path
    super.init(self, x, y, "battle/bullets/zero_boss/PaintSlash")
    self.flip_x = true
    self:setSprite("battle/bullets/zero_boss/PaintSlash", 1/30, false, function()
        self:remove()
    end)
    self.collider = Hitbox(self, 0, 0, 87, 43)
    self:setScale(4, 4)
    self:setOrigin(0.5, 0.5)
    if color:lower() == "blue" then
        self.color = {0, 1, 1}
    elseif color:lower() == "orange" then
        self.color = {1,(148/255),0}
    elseif color:lower() == "green" then
        self.color = {0, 1, 0}
    end
    Assets.playSound("zero/color_slash_" .. math.ceil(Utils.random(3)))
    -- Amount to heal for green bullets.
    self.healing = 5

    self.mytype = color


    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
    self.destroy_on_hit = false


    Game.battle.timer:after(3/30, function ()
        self.collider = nil
    end)


end

function ColorSlash:update()
    -- For more complicated bullet behaviours, code here gets called every update

    super.update(self)
end


function ColorSlash:getDebugInfo()
    local info = super.getDebugInfo(self)
    table.insert(info, "Color: " .. self.mytype)
    return info
end

--
function ColorSlash:onCollide(soul)

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
return ColorSlash