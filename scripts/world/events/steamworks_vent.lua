local SteamworksVent, super = Class(Event)

function SteamworksVent:init(data)
    super.init(self, data.center_x, data.center_y, data.width, data.height)

    self:setSprite("world/maps/steamworks/objects/13_vent")
    self:setOrigin(0.5, 1)

    Game.world.timer:after(1/30, function ()
        self.layer = 0.3
    end)
end

function SteamworksVent:onInteract(chara, dir)
    Game.world:startCutscene(function(cutscene)
        cutscene:text("* A slightly open vent.")
        local opinion = cutscene:textChoicer("* Go inside?\n", {"Yes", "    No"})
        if opinion == 1 then
            Game.world:mapTransition("steamworks/14", "vent")
        end
    end)
    return true
end

return SteamworksVent