---@class Follower
local Follower, super = Class("Follower")

function Follower:init(...)
    super.init(self, ...)

    self.state_manager.state_events["update"] = self.state_manager.state_events["update"] or {}
    self.state_manager:addEvent("update", { ["WALK"] = self.updateWalk, ["SLIDE"] = self.updateSlide })
    self.state_manager:addState("RUN", { update = self.updateRun })

    self.has_run = false
    self.running = false
    local has_run, _ = self.sprite:isDirectional(self.sprite:getPath("run"))
    self.has_run = has_run

    self.state_manager:addState("HOP", {enter = self.beginHop, update = self.updateHop, leave = self.endHop})
end

function Follower:setActor(...)
    super.setActor(self, ...)

    local has_run, _ = self.sprite:isDirectional(self.sprite:getPath("run"))
    self.has_run = has_run
end

function Follower:updateWalk()
    if self.running then
        self.running = false
        self:resetSprite()
    end
end

function Follower:updateSlide()
    if self.running then
        self.running = false
    end
end

function Follower:updateRun()
    if not self.running then
        self.running = true
    end

    if self.has_run and self.sprite.sprite ~= "run" then
        self:setWalkSprite("run")
    end
end

function Follower:beginHop(last_state, tx, ty, hop_time, hop_height)
    Assets.playSound("smalljump")
    self.hop_timer = 0

    self.hop_speed = hop_time or 0.5
    self.hop_height = hop_height or 20
end

function Follower:updateHop()
    self.hop_timer = self.hop_timer + DT

    local half_hop = self.hop_speed / 2
    if self.hop_timer < half_hop then
        self.sprite.y = Utils.ease(0, -self.hop_height, self.hop_timer / half_hop, "out-cubic")
    elseif self.hop_timer < self.hop_speed then
        self.sprite.y = Utils.ease(-self.hop_height, 0, (self.hop_timer - half_hop) / half_hop, "in-cubic")
    end
end

function Follower:endHop()
    self.sprite.y = 0
end

return Follower