local LaserBumper, super = Class(Event)

-- All this event does is tell any moving lasers that touch it to turn around.

function LaserBumper:init(x,y,width,height)
    super.init(self,x,y,width,height)
end

function LaserBumper:update()
    super.update(self)
    local lasers = Game.world.map:getEvents("lasermachine")

    for i, laser in ipairs(lasers) do
        if self:collidesWith(laser) and laser.moving then
            laser.physics.speed_x = -laser.physics.speed_x
            break
        end
        
    end
end

return LaserBumper