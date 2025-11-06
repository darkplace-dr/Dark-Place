local lib = {}

function lib:init()
    self.voice_timer = 0
end

function lib:preUpdate(dt)
    self.voice_timer = MathUtils.approach(self.voice_timer, 0, DTMULT)
end

function lib:onTextSound(sound, node)
    if sound == "queen" then
        if self.voice_timer == 0 then
            local snd = Assets.playSound("voice/queen")
            snd:setPitch(0.9 + MathUtils.random(0.15))
            self.voice_timer = 2
        end
        return true
    end
end

return lib