local Forest, super = Class(Map)

function Forest:init(world, data)
	super:init(self, world, data)
	if Game:getFlag("Route") == "Insanity" then
		self.music = "iforest"
	end
end

function Forest:load()
    super:load(self)

    self.timer:every(0.5, function()
        if self.world:inBattle() then
            local marker1 = self.markers["leaf_left"]
            local marker2 = self.markers["leaf_right"]
            self.world:spawnBullet("leaf_hazard", marker1.center_x, Utils.random(marker1.y, marker1.y+marker1.height), false)
            self.world:spawnBullet("leaf_hazard", marker2.center_x, Utils.random(marker2.y, marker2.y+marker2.height), true)
            self.world:spawnBullet("leaf_hazard", marker1.center_x, Utils.random(marker1.y, marker1.y+marker1.height), false)
            self.world:spawnBullet("leaf_hazard", marker2.center_x, Utils.random(marker2.y, marker2.y+marker2.height), true)
        end
    end)
end

return Forest