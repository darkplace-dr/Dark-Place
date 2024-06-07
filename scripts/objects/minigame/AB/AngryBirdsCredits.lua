local AngryBirdsCredits, super = Class(Object)

function AngryBirdsCredits:init()
	super.init(self)
	
    self.credits_frame = Rectangle(0, 0, 640, 480)
	self.credits_frame.alpha = 0
	self:addChild(self.credits_frame)
	
    self.birds1 = Sprite("minigames/ab/ui/credits/birds_1")
	self.birds1.isSprite = true
    self.birds1:setOrigin(0.5, -1)
    self.credits_frame:addChild(self.birds1)
	
	local about_credits = ( -- I have all the text stuff formatted this way, so it can be read easily instead of it just being on one line lmao.
	[[
[font:font_basic_n900]Angry Birds Kristal\n
A Dark Place minigame by J.A.R.U.\n
v.0.9.0-dev\n

\n
@ 2009-2024 Rovio Entertainment Corporation.\n
Angry Birds and game characters are trademarks of\n
Rovio Entertainment Corporation and are\n
protected by international copyright laws\n
All rights reserved.\n
www.rovio.com
	]]
	)
    self.about_text = Text(about_credits, 0, 0, 640, 420, { align = "center" })
    self.about_text:setOrigin(0.5, 0)
	self.about_text.isText = true
    self.credits_frame:addChild(self.about_text)
	
    self.birds2 = Sprite("minigames/ab/ui/credits/birds_2")
	self.birds2.isSprite = true
    self.birds2:setOrigin(0.5, -1)
    self.credits_frame:addChild(self.birds2)
	
	local main_credits = (
	[[
[font:font_basic_n900]MINIGAME TEAM\n
\n
- PROGRAMMERS -\n
J.A.R.U.\n
\n
- ARTISTS -\n
TBA\n
	]]
	)
    self.credits_text = Text(main_credits, 0, 0, 640, 480, { align = "center" })
    self.credits_text:setOrigin(0.5, 0)
	self.credits_text.isText = true
    self.credits_frame:addChild(self.credits_text)
	
    self.backButton = AngryBirdsButton(58, SCREEN_HEIGHT - 45, 0.8, 0.8, 0.8, 0.95, "back", "ui_button_back")
	self:addChild(self.backButton)
	
    self.credits_items = {
		[1] = self.birds1,
		[2] = self.about_text,
		[3] = self.birds2,
		[4] = self.credits_text,
	}
	
    self.minigame = Game.minigame ---@type AngryBirds
    self.mainMenu = self.minigame.mainMenu

    self:layout()

	self.state = "RELEASED" -- RELEASED, DRAGGING
	self.scroll = 0
	self.extra_velocity = 0
end

function AngryBirdsCredits:layout()

	self.total_height = 0
	local y_separator = SCREEN_HEIGHT * 0.05

	for k, v in ipairs(self.credits_items) do
		
		if k > 1 then
			self.total_height = self.total_height + y_separator
		end
	
		v.x = SCREEN_WIDTH * 0.5
		v.y = self.total_height
		
		if v.isText then
			v.y = v.y + v.height * 0.5
			self.total_height = self.total_height + v.height
		elseif v.isSprite then
			v.y = v.y + v.height * 0.5
			self.total_height = self.total_height + v.height
		end
	end
end

function AngryBirdsCredits:update()
	super.update(self)
	
    local mx, my = love.mouse.getPosition()
	local screen_x, screen_y = self:getScreenPos()
	screen_x, screen_y = screen_x-self.width/2, screen_y-self.height/2
	
	if self.state == "RELEASED" then
		if math.abs(self.extra_velocity) > 0 then
			if self.extra_velocity < 0 then
				self.extra_velocity = self.extra_velocity + SCREEN_HEIGHT * DT * 4
				if self.extra_velocity >= 0 then
					self.extra_velocity = 0
				end
			else
				self.extra_velocity = self.extra_velocity - SCREEN_HEIGHT * DT * 4
				if self.extra_velocity <= 0 then
					self.extra_velocity = 0
				end
			end
		end
		self.scroll = self.scroll + DT * SCREEN_HEIGHT * 0.125 + self.extra_velocity * DT
	else
		local last_y = self.last_y or self.drag_start
		self.scroll = self.scroll + last_y - my
		self.last_y = my
	end
	
	if self.scroll >= self.total_height + SCREEN_HEIGHT then
		self.scroll = self.scroll - self.total_height - SCREEN_HEIGHT
	elseif self.scroll < 0 then
		self.scroll = self.scroll + self.total_height + SCREEN_HEIGHT
	end
	
	self.credits_frame.y = SCREEN_HEIGHT - self.scroll
	
	--mouse dragging stuff, kinda broken rn lmao.
	
    --[[if love.mouse.isDown(1) and self.state == "RELEASED" then
        self.state = "DRAGGING"
        self.drag_start = my
        self.drag_start_time = Kristal.getTime()
        self.last_y = my
    end
    if not love.mouse.isDown(1) and self.state == "DRAGGING" then
        self.state = "RELEASED"
        local diff = Kristal.getTime() - self.drag_start_time
        if diff ~= 0 then
            self.extra_velocity = (self.drag_start - my) / (Kristal.getTime() - self.drag_start_time)
        else
            self.extra_velocity = 0
        end
	end]]
	
	if self.backButton.pressed == true then
        self:remove()
		self.mainMenu.popup = false
		self.mainMenu:setState("MENU")
		self.mainMenu.settingsButton.pressed = false
	end
end

return AngryBirdsCredits