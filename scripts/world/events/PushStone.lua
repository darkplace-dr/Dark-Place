local PushStone, super = Class(PushBlock, "stone")

function PushStone:init(data)
    super:init(self, data.x, data.y, data.w, data.h, data.properties, data.sprite, data.solved_sprite)
	
	properties = properties or {}

    self.default_sprite = properties and properties["sprite"] or sprite or "world/events/push_stone"
    self.solved_sprite = properties and properties["solvedsprite"] or properties["sprite"] or solved_sprite or sprite or "world/events/push_stone_solved"
	
	self:setSprite(self.default_sprite)
end

function PushStone:checkCollision(facing)
    local collided = false

    local dx, dy = Utils.getFacingVector(facing)
    local target_x, target_y = self.x + dx * self.push_dist, self.y + dy * self.push_dist

    local x1, y1 = math.min(self.x, target_x), math.min(self.y, target_y)
    local x2, y2 = math.max(self.x + self.width, target_x + self.width), math.max(self.y + self.height, target_y + self.height)

    local bound_check = Hitbox(self.world, x1 + 1, y1 + 1, x2 - x1 - 2, y2 - y1 - 2)

    Object.startCache()
    for _,collider in ipairs(Game.world.map.stone_collision) do
        if collider:collidesWith(bound_check) then
            collided = true
            break
        end
    end
    if not collided then
        self.collidable = false
        collided = self.world:checkCollision(bound_check)
        self.collidable = true
    end
    Object.endCache()

    return collided
end

function PushStone:onSolved()
    self:setSprite(self.solved_sprite)
end

function PushStone:onUnsolved()
    self:setSprite(self.default_sprite)
end

return PushStone