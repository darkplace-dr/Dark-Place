local WorldBullet, super = Class(WorldBullet)

function WorldBullet:onCollide(soul)
	if Game.world.player.invincible_colors then
		self:explode()
		return
	end
	
    super.onCollide(self, soul)
end

return WorldBullet