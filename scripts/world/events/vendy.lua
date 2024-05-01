local Vendy, super = Class(Event)

function Vendy:init(data)
    super.init(self, data.center_x, data.center_y, data.width, data.height)

    self.solid = true
    self:setOrigin(0.5, 1)
    self:setSprite("world/maps/steamworks/objects/23_vendy")
end

function Vendy:onInteract(chara, dir)
    Game.world:lightShopTransition("vendy")
    return true
end

return Vendy