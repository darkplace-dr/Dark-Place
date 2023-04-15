local Wardrobe, super = Class(Event)

function Wardrobe:init(data)
    super:init(self, data.x, data.y, data.width, data.height)

    self:setOrigin(0.5, 1)
	
	self.solid = true
	
	self:setHitbox(0, 78, 60, 25)

    self:setSprite("objects/wardrobe_closed")
end

function Wardrobe:onInteract(chara, dir)
    Game.world:startCutscene("devroom", "wardrobe", self)
end

return Wardrobe