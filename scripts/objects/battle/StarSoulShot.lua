local Shot, super = Class(Object)

function Shot:init(x, y, angle)
    super:init(self, x, y)
    self.layer = BATTLE_LAYERS["above_bullets"]
    self.rotation = 0
    self:setOrigin(0.5, 0.5)
	self.sprite = Sprite("player/star")
	self.sprite:setOrigin(0.5, 0.5)
	self.sprite:setScale(2,2)
	self:addChild(self.sprite)
    self:setHitbox(1,1, 25,9)

    self.physics = {
        speed = 16,
        direction = angle,
    }
    
    self.hit_bullets = {}
end

function Shot:update()
    super:update(self)
    local sx, sy = self:localToScreenPos()
    if (sx >  SCREEN_WIDTH + self.sprite.width)
    or (sx <             0 - self.sprite.width)
    or (sy > SCREEN_HEIGHT + self.sprite.width)
    or (sy <             0 - self.sprite.width)
    then
        self:remove()
		if Game.battle.soul then
			Game.battle.soul.star = nil
		end
    end

    local bullets = Utils.filter(Game.stage:getObjects(Bullet), function(v)
        if self.hit_bullets[v] then return false end
        return v.onShot
    end)
    for _,bullet in ipairs(bullets) do
        if self:collidesWith(bullet) then
            bullet:onShot(self)
        end
    end
end

function Shot:draw()
    super:draw(self)
    if DEBUG_RENDER then
        self.collider:draw(1,0,0)
    end
end

return Shot