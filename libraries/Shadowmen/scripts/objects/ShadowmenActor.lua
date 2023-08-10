local MyObject, super = Class(ActorSprite)

function MyObject:init(actor)
    super.init(self, actor)
	
	local gun = Sprite("npcs/shadowmen/gun", -22, 24)
	gun.visible = false
	gun.layer = self.layer - 4
	gun.rotation_origin_x = 0.5
	gun.rotation_origin_y = 0.5
	self.draw_children_below = self.layer
	
	self.gun = gun
	self:addChild(gun)
	
	local socks = Sprite("npcs/shadowmen/socks", 0, 0)
	socks:setScale(2)
	socks.visible = false
	-- socks.layer = self.layer + 4
	socks.rotation_origin_x = 0.5
	socks.rotation_origin_y = 0.5
	socks.hit = 0
	
	Utils.hook(socks, "update", function(orig, obj)
		orig(obj)
		
		local main = obj.copyMov
		
		if main then
			local x, y = main:getRelativePos(0, 0, Game.battle)
			obj.x = x
			obj.y = y
			obj:setFrame(self.frame)
		end
	end)
	
	-- socks:play(1, true)
	-- Utils.hook(socks, "draw", function(orig, obj)
	
		-- orig(obj)
	-- end)
	
	self.socks = socks
	
	-- self:addChild(socks)
end

function MyObject:update()
	super.update(self)
	
	-- self.socks.anim_routine = self.anim_routine
end

return MyObject