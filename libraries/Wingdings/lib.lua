local lib = {}

function lib:init()
    self.voice_timer = 0
end

function lib:preUpdate(dt)
    self.voice_timer = Utils.approach(self.voice_timer, 0, DTMULT)
end

function lib:onTextSound(sound, node)
    if sound == "wingding_1" then
        if self.voice_timer == 0 then
            local snd = Assets.playSound(Utils.pick{"voice/wingding_1", "voice/wingding_2", "voice/wingding_3", "voice/wingding_4", "voice/wingding_5", "voice/wingding_6", "voice/wingding_7"})
            self.voice_timer = 2
		end
		return true
	end
end

return lib