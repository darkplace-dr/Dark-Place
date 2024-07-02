local SteamworksGate, super = Class(Event)

function SteamworksGate:init(data)
    super.init(self, data.center_x, data.center_y, data.width, data.height)

    self:setSprite("world/events/dunes/steamworks_gate_1")
    self:setOrigin(0.5, 1)

    Game.world.timer:after(1/30, function ()
        self.layer = 0.3 -- Stupid layers I hate 'em
    end)
end

return SteamworksGate