local GonerBackground, super = Class(Object)

function GonerBackground:init(x, y, song, song_pitch_increases, music_obj)
    super.init(self,
        x or SCREEN_WIDTH/2, y or SCREEN_HEIGHT/2,
        -- specifically, LW dimensions
        SCREEN_WIDTH/2, SCREEN_HEIGHT/2
    )
    self:setScale(2)
    self:setOrigin(0, 0)
    self:setParallax(0, 0)

    song = song or "AUDIO_ANOTHERHIM"
    if song_pitch_increases == nil then
        song_pitch_increases = true
    end

    self.music_pitch_inc = 0.02
    local music_pitch = self.music_pitch_inc
    self.music_target_pitch = song == "AUDIO_ANOTHERHIM" and 0.8 or 1
    if not song_pitch_increases then
        music_pitch = 1
        self.music_target_pitch = 1
    end
    self.music = music_obj or Music()
    self.music:play(song, 1, music_pitch)

    self.piece_depth = 0

    self.timer = Timer()
    self.timer:every(40/30, function()
        self.piece_depth = self.piece_depth - 0.001
        local piece = self:addChild(GonerBackgroundPiece())
        piece.layer = self.piece_depth
    end)
    self:addChild(self.timer)
end

function GonerBackground:update()
    self.music:setPitch(
        Utils.approach(self.music:getPitch(), self.music_target_pitch,
        self.music_pitch_inc * DTMULT)
    )

    super.update(self)
end

function GonerBackground:onRemove(...)
    super.onRemove(self, ...)

    self.music:stop()
end

return GonerBackground