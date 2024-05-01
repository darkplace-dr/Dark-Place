local soda, super = Class(Event)

function soda:init(data)
    super.init(self, data)

    self.sprite = Sprite("world/soda")
    self.sprite:setScale(2)
    self.sprite:setOrigin(0, 0.5)
    self:addChild(self.sprite)
    self.solid = true
end

function soda:onInteract(player, dir)
    Assets.stopAndPlaySound("bigshot")
    return true
end

return soda