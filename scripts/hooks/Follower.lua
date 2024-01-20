local Follower, super = Class(Follower)

function Follower:init(...)
    super.init(self, ...)

    self.state_manager:addState("HOP", {enter = self.beginHop, update = self.updateHop, leave = self.endHop})
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