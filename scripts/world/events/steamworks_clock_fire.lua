local SteamworksClockFire, super = Class(Event)

function SteamworksClockFire:init(data)
    super.init(self, data.center_x, data.center_y, data.width, data.height)

    self:setSprite("world/maps/steamworks/objects/17c_clock_fire", 1/7)
    self:setOrigin(0.5, 1)

    Game.world.timer:after(1/30, function ()
        self.layer = 0.3
    end)
end

return SteamworksClockFire