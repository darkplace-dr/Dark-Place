local Alley2, super = Class(Map)

function Alley2:load()
    super.load(self)

    Game.world.timer:after(3, function()
    
        --cutscene:wait(cutscene:mapTransition("cybercity/alley2"))

        local dumpevent = Game.world:getEvent("spammydumpster")

        if dumpevent then
            Game.world.timer:every(18, function()
                if Game:getFlag("weird") then
                    dumpevent:shake()
                end
            end)
        end

    end)
    
end

return Alley2