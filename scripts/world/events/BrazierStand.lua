---@class BrazierStand : Event
---@overload fun(...) : BrazierStand
local BrazierStand, super = Class(Event, "brazierstand")

function BrazierStand:init(data)
	super.init(self, data.x, data.y, data.w, data.h)

    local properties = data.properties or {}

    self:setScale(2)
	
	self.lit = properties["lit"]
	self.can_light = properties["lit"]
	self.time = properties["time"]
	self.tr = 0
	
	self.flag = properties["flag"]
	
	local spritedir = "world/events/brazier_stand_unlit"
	if self.lit or Game:getFlag(self.flag) then
		spritedir = "world/events/brazier_stand_lit"
		self.lit = true
		self.can_light = true
	end
    self.sprite = Sprite(spritedir, 0, 0)
    self:addChild(self.sprite)

    self:setSize(self.sprite:getSize())
    self:setHitbox(1, 26, 18, 14) -- +21

    self.solid = true
	
	self.held = false
	
	self.burn_collider = CircleCollider(self, 10, 33, 18)
end

function BrazierStand:postLoad()
	self.old_parent = self.parent
	self.y = self.y - 42
end

function BrazierStand:update()
	super.update(self)
	
	-- TODO: Make brazier hot
	if Game.world then
		for _,event in ipairs(Game.world.map.events) do
			if event ~= self and self.burn_collider:collidesWith(event) then
				if self.lit then
					if (not event.lit) and event.setAlight then
						event:setAlight()
					end
				elseif event.lit then
					self:setAlight()
				end
			end
		end
	end
	
	if self.lit and self.time and self.tr > 0 then
		self.tr = self.tr - DT
		if self.tr <= 0 then
			self.lit = false
			self.can_light = false
			self.sprite:setSprite("world/events/brazier_stand_unlit")
		end
	end
end

function BrazierStand:draw()
    super.draw(self)
    if DEBUG_RENDER then
        self.collider:draw(1, 0, 1)
        self.burn_collider:draw(1, 1, 0)
    end
	
	if self.time and self.tr > 0 then
		Draw.setColor({0.5,0.5,0.5})
		love.graphics.rectangle("fill", 0, -8, 20, 2)

		Draw.setColor({1,0,0})
		love.graphics.rectangle("fill", 0, -8, 20 * (self.tr/self.time), 2)
	end
end

function BrazierStand:getDebugInfo()
    local info = super.getDebugInfo(self)
    table.insert(info, "Lit: " .. (self.lit and "True" or "False"))
    return info
end

function BrazierStand:setAlight()
	self.lit = true
	self.can_light = true
	self.sprite:setSprite("world/events/brazier_stand_lit")
	if self.flag then
		Game:setFlag(self.flag, true)
	end
	if self.time then
		self.tr = self.time
	end
end

return BrazierStand