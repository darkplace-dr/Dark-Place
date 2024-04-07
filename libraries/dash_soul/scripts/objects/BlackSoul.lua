local BlackSoul, super = Class(Soul)
-- code by restruct
function BlackSoul:init(x, y)
    super:init(self, x, y)

    self.sprite:setSprite("soul/black")
    self._dash_divider = 1
    self._dash_outof = 1
    self.color = {1,0,0}
    self.dash_duration = self._dash_outof/self._dash_divider  -- Adjust dash duration as needed
    self.dash_timer = 0
    self.dash_speed = self.speed * 2
end

function BlackSoul:onStart()
    local arena = Game.battle.arena
end

function BlackSoul:update()
    if self.dash_timer > 0 then
        self.dash_timer = self.dash_timer - DT
    end
    super:update(self)
end

function BlackSoul:doMovement()

    local speed = self.speed
    local dash_speed = self.dash_speed
    local isleft = Input.down("left")
    local isright = Input.down("right")
    local isup = Input.down("up")
    local isdown = Input.down("down")
    local isdash = Input.down("confirm")
    -- Do speed calculations here if required.
    local move_x, move_y = 0, 0
    if self.allow_focus then
        if Input.down("cancel") then speed = speed / 2; dash_speed = dash_speed / 2 end -- Focus mode.
    end
    self.color = {1,0,0}
    if self.dash_timer > 0 then self.color = {1-(self.dash_timer*self._dash_divider), self.dash_timer*self._dash_divider, self.dash_timer*self._dash_divider} end -- make the soul color approach red as the ability to dash comes closer in time

    if isdash and self.dash_timer <= 0 then
        if isleft then move_x = -dash_speed end
        if isright then move_x = dash_speed end
        if isup  then move_y = -dash_speed end
        if isdown  then move_y = dash_speed end
        self.dash_timer = self.dash_duration
    else
        if isleft then move_x = move_x - 1 end
        if isright then move_x = move_x + 1 end
        if isup  then move_y = move_y - 1 end
        if isdown  then move_y = move_y + 1 end
    end
    self.moving_x = move_x
    self.moving_y = move_y

    if move_x ~= 0 or move_y ~= 0 then
        if not self:move(move_x, move_y, speed * DTMULT) then
            self.moving_x = 0
            self.moving_y = 0
        end
    end
end
function BlackSoul:draw()
    super:draw(self)

end
return BlackSoul
