local Gangnam = {}

function Gangnam:init()
	self.is_gangnaming = false

	self.music_paused = false
	self.last_music_play_status = true
	self.music_unpausing = false

	self.gangnam_sound = love.audio.newSource(Assets.getMusicPath("gangnam"), "stream")

	Utils.hook(Player, "isMovementEnabled",
        ---@overload fun(orig:function, self:Player):boolean
        function(orig, g_self)
            return orig(g_self)
                and not self.is_gangnaming
        end
    )
end

function Gangnam:update()
	if Input.pressed("gangnam", false)
		and not self.is_gangnaming
		and (Game.state == "OVERWORLD" and Game.world.state == "GAMEPLAY" and not Game.world:hasCutscene())
		and not (Game.lock_movement or self.taunt_lock_movement)
		and not (OVERLAY_OPEN or TextInput.active)
		and Game.world:getCharacter("kris_lw")
	then
		local kris = Game.world:getCharacter("kris_lw")
		self.is_gangnaming = true
		kris:setAnimation("gangnam")
		self:pauseWorldMusic()
		self.gangnam_sound:play()
	end

	if self.music_paused then
		if Game.world.music:isPlaying() then
			self.last_music_play_status = true
			self:pauseWorldMusicReal()
		end
	elseif self.music_unpausing and Game:getActiveMusic() == Game.world.music then
		self:resumeWorldMusicReal()
	end

	if self.is_gangnaming then
		if not Input.down("a") or (Game.state ~= "OVERWORLD" or Game.world:hasCutscene()) then
			local kris = Game.world:getCharacter("kris_lw")
			self.is_gangnaming = false
			kris:resetSprite()
			self.gangnam_sound:stop()
			self:resumeWorldMusic()
		end
	end
end

function Gangnam:pauseWorldMusic()
	self.music_paused = true
	if Game:getActiveMusic() ~= Game.world.music then return end
	self.last_music_play_status = Game.world.music:isPlaying()
	self:pauseWorldMusicReal()
end
function Gangnam:pauseWorldMusicReal()
	Game.world.music:pause()
end

function Gangnam:resumeWorldMusic()
	self.music_paused = false
	if Game:getActiveMusic() ~= Game.world.music then
		self.music_unpausing = self.last_music_play_status
		return
	end
	if not self.last_music_play_status then return end
	self:resumeWorldMusicReal()
end
function Gangnam:resumeWorldMusicReal()
	Game.world.music:resume()
end

return Gangnam