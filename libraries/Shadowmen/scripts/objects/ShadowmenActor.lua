local MyObject, super = Class(ActorSprite)

function MyObject:init(actor)
    super:init(self, actor)
	
	self.draw_children_below = 0
	self.draw_children_above = 1
	
	local gun = Sprite("npcs/shadowmen/gun", -22, 24)
	gun.visible = false
	gun.layer = self.layer - 4
	gun.rotation_origin_x = 0.5
	gun.rotation_origin_y = 0.5
	
	self.gun = gun
	self:addChild(gun)
end

-- function MyObject:update()
	-- super:update(self)
	
	-- self.socks.anim_routine = self.anim_routine
-- end

-- function MyObject:draw()
	-- self.socks:draw()
-- end

return MyObject