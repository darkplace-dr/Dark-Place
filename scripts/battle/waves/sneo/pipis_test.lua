local Basic, super = Class(Wave)

function Basic:init()
	super:init(self)
    self.time = -1
	
    self:setArenaPosition(240, 160)
end

function Basic:onStart()
	Game.battle:swapSoul(YellowSoul())
    -- Every 0.33 seconds...
    self.timer:every(1.2, function()
        -- Our X position is offscreen, to the right
        local x = SCREEN_WIDTH - 60
        -- Get a random Y position between the top and the bottom of the arena
        local y = Utils.random(Game.battle.arena.top, Game.battle.arena.bottom)

        -- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
        local bullet = self:spawnBullet("sneo/pipis", x, y, math.rad(180), -6)

        -- Dont remove the bullet offscreen, because we spawn it offscreen
        bullet.remove_offscreen = true
    end)
end

function Basic:update()
    -- Code here gets called every frame

    super:update(self)
end

return Basic