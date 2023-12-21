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
    Game.world:startCutscene(function(cutscene)
        if self.bubble then
            Assets.stopAndPlaySound("alert")
            local sprite = Sprite(self.bubble, Game.world.player.width/2)
            sprite:setScale(1,1)
            sprite:setOrigin(0.5, 1)
            Game.world.player:addChild(sprite)
            sprite.layer = WORLD_LAYERS["above_events"]
            cutscene:wait(15/30 + Utils.random(5/30))
            sprite:remove()
            Game:encounter(self:getNextEncounter(), true)
        else
            Game:encounter(self:getNextEncounter(), true)
        end
    end)
end

return RandomEncounter