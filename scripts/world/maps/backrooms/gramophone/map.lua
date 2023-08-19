local Gramophone, super = Class(Map)

function Gramophone:onEnter()
    super.onEnter(self)

    Game.stage:addFX(VHSFilter(), "vhs")
    self.gramophone_music = Music("burningmemory", 0)
end

function Gramophone:onExit()
    super.onExit(self)
	
    Game.stage:removeFX("vhs")
	self.gramophone_music:remove()
end

return Gramophone