local SmallBullet, super = Class(Bullet)

function SmallBullet:init(x, y, flip)
    -- Last argument = sprite path
    super:init(self, x, y, "battle/bullets/deoxynn/mouse_house")

    -- Origin point (will be rotated around it)
    self:setOrigin(1, 0)
	
	self.scale_x = 1
	self.scale_y = 1

    -- Don't destroy this bullet when it damages the player
    self.destroy_on_hit = false
end

function SmallBullet:update()
    
end

return SmallBullet