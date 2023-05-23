local World, super = Class("World", true)

function World:loadMap(...)
    local args = {...}
    -- x, y, facing
    local map = table.remove(args, 1)
    local marker, x, y, facing
    if type(args[1]) == "string" then
        marker = table.remove(args, 1)
    elseif type(args[1]) == "number" then
        x = table.remove(args, 1)
        y = table.remove(args, 1)
    else
        marker = "spawn"
    end
    if args[1] then
        facing = table.remove(args, 1)
    end

    -- Recreation of the famous Punch Card glitch
    if Mod.punch_speedrun then
    	Mod.punch_speedrun = false
    	Game.lock_movement = false
    	if Mod.glitch_timer then
    		self.timer:cancel(Mod.glitch_timer)
    	end
    	self:stopCutscene()
    	marker = "spawn"
    end

    if self.map then
        self.map:onExit()
    end

    self:setupMap(map, unpack(args))

    if self.map.markers["spawn"] then
        local spawn = self.map.markers["spawn"]
        self.camera:setPosition(spawn.center_x, spawn.center_y)
    end

    if marker then
        self:spawnParty(marker, nil, nil, facing)
    else
        self:spawnParty({x, y}, nil, nil, facing)
    end

    self:setState("GAMEPLAY")

    for _,event in ipairs(self.map.events) do
        if event.postLoad then
            event:postLoad()
        end
    end

    self.map:onEnter()
end

return World