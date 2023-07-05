local DiamondWhite, super = Class(Bullet)

function DiamondWhite:init(x, y, dir)
    super:init(self, x, y, "bullets/rudinn/diamond_white")

	self:setScale(1, 1)
    self.rotation = dir
    self.physics.speed = 6
	self.physics.match_rotation = true
end

return DiamondWhite