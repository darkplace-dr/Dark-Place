---@class RandomEncounter : Object
---@overload fun(...) : RandomEncounter
local RandomEncounter = Class()

function RandomEncounter:init()
    -- The bubble that should appear when a random encounter is triggered.
    -- If this is nil, the battle starts instantly
    self.bubble = "effects/alert"
    
    -- "But Nobody Came" encounter used if you meet the nobodyCame() returns true
    self.nobody_encounter = "_nobody"
    
    -- Table with the encounters that can be triggered by this random encounter
    self.encounters = {}
    
    self.light = true
end

function RandomEncounter:resetSteps()
    MagicalGlassLib.steps_until_encounter = 30
end

function RandomEncounter:getNextEncounter()
    if not self:nobodyCame() then
        return Utils.pick(self.encounters)
    else
        return self.nobody_encounter
    end
end

function RandomEncounter:nobodyCame()
    return false
end

function RandomEncounter:start()
    if self.bubble then
        Game.lock_movement = true
        MagicalGlassLib.initiating_random_encounter = true
        Game.world.player:alert(15/30 + Utils.random(5/30), {layer = WORLD_LAYERS["above_events"], sprite = self.bubble, callback = function() Game:encounter(self:getNextEncounter(), true, nil, nil, self.light);Game.lock_movement = false;MagicalGlassLib.initiating_random_encounter = nil end})
    else
        Game:encounter(self:getNextEncounter(), true, nil, nil, self.light)
    end
end

return RandomEncounter