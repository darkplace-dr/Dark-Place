local LightAttackBar, super = Class(Object)

function LightAttackBar:init(x, y, battler, scale_y)
    super.init(self, x, y)

    self.battler = battler
    
    self.scale_y = scale_y or 1

    self.hit = false

    self.sprite = Sprite("ui/lightbattle/targetchoice")
    self.active_sprite = "ui/lightbattle/targetchoice_1"
    self.inactive_sprite = "ui/lightbattle/targetchoice_2"
    self.fade_sprite = "ui/lightbattle/targetchoice_fade"

    self.sprite:setOrigin(0.5, 0.5)
    self.sprite.color = {self.battler.chara:getLightAttackBarColor()}
    self:addChild(self.sprite)

    self.perfect = false
    self.perfect_counter = 2
    self.bursting = false
    self.flashing = false

    self.fading = false
    self.fade_speed = nil

    self.flash_speed = 1/15
    self.burst_speed = 0.1
end

function LightAttackBar:flash(flash_speed)
    self.sprite:play(self.flash_speed, true)
    self.hit = true
    self.flashing = true
end

function LightAttackBar:burst()
    self.sprite:setSprite(self.fade_sprite)
    self.bursting = true
    self.hit = true
end

function LightAttackBar:fade(speed, direction)
    self.fading = true
    if direction == "left" then
        self.fade_speed = -speed
    else
        self.fade_speed = speed
    end
end

function LightAttackBar:update()
    if self.fading then
        self:move(self.fade_speed * DTMULT, 0)

        self.sprite.alpha = self.sprite.alpha - 0.6 * DTMULT
        if self.sprite.alpha < 0.1 then
            self.sprite.alpha = 0
            self:remove()
        end
    end

    if self.perfect then
        local count = self.perfect_counter
        self.perfect_counter = self.perfect_counter + 1
        if self.perfect_counter > 3 then
            self.perfect_counter = 1
        end

        if self.perfect_counter == 1 then
            self.sprite:setColor(192/255, 0, 0)
        elseif self.perfect_counter == 2 then
            self.sprite:setColor(128/255, 1, 1)
        else
            self.sprite:setColor(1, 1, 64/255)
        end
    end

    if self.bursting then

        self.sprite.alpha = self.sprite.alpha - self.burst_speed * DTMULT
        if self.sprite.alpha < (0 + self.burst_speed) then
            self:remove()
        end
        self.scale_x = self.scale_x + self.burst_speed * DTMULT
        self.scale_y = self.scale_y + self.burst_speed * DTMULT

    end

    super.update(self)
end

return LightAttackBar