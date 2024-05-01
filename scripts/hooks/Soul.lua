---@class Soul
local Soul, super = Class(Soul)

function Soul:init(x, y, color)
	super.init(self, x, y, color)

	self.outline = Sprite("player/heart_invert") -- Creating this first so sprite_focus will be on top of it
    self.outline:setOrigin(0.5, 0.5)
    self.outline.alpha = 0
    self.outline.color = {0, 1, 1}
    self.outline.debug_select = false
    self:addChild(self.outline)

	self.sprite_focus = Sprite("player/heart_dodge_focus")
    self.sprite_focus:setOrigin(0.5, 0.5)
    self.sprite_focus.inherit_color = false
	self.sprite_focus.alpha = 0
    self.sprite_focus.debug_select = false
    self:addChild(self.sprite_focus)


	self.force_taunt = nil -- Forces taunting in battle on or off, regardless of if the PizzaToque is equipped.
	self.force_timeslow = nil -- Forces the Focus ability on or off, regardless of if the placebo is equipped.


	-- Taunt variables start here
	self.parry_timer = 0
    self.cooldown_timer = 0
    self.parry_inv = 0
    self.taunt_timer = 0

    -- hi -sam
    self.parry_lock_movement = 0

    if Game.save_name:upper() == "PEPPINO" then
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

    self.timeslow_sfx = Assets.getSound("concentrating")
    self.timeslow_sfx:setLooping(true)

    self.afterimage_delay = 5
    self.drain_rate = 3        -- Number of frames to wait before losing TP
    self.drain_timer = 0


    self.focus_holder = nil
    for _,party in ipairs(Game.battle.party) do
        if self.force_timeslow then self.focus_holder = Game.battle.party[1]     
        elseif Game.party[_]:checkArmor("focus") then self.focus_holder = party
        end
    end
    self.outlinefx = BattleOutlineFX()
    self.outlinefx:setAlpha(0)

    if self.focus_holder then
        if self.focus_holder:getFX("outlinefx") then
            self.focus_holder:removeFX("outlinefx")
        end
    end
    if Game.stage:getFX("timeslowvhs") then
        Game.stage:removeFX("timeslowvhs")
    end

    -- Apply outlinefx to whoever has Focus equipped, or the leader if force_timeslow is true
    if self.focus_holder then self.focus_holder:addFX(self.outlinefx, "outlinefx") end
    self.vhsfx = Game.stage:addFX(VHSFilter(), "timeslowvhs")
    self.vhsfx.timescale = 2 -- I dunno if this even works.
    self.vhsfx.active = false
    self.concentratebg = ConcentrateBG({1, 1, 1})
    self.concentratebg.alpha_fx = self.concentratebg:addFX(AlphaFX())
    self.concentratebg.alpha_fx.alpha = 0
    Game.battle:addChild(self.concentratebg)


    --Game.battle.music.basepitch = Game.battle.music.pitch

	-- Timeslow ("Focus" Placebo) variables end here

    self.phaseoutline = false
end

function Soul:update()
	super.update(self)

