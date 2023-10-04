local BallJump, super = Class("MinigameHandler")

function BallJump:init()
    super.init(self)
	
	self.state = "TRANSITION" -- TRANSITION, INTRO, MAIN, DEAD
	Assets.playSound("minigames/ball_jump/transition")
	
	self.timer = Timer()
	
	self.music = Music()
	
	self.bg = Rectangle(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, 0, 0)
	self.bg:setOrigin(0.5,0.5)
	self.bg.color = {0,0,0}
	self:addChild(self.bg)
	
	self.state_timer = 0
	
	self.ground = Sprite("minigames/ball_jump/ground", 0, 320)
    self.ground.wrap_texture_x = true
    self.ground:setScale(2)
    self.ground.layer = self.bg.layer + 1
	self.ground.alpha = 0
    self:addChild(self.ground)
	
	self.intro_second_started = false
	
	self.score = 0
end

function BallJump:postInit()
	super.postInit(self)
end

function BallJump:update()
	self.state_timer = self.state_timer + DT
	if self.state == "TRANSITION" then
		self.bg.width = SCREEN_WIDTH * self.state_timer
		self.bg.height = SCREEN_HEIGHT * self.state_timer
		if self.state_timer > 1 then
			self:setState("INTRO")
		end
	elseif self.state == "INTRO" then
		if self.state_timer < 1 then
			self.ground.alpha = self.state_timer
		else
			self.ground.alpha = 1
			if not self.intro_second_started then
				
			end
		end
		self.ground.x = self.ground.x - 3*DTMULT
	elseif self.state == "MAIN" then
	
	elseif self.state == "DEAD" then
	
	end
    super.update(self)
end

function BallJump:draw()
    super.draw(self)
end

function BallJump:onKeyPressed(key)
	
end

function BallJump:setState(state)
	self.state = state
	self.state_timer = 0
	self:onStateChange(state)
end

function BallJump:onStateChange(state)
	if state == "INTRO" then
		self.music:play("minigames/ball_jump/ball_jump")
	end
end

return BallJump