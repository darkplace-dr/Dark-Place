local OnOffSwitch, super = Class(Interactable)

function OnOffSwitch:init(data)
    super.init(self, data.x, data.y, nil, nil, data.properties)
    local properties = data.properties or {}
    self.on = properties['on'] ~= false
    self:setSprite("world/events/onoffswitch/" .. (self.on and "on" or "off"))
    self.sprite:play(2/30)

    self:setOrigin(0.5)
end

function OnOffSwitch:flip()
    Assets.playSound("switchpull")
    self.on = not self.on
    self:setSprite("world/events/onoffswitch/" .. (self.on and "on" or "off"))
    self.sprite:play(2/30)
end

return OnOffSwitch