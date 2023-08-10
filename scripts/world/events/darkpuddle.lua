local DarkPuddle, super = Class(Event)

function DarkPuddle:init(data)
    super.init(self, data)

    self.outline = Sprite("world/maps/chapter1/ribbitmodbt/cliffs/darkwake_puddle_outline", 245, 210)
    self.outline:setScale(2)
    self.outline.layer = 6
	self:addChild(self.outline)
	
    self.puddle = Sprite("world/maps/chapter1/ribbitmodbt/cliffs/darkwake_puddle", 247, 220)
    self.puddle:setColor(68/255, 17/255, 82/255)
    self.puddle:setScale(2)
    self.puddle.layer = 7
	self:addChild(self.puddle)
	
    --[[self.puddle_mask = Sprite("world/maps/chapter1/ribbitmodbt/cliffs/darkwake_puddle", 247, 220)
    self.puddle_mask:setScale(2)
    self.puddle_mask.layer = 4
    self.puddle_mask.alpha = 0.5
	self:addChild(self.puddle_mask)]]
end

return DarkPuddle
