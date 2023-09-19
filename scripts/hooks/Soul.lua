---@class Soul
local Soul, super = Class(Soul)

function Soul:init(x, y, color)
	super.init(self, x, y, color)

	self.outline = Sprite("player/heart_slow") -- Creating this first so sprite_focus will be on top of it
    self.outline:setOrigin(0.5, 0.5)
    self.outline.alpha = 0
    self:addChild(self.outline)

	self.sprite_focus = Sprite("player/heart_dodge_focus")
    self.sprite_focus:setOrigin(0.5, 0.5)
    self.sprite_focus.inherit_color = false
	self.sprite_focus.alpha = 0
    self:addChild(self.sprite_focus)

	self.force_taunt = nil -- Forces taunting in battle on or off, regardless of if the PizzaToque is equipped.
	self.force_timeslow = nil -- Forces the focus ability on or off, regardless of if the placebo is equipped.


	-- Taunt variables start here
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
	-- Taunt variables end here

	-- Timeslow ("Focus" Placebo) variables start here; outline is created above.
	--self.outline = Sprite("player/heart_slow")
    --self.outline:setOrigin(0.5, 0.5)
    --self.outline.alpha = 0
    --self:addChild(self.outline)

    self.afterimage_delay = 5
    self.drain_rate = 3        -- Number of frames to wait before losing TP
    self.drain_timer = 0


    self.leader = Game.battle.party[1]
    outlinefx = BattleOutlineFX()
    outlinefx:setAlpha(0)

    if self.leader:getFX("outlinefx") then
        self.leader:removeFX("outlinefx")
    end
    if Game.stage:getFX("vhs") then
        Game.stage:removeFX("vhs")
    end

    self.leader:addFX(outlinefx, "outlinefx")
    vhsfx = Game.stage:addFX(VHSFilter(), "vhs")
    vhsfx.timescale = 2 -- I dunno if this even works.
	vhsfx.active = false
    self.basespeed = self.speed
	-- Timeslow ("Focus" Placebo) variables end here

end

function Soul:update()
	super.update(self)

	if Input.down("cancel") then
		self.collider.radius = 4
		self.sprite_focus.alpha = 1
	else
		self.collider.radius = 8
		self.sprite_focus.alpha = 0
	end

	local player = Game.party[1]
	local player_name = Game.save_name:upper()
    local toque_equipped = false
    local focus_equipped = false
	for _,party in ipairs(Game.party) do
        if party:checkArmor("pizza_toque") then toque_equipped = true end
        if party:checkArmor("focus") then focus_equipped = true end
    end
	-- Taunt code starts here
	if self.force_taunt ~= false then
	if toque_equipped or player_name == "PEPPINO" or self.force_taunt == true then
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
        Game.lock_movement = true

        self:flash()
        self.parry_sfx:stop()
        self.parry_sfx:play()

        for _,chara in pairs(Game.battle.stage:getObjects(PartyBattler)) do
            if not chara.actor or chara.is_down then goto continue end

            -- workaround due of actors being loaded first by registry
            local sprites = chara.actor.getTauntSprites and chara.actor:getTauntSprites() or chara.actor.taunt_sprites
            if not sprites or #sprites <= 0 then goto continue end

            chara:toggleOverlay(true)
            chara.overlay_sprite:setSprite(Utils.pick(sprites))

            -- the shine effect
            local effect = Sprite("effects/taunt", 10, 15)
            effect:setOrigin(0.5)
            effect:setScale(0.5)
            effect.layer = -1
            effect:play(0.02, false, function()
                effect:remove()
                Game.lock_movement = false
                chara:toggleOverlay(false)
            end)
            chara:addChild(effect)

            ::continue::
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
	end
	-- Taunt code ends here

	-- Focus code starts here
	if self.force_timeslow ~= false then
	if focus_equipped or self.force_timeslow == true then
	if not self.transitioning then
        outlinefx.active = true
    end
    -- Cut timescale in half when holding A and not out of TP
    if not self.transitioning and Input.down("a") and Game:getTension() > 0 then
        Game.stage.timescale = Utils.approach(Game.stage.timescale, 0.5, DTMULT / 4)
        Game.battle.music.pitch = Utils.approach(Game.battle.music.pitch, 0.5, DTMULT / 4)
        self.speed = Utils.approach(self.speed, self.basespeed * 2, DTMULT / 4)
        vhsfx.active = true
	else
        Game.stage.timescale = Utils.approach(Game.stage.timescale, 1, DTMULT / 4)
        Game.battle.music.pitch = Utils.approach(Game.battle.music.pitch, 1, DTMULT / 4)
        self.speed = Utils.approach(self.speed, self.basespeed, DTMULT / 4)
        vhsfx.active = false
    end

    -- Remove 1 TP for every drain_rate frames of slowdown active
    if not self.transitioning and Input.down("a") and Game:getTension() > 0 then
        if self.drain_timer == self.drain_rate then
            Game:removeTension(1)
            self.drain_timer = 0
        else
            self.drain_timer = self.drain_timer + 1
        end
    end

    -- Error sound if trying to use slowdown when out of TP
    if Input.pressed("a") and Game:getTension() <= 0 then
        Assets.playSound("ui_cant_select", 2)
    end

    -- Soul VFX
    if not self.transitioning and Input.down("a") and Game:getTension() > 0 then
    self.outline.alpha = Utils.approach(self.outline.alpha, 1, DTMULT / 4)
    if self.afterimage_delay == 5 then
        local afterimage = AfterImage(self.outline, 0.5)
        self:addChild(afterimage)
        self.afterimage_delay = 0
    else
        self.afterimage_delay = self.afterimage_delay + 1
    end
    else
    self.outline.alpha = Utils.approach(self.outline.alpha, 0, DTMULT / 4)
    end
    outlinefx:setAlpha(self.outline.alpha - 0.2)
	end
	end


end

-- Why is this not a default function?
function Soul:flash(sprite)
    local sprite_to_use = sprite or self.sprite
    local flash = FlashFade(sprite_to_use.texture, -10, -10)
    flash.layer = 100
    self:addChild(flash)
    return flash
end

function Soul:canParry()
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

function Soul:draw()
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

    super.draw(self)
    self.color = {r,g,b}

end

function Soul:isParrying()
    if self.can_parry and (self.parry_timer > 0) then
        return true
    else
        return false
    end
end

function Soul:onCollide(bullet)
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
        super.onCollide(self, bullet)
end

function Soul:transitionTo(x, y, should_destroy) -- Fixes the focus visual effects staying around after a wave. for some reason, doing this when self.transitioning doesn't work.
	Game.stage.timescale = 1
	Game.battle.music.pitch = 1
	vhsfx.active = false
	outlinefx.active = false
	Input.clear("a")
	super.transitionTo(self, x, y, should_destroy)
end

return Soul