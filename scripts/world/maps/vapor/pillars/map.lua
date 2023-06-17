local Pillars, super = Class(Map)

function Pillars:onEnter()
    super.onEnter(self)
    Game.world:spawnObject(VaporBG(0, 0), "objects_bg")

    Game.stage:addFX(VHSFilter(), "vhs")
	
    local mountains = Sprite("objects/vaporbg/mountains", 0, 105)
    mountains:setScale(1)
    mountains:setLayer(Game.world:parseLayer("objects_bg"))
    mountains.wrap_texture_x = true
    mountains.parallax_x = 0.1
    mountains.parallax_y = 0.1
    Game.world:addChild(mountains)
end

function Pillars:onExit()
    Game.stage:removeFX("vhs")
end

return Pillars