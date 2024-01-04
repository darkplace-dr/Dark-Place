local Room1, super = Class(Map)

function Room1:load()
    super.load(self)

    self.timer:every(0.25, function()
        if self.world:inBattle() then
            local marker = self.markers["shooter_down"]
            self.world:spawnBullet("diamondbullet", Utils.random(marker.x, marker.x+marker.width), marker.center_y)
        end
    end)
end

function Room1:onEnter()
    super.onEnter(self)

	self.ruins = Music("ruins", 0, 0.8)
	self.city = Music("deltarune/cybercity", 0, 0.8)
	self.fields = Music("deltarune/field_of_hopes", 0, 0.75)
	self.snowdin = Music("snowy", 0, 0.8)
end

function Room1:onExit()
    super.onExit(self)
	self.ruins:remove()
	self.city:remove()
	self.fields:remove()
	self.snowdin:remove()
end

return Room1