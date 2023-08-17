local TrafficMarker, super = Class(Event)

function TrafficMarker:init(data)
    super.init(self, data)

    local pr = data.properties or {}

    -- The marker that the player is sent to when hit by a car
    self.marker     = pr.marker
    -- The x position the player is sent to when hit by a car
    self.target_x   = pr.target_x
    -- The y position the player is sent to when hit by a car
    self.target_y   = pr.target_y
end

function TrafficMarker:onEnter()
    Game.world.player.last_traffic_marker = self
end

function TrafficMarker:getRecallPosition()
    -- Use just above the bottom-middle of the marker as the base position to recall to if nothing else is specified.
    -- Using the actual bottom is an issue as kris would end up inside of a collision box if they moved to a marker that
    -- was against a collision box. Not that it wouldn't be funny to have Kris get stuck in a collision box every time
    -- because you could move them anyway but it'd be very cruel for them to survive being hit by a car only to meet their
    -- demise stuck inside of a wall for eternity
    local target_x, target_y = self.x + (self.width / 2), self.y + self.height - 10

    -- Marker takes first priority for positioning
    if self.marker then
        local marker = Game.world.map.markers[self.marker]
        
        target_x = marker.center_x
        target_y = marker.center_y
    else
        -- If there is no marker then use the target position variables, if provided
        if self.target_x then
            target_x = self.target_x
        end
        if self.target_y then
            target_y = self.target_y
        end
    end

    return target_x, target_y
end

return TrafficMarker