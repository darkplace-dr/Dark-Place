local berdly_desk, super = Class(Event)

function berdly_desk:init(data)
    super.init(self, data.center_x, data.center_y, data.width, data.height)

    self:setOrigin(0.5, 1)
    self:setSprite("party/berdly/light/desk_sleep")

    Game.world.timer:after(1/30, function ()
        self.layer = 0.4
    end)
end

return berdly_desk