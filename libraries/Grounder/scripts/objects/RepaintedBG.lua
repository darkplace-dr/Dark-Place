local BG, super = Class(Object)

function BG:init(color, back_color, fill)
    super:init(self)
    self.color = color
    self.back_color = back_color or color
    self.fill = fill or {0, 0, 0}
	self.offset = 0
    self.speed = 1
    self.size = 50
	self.layer = BATTLE_LAYERS["bottom"]
end

function BG:update(dt)
    super:update(self, dt)
    self.fade = Game.battle.transition_timer / 10
	self.offset = self.offset + self.speed*DTMULT

    if self.offset > self.size*2 then
        self.offset = self.offset - self.size*2
    end
end

function BG:draw()
    super:draw(self)

    self:drawFill()
	self:drawBack()
	self:drawFront()
end

function BG:drawFill()
    local r,g,b,a = unpack(self.fill)
    love.graphics.setColor(r,g,b, a or self.fade)
    love.graphics.rectangle("fill", -8, -8, SCREEN_WIDTH+16, SCREEN_HEIGHT+16)
end

function BG:drawBack()
    local r,g,b,a = unpack(self.back_color)
    love.graphics.setColor(r,g,b, a or self.fade/2)
	for x = -100, 740, 50 do
		for y = -100, 580, 50 do
			repaintedbg = Assets.getTexture("repaintedbg")
			love.graphics.draw(repaintedbg, x + self.offset/2, y + self.offset/2 + 10)
		end
	end
end

function BG:drawFront()
    local r,g,b,a = unpack(self.color)
    love.graphics.setColor(r,g,b, a or self.fade)
	for x = 0, 740, 50 do
		for y = 0, 580, 50 do
			repaintedbg = Assets.getTexture("repaintedbg")
			love.graphics.draw(repaintedbg, x - self.offset, y - self.offset)
		end
	end
end

return BG