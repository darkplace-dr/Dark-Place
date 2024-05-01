local ScissorDancer, super = Class(WorldBullet, "scissor_dancer")

function ScissorDancer:init(data)
    super:init(self, data.x, data.y, "events/scissor_dancer/dancer")
	
	self:setOrigin(0.5,1)
	
	self.path = data.properties["path"]
	self.speed = data.properties["speed"] or 4
	self.solid = false
	self.path_progress = data.properties["path_progress"] or 0
	
	self.damage = 15
	
	Game.stage.timer:every(3, function()
		Game.stage.timer:script(function(wait)
			wait(1)
			self.sprite:setAnimation({"events/scissor_dancer/scissor", 1/10, false, callback = function()
				self.sprite:setSprite("events/scissor_dancer/dancer")
				self.sprite.scale_x = self.sprite.scale_x * -1
				if self.sprite.scale_x > 0 then
					self.sprite:setOrigin(0, 0)
				else
					self.sprite:setOrigin(1, 0)
				end
			end})
		end)
    end)
end

function ScissorDancer:onInteract(player, dir)
	super:onInteract(self, player, dir)
	Assets.playSound("scissorbell", 1, Utils.random(0.7, 1))
	return true
end

function ScissorDancer:postLoad()
	self:slidePath(self.path, {speed = self.speed})
	self.physics.move_path["progress"] = self.path_progress
end

function ScissorDancer:onTextEnd()
	super:onTextEnd(self)
end

function ScissorDancer:getDebugInformation()
	local info = super:getDebugInformation(self)
	table.insert(info, "Path: "..tostring(self.path))
	table.insert(info, "Speed: "..tostring(self.speed))
	return info
end

function ScissorDancer:getDrawColor()
    return 1, 1, 1, 1
end

function ScissorDancer:draw()
    super.draw(self)
    if DEBUG_RENDER then
        self.collider:draw(0,1,0,1)
    end
end

return ScissorDancer