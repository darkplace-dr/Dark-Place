local Follower, super = Class(Follower)

function Follower:init(...)
    super:init(self, ...)

    self.state_manager:addState("WALK", { update = self.updateWalk })
    self.state_manager:addState("RUN", { update = self.updateRun })
    self.running = false
    self.has_run = false
    if love.filesystem.getInfo(Mod.info.path.."/libraries/run_anims/assets/sprites/"..self.actor.path.."/run") or love.filesystem.getInfo(Mod.info.path.."/assets/sprites/"..self.actor.path.."/run") then
        self.has_run = true
    end
end


function Follower:updateRun()
    if not self.running then
        self.running = true
    end

    if self.sprite.sprite ~= "run" and self.has_run then
        self:setWalkSprite("run")
    end
end

function Follower:updateWalk()
    if self.running then
        self.running = false
        self:resetSprite()
    end
end

return Follower