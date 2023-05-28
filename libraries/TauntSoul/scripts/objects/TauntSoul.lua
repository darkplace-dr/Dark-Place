local TauntSoul, super = Class(Soul)

function TauntSoul:init(x, y)
    super:init(self, x, y)
    
    -- Default color is cyan {0,1,1}, but feel free to make it whatever you want.
    --self.color = {0,1,1}
    -- Here's orange, if you want it.
    -- self.color = {1,(148/255),0}

    --[[ None of these are relevant in Dark Place
    -- In Deltatraveler, this soul moves at half speed (2). Remove this line or set speed to 4 if you don't want that.
    self.speed = 2
    -- Disables focus. Why would you want to move even slower?
    self.allow_focus = false
    --]]


    self.parry_timer = 0
    self.cooldown_timer = 0
    self.parry_inv = 0
    self.taunt_timer = 0

    local player_name = (player_name_override or Game.save_name):upper()
    if player_name == "PEPPINO" then
        self.parry_sfx = Assets.getSound("sugarcoat")
    else
        self.parry_sfx = Assets.getSound("taunt")
    end
    self.parried_sfx = Assets.getSound("sfx_parry")
    self.parried_loop_sfx = nil

    -- Making sure it only parries once per Z press.
    self.did_parry = false

    self.taunt_length = 10

    -- Customizable stuff. Timing is in frames at 30 FPS.
    self.can_parry = true       -- Determines if you can parry at all.
    self.parry_window = 5       -- How large of a window you have to parry a bullet.
    self.parry_length = 30      -- Invincibility length after a successful parry.
    self.parry_cap = 60         -- Maximum duration for parry invincibility, in the event that multiple bullets are parried in quick succession.
    self.cooldown = 30          -- Recovery time between one parry and the next, assuming the first one failed.
    self.special_only = false   -- If set to true, only bullets with the variable "self.special_parry" set to true can be parried.


end

function TauntSoul:update()
    super:update(self)
    if self.transitioning then
        if self.parried_loop_sfx then
            self.parried_loop_sfx:stop()
            self.parried_loop_sfx = nil
        end
        return
    end


    if self.parry_inv == 0 and self.did_parry then
        self.did_parry = false
    end
    --
    if not self.parried_loop_sfx then
    self.parried_loop_sfx = Assets.getSound("chargeshot_charge")
    self.parried_loop_sfx:setLooping(true)
    self.parried_loop_sfx:setPitch(0.1)
    self.parried_loop_sfx:setVolume(0)
    self.parried_loop_sfx:play()
    end

    self.parried_loop_sfx:setPitch(Utils.clampMap(self.parry_inv, 0, self.parry_length / 2, 0.1,1))
    self.parried_loop_sfx:setVolume(Utils.clampMap(self.parry_inv, 0, self.parry_length / 2, 0, 1))
    --]]

    if Input.pressed("v", false) and self:canParry() then
        self:flash()
        self.parry_sfx:stop()
        self.parry_sfx:play()
        for chara_id,sprites in pairs(Mod.chars) do
            local chara = Game.battle:getPartyBattler(chara_id)
            if chara then
                local effect = Sprite("effects/taunteffect", 10, 15)

                -- unlock player movement after taunt is finished
                local function onUnlock()
                    effect:remove()
                    Game.lock_movement = false
                    chara:toggleOverlay(false)
                end

                -- the shine effect
                effect:play(0.02, false, onUnlock)
                effect:setOrigin(0.5)
                effect:setScale(0.5)
                effect.layer = -1
                chara:addChild(effect)

                if effect then
                    Game.lock_movement = true
                    chara.overlay_sprite:setSprite(Utils.pick(sprites))
                    chara:toggleOverlay(true)
                end
            end
        end
        self.parry_timer = self.parry_window
        self.cooldown_timer = self.cooldown
        self.did_parry = false
        self.once = false
    end

    if self.parry_timer > 0 then self.parry_timer = Utils.approach(self.parry_timer, 0, DTMULT) end
    if self.cooldown_timer > 0 then self.cooldown_timer = Utils.approach(self.cooldown_timer, 0, DTMULT) end
    if self.parry_inv > 0 then self.parry_inv = Utils.approach(self.parry_inv, 0, DTMULT) end



end

-- Why is this not a default function?
function TauntSoul:flash(sprite)
    local sprite_to_use = sprite or self.sprite
    local flash = FlashFade(sprite_to_use.texture, -10, -10)
    flash.layer = 100
    self:addChild(flash)
    return flash
end

function TauntSoul:canParry()
    -- Conditions for parrying:
    -- Not already parrying
    -- Cooldown is over
    -- Parrying is enabled
    -- Not in the middle of damage i-frames
    if self.parry_timer == 0 and self.cooldown_timer == 0 and self.can_parry == true and self.inv_timer == 0 then
        return true
    else
        return false
    end
end

function TauntSoul:draw()
    local r,g,b,a = self:getDrawColor()
    local heart_texture = Assets.getTexture(self.sprite.texture_path)
    local heart_w, heart_h = heart_texture:getDimensions()

    local charge_timer = self.parry_inv
    if charge_timer > 0 then
        local scale = math.abs(math.sin(charge_timer / 10)) + 1
        love.graphics.setColor(r,g,b,a*0.3)
        love.graphics.draw(heart_texture, -heart_w/2 * scale, -heart_h/2 * scale, 0, scale)

        scale = math.abs(math.sin(charge_timer / 14)) + 1.2
        love.graphics.setColor(r,g,b,a*0.3)
        love.graphics.draw(heart_texture, -heart_w/2 * scale, -heart_h/2 * scale, 0, scale)
    end

    -- Soul brightens when invincible
    if charge_timer > 0 then
        self.color = Utils.clampMap(self.parry_inv, 0, self.parry_cap / 2, {r,g,b},{1,1,1})
    end

    -- Soul darkens when on cooldown
    if self.cooldown_timer > 0 then
        self.color = Utils.clampMap(self.cooldown_timer, 0, self.cooldown / 2, {r,g,b},{(r * 0.5),(g * 0.5),(b * 0.5)})
    end

    super:draw(self)
    self.color = {r,g,b}

end

function TauntSoul:isParrying()
    if self.can_parry and (self.parry_timer > 0) then
        return true
    else
        return false
    end
end

function TauntSoul:onCollide(bullet)
    if self:isParrying() and not self.did_parry and ((self.special_only and bullet.special_parry) or (not self.special_only)) then
        self.parried_sfx:stop()
        self.parried_sfx:play()
        self.parry_inv = self.parry_inv + self.parry_length
        if self.parry_inv > self.parry_cap then
            self.parry_inv = self.parry_cap
        end
        self.did_parry = true
        self.cooldown_timer = 0             -- You can chain parries as long as you keep timing them.

    end
    if bullet.damage then
        if bullet.damage ~= 0 then bullet.parrydmg_old = bullet.damage end
    end
    if self.parry_inv > 0 then
        bullet.damage = 0
    else
        if bullet.parrydmg_old then
            bullet.damage = bullet.parrydmg_old
        else
            bullet.damage = nil
        end
    end
        super:onCollide(self, bullet)
end


return TauntSoul