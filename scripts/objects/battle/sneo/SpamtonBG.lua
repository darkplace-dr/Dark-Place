local BG, super = Class(Object)

function BG:init()
    super:init(self)
	
    self.background = Assets.getTexture("battle/backgrounds/sneo/cityscape_background")
    self.midground  = Assets.getTexture("battle/backgrounds/sneo/cityscape_midground")
    self.foreground = Assets.getTexture("battle/backgrounds/sneo/cityscape_foreground")
    self.sneo_track = Assets.getTexture("battle/backgrounds/sneo/sneo_track")

	self.layer = BATTLE_LAYERS["bottom"]
	
    self.draw_track = true
    self.track_x = 0
    self.tracky0 = 0
    self.tracky1 = 0
    self.tracky2 = 0
    self.tracky3 = 0
    self.trackspeed = -15
    self.trackaccel = 0
    self.trackspeedmax = 0
	
    self.bg_alpha = 0
	self.bg_active = true
	self.bg_speed = 0
	self.bg_speed_max = 5
end

function BG:draw()
    super:draw(self)
	
    Draw.setColor(0, 0, 0, 1)
    Draw.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
	
    Draw.setColor(1, 1, 1, 1)
	
    if self.draw_track == true then
        self.track_x = self.track_x + self.trackspeed * DTMULT
		
        if (self.track_x + 640) < 0 then
            self.track_x = self.track_x + 640
        end
		
        if self.track_x > 0 then
            self.track_x = self.track_x - 640
        end
		
        if #Game.party == 4 then
            self.tracky0 = 70
            self.tracky1 = 123
            self.tracky2 = 177
            self.tracky3 = 230

            Draw.draw(self.sneo_track, (self.track_x - 640), self.tracky0, 0, 2, 2)
            Draw.draw(self.sneo_track, self.track_x, self.tracky0, 0, 2, 2)
            Draw.draw(self.sneo_track, (self.track_x + 640), self.tracky0, 0, 2, 2)
			
            Draw.draw(self.sneo_track, (self.track_x - 640), self.tracky1, 0, 2, 2)
            Draw.draw(self.sneo_track, self.track_x, self.tracky1, 0, 2, 2)
            Draw.draw(self.sneo_track, (self.track_x + 640), self.tracky1, 0, 2, 2)
			
            Draw.draw(self.sneo_track, (self.track_x - 640), self.tracky2, 0, 2, 2)
            Draw.draw(self.sneo_track, self.track_x, self.tracky2, 0, 2, 2)
            Draw.draw(self.sneo_track, (self.track_x + 640), self.tracky2, 0, 2, 2)
			
            Draw.draw(self.sneo_track, (self.track_x - 640), self.tracky3, 0, 2, 2)
            Draw.draw(self.sneo_track, self.track_x, self.tracky3, 0, 2, 2)
            Draw.draw(self.sneo_track, (self.track_x + 640), self.tracky3, 0, 2, 2)
        elseif #Game.party == 3 then
            self.tracky0 = 70
            self.tracky1 = 150
            self.tracky2 = 230
            self.tracky3 = 0

            Draw.draw(self.sneo_track, (self.track_x - 640), self.tracky0, 0, 2, 2)
            Draw.draw(self.sneo_track, self.track_x, self.tracky0, 0, 2, 2)
            Draw.draw(self.sneo_track, (self.track_x + 640), self.tracky0, 0, 2, 2)
			
            Draw.draw(self.sneo_track, (self.track_x - 640), self.tracky1, 0, 2, 2)
            Draw.draw(self.sneo_track, self.track_x, self.tracky1, 0, 2, 2)
            Draw.draw(self.sneo_track, (self.track_x + 640), self.tracky1, 0, 2, 2)
			
            Draw.draw(self.sneo_track, (self.track_x - 640), self.tracky2, 0, 2, 2)
            Draw.draw(self.sneo_track, self.track_x, self.tracky2, 0, 2, 2)
            Draw.draw(self.sneo_track, (self.track_x + 640), self.tracky2, 0, 2, 2)
	    elseif #Game.party == 2 then
            self.tracky0 = 100
            self.tracky1 = 200
            self.tracky2 = 0
            self.tracky3 = 0

            Draw.draw(self.sneo_track, (self.track_x - 640), self.tracky0, 0, 2, 2)
            Draw.draw(self.sneo_track, self.track_x, self.tracky0, 0, 2, 2)
            Draw.draw(self.sneo_track, (self.track_x + 640), self.tracky0, 0, 2, 2)
            Draw.draw(self.sneo_track, (self.track_x - 640), self.tracky1, 0, 2, 2)
            Draw.draw(self.sneo_track, self.track_x, self.tracky1, 0, 2, 2)
            Draw.draw(self.sneo_track, (self.track_x + 640), self.tracky1, 0, 2, 2)
	    elseif #Game.party == 1 then
            self.tracky0 = 150
            self.tracky1 = 0
            self.tracky2 = 0
            self.tracky3 = 0
			
            Draw.draw(self.sneo_track, (self.track_x - 640), self.tracky0, 0, 2, 2)
            Draw.draw(self.sneo_track, self.track_x, self.tracky0, 0, 2, 2)
            Draw.draw(self.sneo_track, (self.track_x + 640), self.tracky0, 0, 2, 2)
		end
    end
	
    if self.bg_active == true then
        if self.bg_alpha < 1 then
            self.bg_alpha = Utils.lerp(self.bg_alpha, 1, 0.2)
        end
		
        if self.cityscapefade == 1 then
            cityscape_alpha = false
        end
		
        self.bg_speed = self.bg_speed - self.bg_speed_max * DTMULT
		
        if self.bg_speed_max < 0 and self.bg_speed > -398 then
            self.bg_speed = self.bg_speed - 398
        end
	
        Draw.setColor(1, 1, 1, self.bg_alpha)
        Draw.drawWrapped(self.background, true, false, self.x + self.bg_speed, 0, 0, 2, 2)
        Draw.drawWrapped(self.midground, true, false, self.x + self.bg_speed * 1.1, 0, 0, 2, 2)
        Draw.drawWrapped(self.foreground, true, false, self.x + self.bg_speed * 1.2, 0, 0, 2, 2)
	end
	
    Draw.setColor(0, 0, 0, Game.battle.background_fade_alpha)
    Draw.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
end

return BG