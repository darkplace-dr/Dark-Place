local ParrySoul, super = Class(Soul)

function ParrySoul:init(x, y)
    super.init(self, x, y)
    
    -- Default color is cyan {0,1,1}, but feel free to make it whatever you want.
    self.color = {0,1,1}
    self.rotation = math.rad(180)

    self.parry_sfx = Assets.getSound("snd_parry")

    self.parry_timer = 0
    self.cooldown_timer = 0

    -- Making sure it only parries once per Z press.
    self.did_parry = false

    -- Customizable stuff. Timing is in frames at 30 FPS.
    self.can_parry = true       -- Determines if you can parry at all.
    self.parry_window = 7       -- How large of a window you have to parry a bullet.
    self.cooldown = 10          -- Recovery time between one parry and the next.

    self.targetrot = math.rad(180)
    self.leftright = 0

end

function ParrySoul:update()
    super.update(self)

    if Input.pressed("confirm", false) and self:canParry() then
        self.did_parry = false
        self.parry_timer = self.parry_window
        if self.leftright == 0 then
            --left
            self.targetrot = math.rad(180)
            self.leftright = 1
        else
            --right
            self.targetrot = math.rad(-180)
            self.leftright = 0
        end

        self.sprite.scale_x = 1.4
        self.sprite.scale_y = 1.4
        self.rotation = 0
        self.cooldown_timer = self.cooldown
    end

    if self.targetrot and self.rotation ~= self.targetrot then
        if self.targetrot == math.rad(180) then self.rotation = Utils.approach(self.rotation, math.rad(180), DTMULT/2) end
        if self.targetrot == math.rad(-180) then self.rotation = Utils.approach(self.rotation, math.rad(-180), DTMULT/2) end
    end

    if self.parry_timer > 0 then self.parry_timer = Utils.approach(self.parry_timer, 0, DTMULT) end
    if self.cooldown_timer > 0 then self.cooldown_timer = Utils.approach(self.cooldown_timer, 0, DTMULT) end

    if self.sprite.scale_x > 1 then self.sprite.scale_x = Utils.approach(self.sprite.scale_x, 1, DT*2) end
    if self.sprite.scale_y > 1 then self.sprite.scale_y = Utils.approach(self.sprite.scale_y, 1, DT*2) end

end

-- Why is this not a default function?
function ParrySoul:flash(sprite)
    local sprite_to_use = sprite or self.sprite
    local flash = FlashFade(sprite_to_use.texture, -10, -10)
    flash.layer = 100
    self:addChild(flash)
    return flash
end

function ParrySoul:canParry()
    -- Conditions for parrying:
    -- Not already parrying
    -- Cooldown is over
    -- Parrying is enabled
    -- Not mid-transition
    if self.parry_timer == 0 and self.cooldown_timer == 0 and self.can_parry == true and not self.transitioning then
        return true
    else
        return false
    end
end

function ParrySoul:isParrying()
    if self.can_parry and (self.parry_timer > 0) then
        return true
    else
        return false
    end
end

function ParrySoul:onCollide(bullet)
    if self:isParrying() and not self.did_parry and bullet.special_parry then 
        self.did_parry = true
        self.parry_sfx:stop()
        self.parry_sfx:play()
        self:flash()

        if self.inv_timer < 0.3 then self.inv_timer = 0.3 end
    end

    super.onCollide(self, bullet)
end

return ParrySoul