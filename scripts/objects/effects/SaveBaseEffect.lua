local SaveBaseEffect, super = Class(Object)

function SaveBaseEffect:init()
    super.init(self)
    --self.color = {0, 1, 0}
    --self.back_color = back_color or color
    --self.fill = {0, 0, 0}
	self.offset = 0
    self.speed = 5
    self.size = 50
	self.layer = BATTLE_LAYERS["above_battlers"]
    self.image = Assets.getTexture("effects/spells/dess/savebase")
	self.alpha = 0
	
	self:fadeTo(0.5, 1)
	
	Game.battle.timer:after(2, function(wait)
	
		self:fadeOutAndRemove(0.5)
	
	end)
	
end

function SaveBaseEffect:update()
    super.update(self)
	self.offset = self.offset + self.speed*DTMULT

    if self.offset > self.size*2 then
        self.offset = self.offset - self.size*2
    end

	
end

function SaveBaseEffect:draw()
    super.draw(self)

	self:drawFront()
end

function SaveBaseEffect:drawFront()
    --local r,g,b,a = unpack(self.color)
    --love.graphics.setColor(r,g,b, self.alpha)
	for x = 0, 740, 50 do
		for y = 0, 580, 50 do
			love.graphics.draw(self.image, x - self.offset, y - self.offset)
		end
	end
end

return SaveBaseEffect