local WorldCutscene, super = Class("WorldCutscene", true)

function WorldCutscene:showNametag(text, top)
	if self.nametag then self.nametag:remove() end

	self.nametag = Nametag(text, top)
	self.nametag.layer = WORLD_LAYERS["textbox"]
    Game.world:addChild(self.nametag)
    self.nametag:setParallax(0, 0)
end

function WorldCutscene:changeNametag(text)
	self.nametag:changeText(text)
end

function WorldCutscene:hideNametag()
	if self.nametag then
        self.nametag:remove()
        self.nametag = nil
    end
end

return WorldCutscene