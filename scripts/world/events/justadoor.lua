local justadoor, super = Class(Event)

function justadoor:init(data)
    super.init(self, data)

    self.sprite = Sprite("world/events/floor2/justadoor")
    self.sprite:setScale(2)
    self:addChild(self.sprite)

    self.solid = false
end

function justadoor:onInteract(player, dir)
    Game.world:startCutscene(function(cutscene)
        cutscene:text("* You have a big feeling you shouldn't enter this place.")
        cutscene:text("* Still enter?")
		local enter = cutscene:choicer({"Enter", "Do not"})
		if enter == 1 then
			Game.world:mapTransition("floor2/hell")
		end
    end)
    return true
end

return justadoor