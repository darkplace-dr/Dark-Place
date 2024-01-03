local Room1, super = Class(Map)

function Room1:load()
    super.load(self)
end

function Room1:onEnter()
    super.onEnter(self)
    if Game:getFlag("CONNECTION.beatcyber", false) == true then
        self.corebg = Game.world:spawnObject(GlowBG(0, 0), "objects_bg")
        self.corebg:setLayer(Game.world:parseLayer("objects_bg")+0.1)
    else
        Game.world:spawnObject(background_cyber_lines(0, 0), "objects_bg")
    end

    local cyber_bg = Sprite("world/parallax/cyber_parallax_clouds", 0, 0)
    local cyber_city = Sprite("world/parallax/cyber_parallax_buildings", 0, 0)
    local cyber_city_lights = Sprite("world/parallax/cyber_parallax_buildings_lights", 0, 0)
    local cyber_ground = Sprite("world/parallax/cyber_parallax_ground", 0, 0)
    local overlay = Sprite("world/darkoverlay", 0, 400)

    cyber_bg:setParallax(0, 0)
    cyber_bg.wrap_texture_x = true
    Game.world:addChild(cyber_bg)
    cyber_bg:setLayer(Game.world:parseLayer("objects_bg2"))

    cyber_city:setParallax(0, 0)
    cyber_city.wrap_texture_x = true
    Game.world:addChild(cyber_city)
    cyber_city:setLayer(Game.world:parseLayer("objects_bg"))

    cyber_city_lights:setParallax(0, 0)
    cyber_city_lights.wrap_texture_x = true
    Game.world:addChild(cyber_city_lights)
    cyber_city_lights:setLayer(Game.world:parseLayer("objects_bg"))

    cyber_ground:setParallax(0, 0)
    cyber_ground.wrap_texture_x = true
    Game.world:addChild(cyber_ground)
    cyber_ground:setLayer(Game.world:parseLayer("objects_bg"))
    
    overlay:setParallax(0, 0)
    overlay.wrap_texture_x = true
    Game.world:addChild(overlay)
    overlay:setLayer(Game.world:parseLayer("objects_bg")+0.1)

	self.core = Music("core", 0, 0.7)
end

function Room1:onExit()
    super.onExit(self)
	self.core:remove()
end

return Room1