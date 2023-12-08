local Speen = {}

function Speen:init()
	self.is_spinning = false

	self.timer = 0
	self.current_facing = "down"
	self.rotate_speed = 1/240
	if Kristal.Config["simplifyVFX"] then
		self.rotate_speed = 1/30
	end

	self.music_paused = false
	self.last_music_play_status = true
	self.music_unpausing = false

	self.spin_sound = Assets.newSound("spin_jump")
	self.speen_sound = Assets.newSound("speen")

	self.rotat_e_sound = love.audio.newSource(Assets.getMusicPath("voiceover/rotat_e"), "stream")

	self.lancer_sound = Assets.newSound("lancer-spin")
	self.lancer_sound:setLooping(true)
	self.lancer_sprites = {}

	self.beyblade_sound = love.audio.newSource(Assets.getMusicPath("full_beyblade_theme_song"), "stream")

	Utils.hook(Player, "isMovementEnabled",
        ---@return boolean
        ---@diagnostic disable-next-line: redefined-local
        function(orig, g_self)
            ---@diagnostic disable-next-line: redundant-return-value
            return orig(g_self)
                and not self.is_spinning
        end
    )
end

function Speen:update()
	if Kristal.Config["simplifyVFX"] then
		self.rotate_speed = 1/30
	else
		self.rotate_speed = 1/240
	end

	if Input.pressed("s", false)
		and not self.is_spinning
		and (Game.state == "OVERWORLD" and Game.world.state == "GAMEPLAY" and not Game.world:hasCutscene())
		and not (Game.lock_movement or self.taunt_lock_movement)
		and not (OVERLAY_OPEN or TextInput.active)
	then
		self.is_spinning = true
		self.current_facing = "down"
		self.timer = 0
		self.lancered = love.math.random(0, 100) <= 25
		self.beyblade = love.math.random(0, 100) <= 10
		self.rotat_e = love.math.random(0, 100) <= 5
		if self.lancered then
			self:pauseWorldMusic()
			self.lancer_sound:play()
			for i=1,4 do
				local l = Sprite("world/the_boy")
				l:play(1/80)
				l:setScale(2)
				l:setLayer(WORLD_LAYERS["top"])
				Game.world:addChild(l)
				if i == 1 then
					l:setScreenPos(0, 0)
				elseif i == 2 then
					l:setScreenPos(SCREEN_WIDTH-l.width*2, 0)
				elseif i == 3 then
					l:setScreenPos(0, SCREEN_HEIGHT-l.height*2)
				elseif i == 4 then
					l:setScreenPos(SCREEN_WIDTH-l.width*2, SCREEN_HEIGHT-l.height*2)
				end
				table.insert(self.lancer_sprites, l)
			end
		elseif self.rotat_e then
			self:pauseWorldMusic()
			self.rotat_e_sound:play()
		elseif self.beyblade then
			self:pauseWorldMusic()
			self.beyblade_sound:play()
		elseif love.math.random(1, 50) == 1 then
			self.speen_sound:play()
		else
			self.spin_sound:play()
		end
	end

	if self.music_paused then
		if Game.world.music:isPlaying() then
			self.last_music_play_status = true
			self:pauseWorldMusicReal()
		end
	elseif self.music_unpausing and Game:getActiveMusic() == Game.world.music then
		self:resumeWorldMusicReal()
	end

	if self.is_spinning then
		self.timer = self.timer + DT
		if self.timer >= self.rotate_speed then
			self.timer = 0
			for _,member in ipairs(Game.party) do
				local chara = Game.world:getCharacter(member.id)
				-- compensate for duplicate actors in the party room
				if Game.world:getCharacter(member.id, 2) then
					chara = Game.world:getCharacter(member.id, 2)
				end
				if chara then
					chara.sprite:setFacing(self.current_facing)
				end
			end
			self:nextFacing()
		end

		if not Input.down("s") or (Game.state ~= "OVERWORLD" or Game.world:hasCutscene()) then
			self.is_spinning = false
			if self.lancered then
				self.lancered = false
				for _,lancer in ipairs(self.lancer_sprites) do
					lancer:remove()
				end
				self.lancer_sprites = {}
				self.lancer_sound:stop()
				self:resumeWorldMusic()
			end
			if self.beyblade then
				self.beyblade = false
				self.beyblade_sound:stop()
				self:resumeWorldMusic()
			end
			if self.rotat_e then
				self.rotat_e = false
				self.rotat_e_sound:stop()
				self:resumeWorldMusic()
			end
		end
	end
end

function Speen:nextFacing()
	local order = {"down", "up", "left", "right"}
	local i = Utils.getIndex(order, self.current_facing)
	self.current_facing = order[Utils.clampWrap(i + 1, 1, #order)]
end

function Speen:pauseWorldMusic()
	self.music_paused = true
	if Game:getActiveMusic() ~= Game.world.music then return end
	self.last_music_play_status = Game.world.music:isPlaying()
	self:pauseWorldMusicReal()
end
function Speen:pauseWorldMusicReal()
	Game.world.music:pause()
end

function Speen:resumeWorldMusic()
	self.music_paused = false
	if Game:getActiveMusic() ~= Game.world.music then
		self.music_unpausing = self.last_music_play_status
		return
	end
	if not self.last_music_play_status then return end
	self:resumeWorldMusicReal()
end
function Speen:resumeWorldMusicReal()
	Game.world.music:resume()
end

return Speen