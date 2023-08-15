if not Kristal.getLibConfig("ribbit", "addCroaking") then
    return CLASS_NAME_GETTER("Player")
end

---@class Player
local Player, super = Class("Player", true)

function Player:updateWalk(key)
    super.updateWalk(self)

    if Game.lock_movement or TextInput.active then return end

    if Input.pressed("a") and (self.actor.id == "YOU" or self.actor.id == "YOU_lw") and Game.can_croak ~= false then
        self:croak()
    end
end

function Player:croak()
    Assets.stopAndPlaySound("croak", nil, 0.8 + Utils.random(0.4))

    local bubble = Sprite("croak", nil, nil, nil, nil, "party/you")
    bubble:setOriginExact(60, 23) -- center??
    bubble:setPosition(self.width/2 + 2.5, -20.5)
    bubble.physics.speed_y = -0.8
    bubble:fadeOutSpeedAndRemove(0.065)
    self:addChild(bubble)
end

return Player