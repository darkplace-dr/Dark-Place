local Elevator, super = Class(Event)

function Elevator:init(data)
    super.init(self, data.center_x, data.center_y, data.width, data.height)

    self.solid = true
    self:setOrigin(0.5, 1)
    self:setSprite("world/maps/dunes/wild_east/objects/bell_1")
end

function Elevator:onInteract(chara, dir)
    Assets.playSound("wild_east_bell")
    self:setSprite("world/maps/dunes/wild_east/objects/bell", 1/10)
    Game.world.timer:after(0.6, function()
        self:setSprite("world/maps/dunes/wild_east/objects/bell_1")
    end)
    --return true
end

return Elevator