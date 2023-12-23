local Web, super = Class(Event, "web")

function Web:init(data)
	super.init(self, data.properties.actor, data.x, data.y, data.properties)
	
	self.default_sprite = properties and properties["sprite"] or "world/events/web"
	self:setSprite(self.default_sprite)
	
	self.x = data.x
	self.y = data.y
	
	self.origin_x = 0.5
	self.origin_y = 0.5
end

function Web:onEnter(chara)
	local precol = false
	for k,v in ipairs(self.world.map:getEvents("web")) do
		if v:collidesWith(chara) and v ~= self then
			precol = true
		end
	end
	if precol == false then
		if chara == Game.world.player then
			Game.world.player.walk_speed = 2
		elseif chara:includes(ChaserEnemy) then
			chara.chase_speed = chara.chase_speed / 2
		end
	end
end

function Web:onExit(chara)
	local precol = false
	for k,v in ipairs(self.world.map:getEvents("web")) do
		if v:collidesWith(chara) and v ~= self then
			precol = true
		end
	end
	if precol == false then
		if chara == Game.world.player then
			Game.world.player.walk_speed = 4
		elseif chara:includes(ChaserEnemy) then
			chara.chase_speed = chara.chase_speed * 2
		end
	end
end

return Web