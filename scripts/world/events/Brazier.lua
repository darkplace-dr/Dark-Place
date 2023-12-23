---@class Brazier : Event
---@overload fun(...) : Brazier
local Brazier, super = Class(Event, "brazier")

function Brazier:init(data)
	super.init(self, data.x, data.y, data.w, data.h)

    local properties = data.properties or {}

    self:setOrigin(0.5, 0.5)
    self:setScale(2)
	
	self.lit = properties["lit"]
	self.can_light = properties["lit"]
	self.time = properties["time"]
	self.tr = 0
	
	local spritedir = "world/events/brazier_unlit"
	if self.lit then
		spritedir = "world/events/brazier_lit"
	end
    self.sprite = Sprite(spritedir)
    self:addChild(self.sprite)

    self:setSize(self.sprite:getSize())
    self:setHitbox(1, 5, 18, 14)

    self.solid = true
	
	self.held = false
	
	self.burn_collider = CircleCollider(self, 10, 12, 18)
end

function Brazier:postLoad()
	self.old_parent = self.parent
end

function Brazier:onInteract(player, dir)
	Assets.playSound("noise")
    self:setParent(player)
	self.x = player.width/2
	self.y = -6
	self:setScale(1,1)
	
	self.held = true
	player.holding = self
	self.burn_collider.y = 48

    return true
end

function Brazier:update()
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
	
	if self.held and Input.pressed("confirm") and not Game.world:checkCollision(Game.world.player.interact_collider[Game.world.player.facing]) and not Game.battle then
		Assets.playSound("noise")
		self:setParent(Game.world)
		print(self.old_parent == self.parent)
		self.held = false
		Game.world.player.holding = nil
		self.burn_collider.y = 12
		if Game.world.player.facing == "down" then
			self.x = Game.world.player.x
			self.y = Game.world.player.y + 20
		elseif Game.world.player.facing == "up" then
			self.x = Game.world.player.x
			self.y = Game.world.player.y - 42
		elseif Game.world.player.facing == "left" then
			self.x = Game.world.player.x - 42
			self.y = Game.world.player.y - 20
		else
			self.x = Game.world.player.x + 42
			self.y = Game.world.player.y - 20
		end
		self:setScale(2,2)
	end
	
	if self.lit and self.time and self.tr > 0 then
		self.tr = self.tr - DT
		if self.tr <= 0 then
			self.lit = false
			self.can_light = false
			self.sprite:setSprite("world/events/brazier_unlit")
		end
	end
end

function Brazier:draw()
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

function Brazier:getDebugInfo()
    local info = super.getDebugInfo(self)
    table.insert(info, "Lit: " .. (self.lit and "True" or "False"))
    return info
end

function Brazier:setAlight()
	self.lit = true
	self.can_light = true
	self.sprite:setSprite("world/events/brazier_lit")
	if self.time then
		self.tr = self.time
	end
end

function Brazier:onRemove(parent)
	self.data = nil
    if parent:includes(World) or parent.world then
        self.world = nil
    end
end

return Brazier
