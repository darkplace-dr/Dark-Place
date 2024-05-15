local PipisWall, super = Class(Object)

function PipisWall:init(x, y)
    super.init(self, x, y)
	
    self.sprite = Sprite("battle/bullets/sneo/pipis/wall")
    self.sprite.scale_x = 1
    self.sprite.scale_y = 2
    self.sprite:setColor(COLORS.lime)
    self:addChild(self.sprite)
	
    self.collider = Hitbox(self, 0, 0, self.sprite.width, 1)

    self.alpha = 0

    self.con = 0
    self.timer = 0
    self.type = 0
    self.siner = Utils.random(100)
	
    --self.init_x = self.x
end

function PipisWall:update()
    super.update(self)

    if self.con == 0 then
        if self.alpha < 1 then
            self.alpha = self.alpha + 0.1*DTMULT
        end
    end
	
    if self.con == 1 then
        if self.alpha > 0 then
            self.alpha = self.alpha - 0.1*DTMULT
        else
            self:remove()
        end
    end
	
    if self.type == 1 then
        self.siner = self.siner + 0.5*DTMULT
        self.x = (self.init_x + (math.sin(self.siner / 6)) * 48)*DTMULT
    end
end

return PipisWall