---@diagnostic disable-next-line: undefined-field
	if Input.down("cancel") and not self.blue then -- Reduced hitbox size can get you stuck in collision with the blue soul, so it can't use this.
		self.collider.radius = 4
		self.sprite_focus.alpha = 1
	else
		self.collider.radius = 8
		self.sprite_focus.alpha = 0
	end

    local focus_equipped = false
	for _,party in ipairs(Game.party) do
        if party:checkArmor("focus") then focus_equipped = true end
    end
	-- Taunt code starts here
	if self.force_taunt ~= false then
	if Mod:isTauntingAvaliable() or self.force_taunt == true then
	if self.transitioning then
        if self.parried_loop_sfx then
            self.parried_loop_sfx:stop()
            self.parried_loop_sfx = nil
        end
        return
    end
    
    self.can_move = true
    if self.parry_lock_movement > 0 then
        self.parry_lock_movement = self.parry_lock_movement - DTMULT
        self.can_move = false
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

    self.parried_loop_sfx:setPitch( Utils.clampMap(self.parry_inv, 0, self.parry_length / 2, 0.1, 1))
    self.parried_loop_sfx:setVolume(Utils.clampMap(self.parry_inv, 0, self.parry_length / 4, 0,   0.5))
    --]]

    if Input.pressed("v", false) and self:canParry() then
        self.parry_lock_movement = 8

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
            effect:play(1/30, false, function()
                effect:remove()
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
        self.outlinefx.active = true
    end
    -- Cut timescale in half when holding A and not out of TP
    if not self.transitioning and Input.down("f") and Game:getTension() > 0 then
        -- Make sure the game pauses when object selection and selection slowdown is active.
        if not (Kristal.DebugSystem.state == "SELECTION" and Kristal.Config["objectSelectionSlowdown"]) then
        Game.stage.timescale = Utils.approach(Game.stage.timescale, 0.5, DTMULT / 4)
        end
        Game.battle.music.pitch = Utils.approach(Game.battle.music.pitch, Game.battle.music.basepitch/2, DTMULT / 4)
        self.timescale = Utils.approach(self.timescale, 2, DTMULT / 4)
        self.vhsfx.active = true
        if self.timeslow_sfx then self.timeslow_sfx:play() end
	else
        -- Make sure the game pauses when object selection and selection slowdown is active.
        if not (Kristal.DebugSystem.state == "SELECTION" and Kristal.Config["objectSelectionSlowdown"]) then
        Game.stage.timescale = Utils.approach(Game.stage.timescale, 1, DTMULT / 4)
        end
        Game.battle.music.pitch = Utils.approach(Game.battle.music.pitch, Game.battle.music.basepitch, DTMULT / 4)
        self.timescale = Utils.approach(self.timescale, 1, DTMULT / 4)
        self.vhsfx.active = false
        if self.timeslow_sfx then self.timeslow_sfx:stop() end
    end

    -- Remove 1 TP for every drain_rate frames of slowdown active
    if not self.transitioning and Input.down("f") and Game:getTension() > 0 then
        if self.drain_timer >= self.drain_rate then
            Game:removeTension(DTMULT*1.3) -- Should keep the drain rate roughly the same, regardless of framerate? Hopefully? Kinda looks like it does but I can't be sure?
            self.drain_timer = 0
        else
            self.drain_timer = self.drain_timer + 1
        end
    end

    -- Error sound if trying to use slowdown when out of TP
    if Input.pressed("f") and Game:getTension() <= 0 then
        Assets.playSound("ui_cant_select", 2)
    end

    -- Soul VFX
    if not self.transitioning and Input.down("f") and Game:getTension() > 0 then
    self.outline.alpha = Utils.approach(self.outline.alpha, 1, DTMULT / 4)
    self.concentratebg.alpha_fx.alpha = 1
    if self.afterimage_delay >= 5 then
        local afterimage = AfterImage(self.outline, 0.5)
        afterimage.debug_select = false
        self:addChild(afterimage)
        self.afterimage_delay = 0
    else
        self.afterimage_delay = self.afterimage_delay + DTMULT
    end
    else
    self.outline.alpha = Utils.approach(self.outline.alpha, 0, DTMULT / 4)
    self.concentratebg.alpha_fx.alpha = Utils.approach(self.concentratebg.alpha_fx.alpha, 0, DTMULT / 4)
    end
    if self.focus_holder then self.outlinefx:setAlpha(self.outline.alpha - 0.2) end
	end
	end
end

function Soul:remove()
    -- Taunt
    if self.parried_loop_sfx then
        self.parried_loop_sfx:stop()
        self.parried_loop_sfx = nil
    end

    -- Timeslow
    Game.stage.timescale = 1
    Game.battle.music.pitch = Game.battle.music.basepitch
    self.vhsfx.active = false
    self.outlinefx.active = false
    self.concentratebg:remove()
    if self.timeslow_sfx then self.timeslow_sfx:stop() end
    Input.clear("f")
    super.remove(self)
end

-- Why is this not a default function?
function Soul:flash(sprite)
    local sprite_to_use = sprite or self.sprite
    local flash = FlashFade(sprite_to_use.texture, -10, -10)
    flash.flash_speed = 1.5
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
        ---@diagnostic disable-next-line: param-type-mismatch
        self.color = Utils.clampMap(self.parry_inv, 0, self.parry_cap / 2, {r,g,b},{1,1,1})
    end

    -- Soul darkens when on cooldown
    if self.cooldown_timer > 0 then
        ---@diagnostic disable-next-line: param-type-mismatch
        self.color = Utils.clampMap(self.cooldown_timer, 0, self.cooldown / 2, {r,g,b},{(r * 0.5),(g * 0.5),(b * 0.5)})
    end
    if Game.battle.phasearmor >= 1 then
        if self.phaseoutline ~= true then
            self:addFX(OutlineFX({1,1,1,1}, {thickness = 2}), "phaseoutline")
            self.phaseoutline = true
        end
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

        local burst = HeartBurst(-9, -9, {Game.battle.encounter:getSoulColor()})
        self:addChild(burst)

        self.physics.direction = (Utils.angle(self.x, self.y, bullet:getRelativePos(bullet.collider.width / 2, bullet.collider.height/2))) - math.pi
        self.physics.speed = 3.3
        self.physics.friction = 0.4

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
        if Game.battle.phasearmor >= 1 then
            local burst = HeartBurst(-9, -9, {Game.battle.encounter:getSoulColor()})
            self:addChild(burst)
            Assets.stopAndPlaySound("celestialhit") -- Doesn't work for some reason???
            -- Also I have no idea how to make the bullet not do any damage
            Game.battle.phasearmor = Game.battle.phasearmor - 1
            if Game.battle.phasearmor <= 0 then
                self:removeFX("phaseoutline")
                self.phaseoutline = false
            end
        elseif bullet.damage ~= 0 then
            bullet.parrydmg_old = bullet.damage
        end
        
    end
    if self.parry_inv > 0 then
        bullet.damage = 0
    else
        if bullet.parrydmg_old then
            bullet.damage = bullet.parrydmg_old
        else
            bullet.damage = bullet:getDamage()
        end
    end

    super.onCollide(self, bullet)
end

function Soul:transitionTo(x, y, should_destroy) -- Fixes the focus visual effects staying around after a wave. for some reason, doing this when self.transitioning doesn't work.
	Game.stage.timescale = 1
	Game.battle.music.pitch = Game.battle.music.basepitch
    self.vhsfx.active = false
	self.outlinefx.active = false
    if should_destroy == true then
        self.concentratebg:remove()
        self.timeslow_sfx:stop()
    end
	Input.clear("f")
	super.transitionTo(self, x, y, should_destroy)
end

return Soul