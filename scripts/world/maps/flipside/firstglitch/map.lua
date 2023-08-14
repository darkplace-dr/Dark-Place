local FirstGlitch, super = Class(Map)

function FirstGlitch:onEnter()
    super.onEnter(self)
	
    Game.world:spawnObject(FirstGlitchBG(), 100)
	
    self.scanline_overlay = Sprite("world/maps/flipside/scanline_overlay", 0, 0)
    self.scanline_overlay:setScale(2)
    self.scanline_overlay:setWrap(true)
    self.scanline_overlay:setLayer(9999)
    self.scanline_overlay:setParallax(0)
    Game.world:addChild(self.scanline_overlay)
	
    Game.world:addFX(ShaderFX(Mod.shaders["perspective_y"]), "perspective_y")
end

function FirstGlitch:onExit()
    Game.world:removeFX("perspective_y")
end

return FirstGlitch