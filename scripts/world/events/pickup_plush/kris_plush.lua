---@class kris_plush : Pickup
---@overload fun(...) : kris_plush
local kris_plush, super = Class(Event, "kris_plush")

function kris_plush:init(data)
	super.init(self, data.x, data.y, data.w, data.h)

    local properties = data.properties or {}

    self:setOrigin(0.5, 0.5)
    self:setScale(2)
	
    self.sprite = Sprite("world/events/pickup_plush/kris_plush")
    self:addChild(self.sprite)

    self:setSize(self.sprite:getSize())
    self:setHitbox(1, 2, 18, 17)

    self.solid = true
	
	self.held = false
	
	self.place_math = {
		["up"] = {0, -42},
		["down"] = {0, 20},
		["left"] = {-42, -20},
		["right"] = {42, -20},
	}
end

function kris_plush:postLoad()
	self.old_parent = self.parent
end

function kris_plush:onInteract(player, dir)
	Assets.playSound("item")
    self:setParent(player)
	self.x = player.width/2
	self.y = -6
	self:setScale(1,1)
	
	self.held = true
	player.holding = self

    return true
end

function kris_plush:update()
	super.update(self)
	
	if self.held and Input.pressed("confirm") and self:canPlace(Game.world.player) then
		Assets.playSound("item")
		self:setParent(Game.world)
		self.held = false
		Game.world.player.holding = nil
		self.x = Game.world.player.x + self.place_math[Game.world.player.facing][1]
		self.y = Game.world.player.y + self.place_math[Game.world.player.facing][2]
		self:setScale(2,2)
	end
end

function kris_plush:canPlace(player)
	return not Game.world:checkCollision(player.interact_collider[player.facing])
end

function kris_plush:onRemove(parent)
	self.data = nil
    if parent:includes(World) or parent.world then
        self.world = nil
    end
end

return kris_plush