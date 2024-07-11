local SteamworksSign, super = Class(Event)

function SteamworksSign:init(data)
    super.init(self, data.center_x, data.center_y, data.width, data.height)

    self:setSprite("world/maps/steamworks/objects/06b_sign", 1/10)
    self:setOrigin(0.5, 1)

    Game.world.timer:after(1/30, function ()
        self.layer = 0.3
    end)
end

return SteamworksSign