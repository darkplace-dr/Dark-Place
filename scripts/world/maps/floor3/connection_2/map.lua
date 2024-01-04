local Room1, super = Class(Map)

function Room1:load()
    super.load(self)

    --[[
    self.timer:every(0.25, function()
        if self.world:inBattle() then
            local marker = self.markers["shooter_down"]
            self.world:spawnBullet("diamondbullet", Utils.random(marker.x, marker.x+marker.width), marker.center_y)
        end
    end)
    ]]
end

function Room1:onEnter()
    super.onEnter(self)
    Game.world:spawnObject(FireBG(0, 0), "objects_bg")

	self.forest = Music("deltarune/forest", 0, 0.9)
	self.cliffs = Music("deltarune/creepylandscape", 0, 0.95)
	self.hotland = Music("anothermedium", 0, 0.8)

    self.sfp_flag = "CONNECTION.forestpuzzle"
    self.sfp_tiles = {Game.world.map:getEvent(555), Game.world.map:getEvent(554), Game.world.map:getEvent(553), Game.world.map:getEvent(552), Game.world.map:getEvent(549), Game.world.map:getEvent(550)}
    self.sfp_combination = {9, 6, 7, 8, 6, 7}
    if Game:getFlag(self.sfp_flag, false) == true then
        self.sfp_completed = true
        for index, value in ipairs(self.sfp_tiles) do
            value.tile = self.sfp_combination[index]
        end
    else
        self.sfp_completed = false
    end
end

function Room1:completeSFP()
    self.sfp_completed = true
    Game.world:shakeCamera()
    Game:setFlag(self.sfp_flag, true)
end

function Room1:onExit()
    super.onExit(self)
	self.forest:remove()
	self.cliffs:remove()
	self.hotland:remove()
end

return Room1