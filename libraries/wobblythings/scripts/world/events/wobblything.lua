local WobblyThing, super = Class(Event, "wobblything")

function WobblyThing:init(data)
    super:init(self, data.x, data.y, data.width, data.height)

    self:setHitbox(20, 48, 28, 24)

    self:setOrigin(0.5, 1)

    self.solid = true
    self.wobbled = false

    -- Whether the wobbler should be accurate to Deltarune or not.
    -- In Deltarune, it wobbles when the player's left side is in the scan area.
    -- By default, we'll use the center instead.
    self.accurate = data.properties["accurate"]

    -- Deltarune doesn't have this but it's really cool
    -- Off by default though
    self.interactable = data.properties["interactable"]

    -- Whether you can interact with the wobbler when it's already wobbling
    self.repeatable = data.properties["repeatable"]

    -- Whether it shoots bullets or not
    self.evil = data.properties["evil"]

    -- The area the wobbler should scan.
    self.scan_start = data.properties["scanstart"] or 10
    self.scan_end   = data.properties["scanend"  ] or 70

    -- Settings for the bullets that get shot
    self.shoot_speed = data.properties["shootspeed"] or 10
    self.shoot_amount = data.properties["shootamount"] or 3


    self:setSprite(Assets.getFrames(self.evil and "world/events/wobblything_evil" or "world/events/wobblything"))
    self.sprite:stop()
end

function WobblyThing:onInteract()
    if not self.interactable then return end
    if (not self.repeatable) and self.wobbled then return end
    self:wobble()
    return true
end

function WobblyThing:getDebugInfo()
    local info = super:getDebugInfo(self)
    table.insert(info, "Wobbling: " .. (self.wobbled and "True" or "False"))
    table.insert(info, "Accurate scan range: " .. (self.accurate and "True" or "False"))
    table.insert(info, "Scan Start: " .. self.scan_start)
    table.insert(info, "Scan End: " .. self.scan_end)
    table.insert(info, "Evil: " .. (self.evil and "True" or "False"))
    return info
end

function WobblyThing:wobble()
    if self.evil then
        self.world:setBattle(true)
        Assets.playSound("wobbler", 1, 0.5 + Utils.random(0.2))
        Assets.playSound("wobbler", 1, 0.9 + Utils.random(0.2))

        local rel_x, rel_y = self:getRelativePos(self.width/2, self.height, self.world)
        for i = 1, self.shoot_amount do
            local bullet = self.world:spawnBullet("wobblebullet", rel_x, rel_y, math.rad(0 - (250 + ((i - 1) * 20))))
            bullet.physics.speed = self.shoot_speed
        end
    else
        Assets.playSound("wobbler", 1, 0.8 + Utils.random(0.3))
    end
    self.sprite:play(5 / 30)
    self.wobbled = true
end

function WobblyThing:update()
    if not self.wobbled and Game.world and Game.world.player then
        local player = Game.world.player

        local player_x, player_y = player:getRelativePos(player.width/2, player.height/2, Game.world)
        local left, _ = self:getRelativePos(self.scan_start, 0, Game.world)
        local right, _ = self:getRelativePos(self.scan_end, 0, Game.world)

        if self.accurate then
            player_x, player_y = player:getRelativePos(0, player.height/2, Game.world)
        end

        if (player_x > left) and (player_x < right) then
            self:wobble()
        end
    end

    super:update(self)
end

function WobblyThing:draw()
    if DEBUG_RENDER then
        local self_x, self_y = self:getRelativePos(self.width/2, self.height/2, Game.world)
        love.graphics.setColor(COLORS.red)
        love.graphics.setLineWidth(2)
        love.graphics.line(self.scan_start, -self.y, self.scan_start, 480)
        love.graphics.line(self.scan_end,   -self.y, self.scan_end,   480)
    end
    super:draw(self)
end

return WobblyThing