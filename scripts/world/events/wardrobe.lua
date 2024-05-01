local Wardrobe, super = Class(Event)

function Wardrobe:init(data)
    super.init(self, data.x, data.y, data.width, data.height)

    self:setOrigin(0.5, 1)
	
	self.solid = true
	
	self:setHitbox(0, 78, 60, 25)

    self:setSprite("world/events/devroom/wardrobe_closed")
end

function Wardrobe:onInteract(chara, dir)
    Game.world:startCutscene("devroom", "wardrobe", self)
    return true
end

return Wardrobe