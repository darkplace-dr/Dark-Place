local DevRoom, super = Class(Map)

function DevRoom:onEnter()
    super.onEnter(self)

    self.month = tonumber(os.date("%m"))
    self.day = tonumber(os.date("%d"))
    Log:print(self.month.."/"..self.day)

    if self.month == 10 and self.day == 17 then
        --Happy birthday, JARU!
        Assets.playSound("partyhonk")
    else
        Game.world.map:getEvent(95):remove()
    end

    Game.world:spawnObject(SpaceBG(), "objects_bg")
end

return DevRoom