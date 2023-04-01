local RibbitBG, super = Class(Object)

function RibbitBG:init(color)
    super:init(self)


	self.colors = {

		--purple = unpack({0.70196078431,0.23921568627,0.89803921568})
		purple = {0.70196078431,0.23921568627,0.89803921568}

	}

	self.color = self.colors[color] or self.colors.purple

	local vaporback = Sprite("objects/ribbitbg/vaporback", 0, 0)
    vaporback:setColor(self.color)
	vaporback:play(0.02, true)
	vaporback:setScale(1)
	self:addChild(vaporback)
	
	self.layer = BATTLE_LAYERS["bottom"]
end

return RibbitBG