local ElevatorButtons, super = Class(Event)

function ElevatorButtons:init(data)
    super.init(self, data.x, data.y, data.width, data.height)
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

            local incmenu = IncMenu({1, #self.elevator.floors}, self.elevator.current_floor)
            incmenu.elevatormode = true
            Game.world:spawnObject(incmenu, "ui")
            cutscene:wait(function() return incmenu.decision end)
            local decision = incmenu.decision
            incmenu:remove()
            if decision == self.elevator.current_floor then
                if Input.pressed("cancel") then return end
                cutscene:text("* (You're there.)")
                return
            end
            self.elevator:moveTo(decision)
        end)
    end
    return true
end

return ElevatorButtons