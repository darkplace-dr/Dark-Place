local ElevatorButtons, super = Class(Event)

function ElevatorButtons:init(data)
    super:init(self, data.x, data.y, data.width, data.height, data)

end

function ElevatorButtons:postLoad()
    self.elevator = Game.world.map:getEvent("elevator")
end

function ElevatorButtons:onInteract(chara)
    if #self.elevator.floors == 2 then
        Game.world:startCutscene(function(cutscene)
            cutscene:text("* (Ride the elevator?)")
            local choice = cutscene:choicer({"Ride", "Do not"})
            if choice == 1 then
                if self.elevator.current_floor == 1 then
                    self.elevator:moveTo(2)
                else
                    self.elevator:moveTo(1)
                end
            end
        end)
    else
        Game.world:startCutscene(function(cutscene)
            cutscene:text("* (Where will you ride the elevator to?)")
            local names = {}
            for i, floor in ipairs(self.elevator.floors) do
                names[i] = floor.name
            end
            local choice = cutscene:choicer(names)
            if choice == self.elevator.current_floor then
                cutscene:text("* (You're there.)")
                return
            end
            self.elevator:moveTo(choice)
        end)
    end
    return true
end

return ElevatorButtons