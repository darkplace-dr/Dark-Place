local Forest, super = Class(Map)

function Forest:init(world, data)
	super:init(self, world, data)
	if Game:getFlag("Route") == "Insanity" then
		self.music = "iforest"
	end
end

function Forest:onEnter()
	super:onEnter(self)
	if Game:getFlag("puzzle4", false) == true then
		Game.world.map.battle_areas = {}
	end
end

function Forest:load()
    super:load(self)

    self.timer:every(0.5, function()
        if self.world:inBattle() then
            local marker1 = self.markers["leaf_up"]
            local marker2 = self.markers["leaf_down"]
            self.world:spawnBullet("leaf_hazard_2", Utils.random(marker1.x, marker1.x+marker1.width), marker1.center_y, false)
            self.world:spawnBullet("leaf_hazard_2", Utils.random(marker2.x, marker2.x+marker2.width), marker2.center_y, true)
            self.world:spawnBullet("leaf_hazard_2", Utils.random(marker1.x, marker1.x+marker1.width), marker1.center_y, false)
            self.world:spawnBullet("leaf_hazard_2", Utils.random(marker2.x, marker2.x+marker2.width), marker2.center_y, true)
        end
    end)
end

return Forest