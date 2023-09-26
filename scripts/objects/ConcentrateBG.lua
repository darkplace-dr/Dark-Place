-- Yes this is just StarsBG I'm terrible at making backgrounds like this cut me some slack here
local ConcentrateBG, super = Class(Object)

function ConcentrateBG:init(color, back_color, fill)
    super.init(self)

    self.color = color
    self.back_color = back_color or color
    self.fill = fill or {0, 0, 0}
	self.offset = 0
    self.speed = 2
    self.size = 63
	self.layer = BATTLE_LAYERS["bottom"]
	self.alpha_fx = self:addFX(AlphaFX())
    self.image = Assets.getTexture("objects/concentrating")
    self.no_x = false
end

function ConcentrateBG:update()
    super.update(self)
    if Game.battle then
    self.fade = Game.battle.transition_timer / 10
    end
	self.offset = self.offset + self.speed*DTMULT

    if self.offset > self.size*2 then
        self.offset = 0
    end

end

function ConcentrateBG:draw()
    super.draw(self)

    self:drawFill()
	self:drawFront()
end

function ConcentrateBG:drawFill()
    local r,g,b,a = unpack(self.fill)
    love.graphics.setColor(r,g,b, a or self.fade)
    love.graphics.rectangle("fill", -8, -8, SCREEN_WIDTH+16, SCREEN_HEIGHT+16)
end

function ConcentrateBG:drawFront()
    local r,g,b,a = unpack(self.color)
    love.graphics.setColor(r,g,b, a or self.fade)
    love.graphics.setColor(1,1,1,0.5)
	for x = 0, 1100, 130 do
		for y = 0, 880, 63 do
			love.graphics.draw(self.image, x - self.offset, y - self.offset)
		end
	end
end

return ConcentrateBG