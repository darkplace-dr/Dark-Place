---@class BallJump : MinigameHandler
---@field levelScript? fun(self:BallJump, wait:fun(time:number))
local BallJump, super = Class("MinigameHandler")

function BallJump:init()
    super.init(self)

	self.name = "Ball Jump"

	self.state = "TRANSITION" -- TRANSITION, INTRO, MAIN, DEAD, WIN, TRANSITIONOUT1, TRANSITIONOUT2
	Assets.playSound("minigames/ball_jump/transition")
	
	self.timer = Timer()
	self:addChild(self.timer)
	
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
	
	self.lives = 3
	
	self.hud_alpha = 0
	
	self.font = Assets.getFont("main", 32)
	self.font2 = Assets.getFont("main", 64)
	
	self.life_icon = Assets.getTexture("minigames/ball_jump/life")
	self.coin_icon = Assets.getTexture("minigames/ball_jump/ui_coin_missing")
	self.coin_icon_full = Assets.getTexture("minigames/ball_jump/ui_coin_got")
	
	self.req_score = 0
	
	self.procedurally = false

	self.level_script_handle = nil

	self.entities = {}
	self.entity_count = 0
	
	self.total_score = 0
	
	self.flag = nil
	self.hs_flag = nil
	
	self.coins = 3
	self.coins_gotten = {false, false, false}
	self.all_coins = false
end

function BallJump:postInit()
	self:pauseWorldMusic()
end

function BallJump:update()
	if self.score < 0 then
		self.score = 0
	end
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
			self.hud_alpha = self.state_timer
		else
			self.ground.alpha = 1
			self.hud_alpha = 1
			if not self.intro_second_started then
				self.intro_second_started = true
				
				self.player = BallJumpPlayer()
				self:addChild(self.player)
			end
			self.player.x = self.player.x + 6 * DTMULT
			if self.player.x >= 80 then
				self.player.x = 80
				self:setState("MAIN")
			end
		end
		self.ground.x = self.ground.x - 6*DTMULT
	elseif self.state == "MAIN" then
		self.ground.x = self.ground.x - 6*DTMULT
		if self.player.iframes <= 0 then
			self.player.sprite.alpha = 1
		end
	elseif self.state == "DEAD" then
	
	elseif self.state == "WIN" then
	
	elseif self.state == "TRANSITIONOUT1" or self.state == "TRANSITIONOUT3" then
		self.hud_alpha = self.hud_alpha - DT
		self.ground.alpha = self.ground.alpha - DT
		self.player.sprite.alpha = self.player.sprite.alpha - DT
		for k,v in pairs(self.entities) do
			v.sprite.alpha = v.sprite.alpha - DT
		end
		if self.state_timer > 1 then
			for k,v in pairs(self.entities) do
				v:remove()
			end
			self.player:remove()
			self.ground:remove()
			self:setState("TRANSITIONOUT2")
		end
	elseif self.state == "TRANSITIONOUT2" then
		self.bg.width = SCREEN_WIDTH * (1 - self.state_timer)
		self.bg.height = SCREEN_HEIGHT * (1 - self.state_timer)
		if self.state_timer > 1 then
			self:endMinigame()
			return
		end
	end
    super.update(self)
end

function BallJump:draw()
	local score = "00000000"
	if self.score < 10 then
		score = "Score: 0000000" .. self.score
	elseif self.score < 100 then
		score = "Score: 000000" .. self.score
	elseif self.score < 1000 then
		score = "Score: 00000" .. self.score
	elseif self.score < 10000 then
		score = "Score: 0000" .. self.score
	elseif self.score < 100000 then
		score = "Score: 000" .. self.score
	elseif self.score < 1000000 then
		score = "Score: 00" .. self.score
	elseif self.score < 10000000 then
		score = "Score: 0" .. self.score
	else
		score = "Score: " .. self.score
	end
	
    super.draw(self)
	
	love.graphics.setColor(1, 1, 1, self.hud_alpha)
	love.graphics.setFont(self.font)
	
	if self.state == "INTRO" or self.state == "MAIN" then
		if self.req_score > 0 then
			love.graphics.print(score .. " / " .. self.req_score, 6, 0)
		else
			love.graphics.print(score, 6, 0)
		end
		if Input.active_gamepad then
			love.graphics.print("Press        to jump", 6, 448)
			love.graphics.draw(Input.getTexture("confirm"), 87, 452, 0, 2, 2)
		else
			love.graphics.print("Press " .. Input.getText("confirm") .. " to jump", 6, 448)
		end
		love.graphics.scale(2,2)
		for i = 1, self.lives do
			love.graphics.draw(self.life_icon, -12 + 16 * i, 18)
		end
		for i = 1, self.coins do
			if self.coins_gotten[i] then
				love.graphics.draw(self.coin_icon_full, -12 + 16 * i, 34)
			else
				love.graphics.draw(self.coin_icon, -12 + 16 * i, 34)
			end
		end
		love.graphics.scale(1,1)
	end
	
	if self.state == "WIN" or self.state == "TRANSITIONOUT1" then
		love.graphics.setFont(self.font2)
		love.graphics.printf("YOU MADE IT!", 0, 70, SCREEN_WIDTH, "center")
		
		love.graphics.setFont(self.font)
		love.graphics.printf("Score: " .. self.score, 0, 170, SCREEN_WIDTH, "center")
		love.graphics.printf("Lives Bonus: " .. self.lives * 250, 0, 200, SCREEN_WIDTH, "center")
		love.graphics.printf("All Coins Bonus: " .. (self.all_coins and 1000 or 0), 0, 230, SCREEN_WIDTH, "center")
		love.graphics.printf("Total: " .. self.total_score, 0, 260, SCREEN_WIDTH, "center")
		if self.req_score > 0 then
			if self.total_score >= self.req_score then
				love.graphics.printf("Score requirement (" .. self.req_score .. ") met!", 0, 290, SCREEN_WIDTH, "center")
				if self.flag then
					Game:setFlag(self.flag, true)
				end
				if self.hs_flag and self.total_score > Game:getFlag(self.hs_flag, 0) then
					Game:setFlag(self.hs_flag, self.total_score)
				end
			else
				love.graphics.printf("Score requirement (" .. self.req_score .. ") not met.", 0, 290, SCREEN_WIDTH, "center")
			end
		end
		if Input.active_gamepad then
			love.graphics.printf("Press        to continue.", 0, 350, SCREEN_WIDTH, "center")
			love.graphics.draw(Input.getTexture("confirm"), (SCREEN_WIDTH/2) - 53, 354, 0, 2, 2)
		else
			love.graphics.printf("Press " .. Input.getText("confirm") .. " to continue.", 0, 350, SCREEN_WIDTH, "center")
		end
	end
	
	if self.state == "DEAD" or self.state == "TRANSITIONOUT3" then
		love.graphics.setFont(self.font2)
		love.graphics.printf("Oof.", 0, 100, SCREEN_WIDTH, "center")
		
		love.graphics.setFont(self.font)
		if Input.active_gamepad then
			love.graphics.printf("Press        to continue.", 0, 350, SCREEN_WIDTH, "center")
			love.graphics.draw(Input.getTexture("confirm"), (SCREEN_WIDTH/2) - 53, 354, 0, 2, 2)
		else
			love.graphics.printf("Press " .. Input.getText("confirm") .. " to continue.", 0, 350, SCREEN_WIDTH, "center")
		end
	end
	
	love.graphics.setColor(1, 1, 1, 1)
end

function BallJump:onKeyPressed(key)
	super.onKeyPressed(self, key)
	if self.state == "MAIN" then
		if Input.pressed("confirm") then
			self.player:handleJump()
		end
	end
	if self.state == "WIN" then
		if Input.pressed("confirm") then
			self:setState("TRANSITIONOUT1")
		end
	end
	if self.state == "DEAD" then
		if Input.pressed("confirm") then
			self:setState("TRANSITIONOUT3")
		end
	end
end

function BallJump:setState(state)
	local last_state = self.state
	self.state = state
	self.state_timer = 0
	self:onStateChange(last_state, state)
end

function BallJump:onStateChange(old, new)
	if old == "MAIN" then
		if self.level_script_handle then
			self.timer:cancel(self.level_script_handle)
		end
	end
	if new == "INTRO" then
		self:changeWindowTitle()
		self.music:play("minigames/ball_jump/ball_jump")
	elseif new == "MAIN" then
		if self.levelScript then
			self.level_script_handle = self.timer:script(function(...)
				self:levelScript(...)
			end)
		end
	elseif new == "WIN" then
		self.player.on_ground = true
		self.player.velocity = 0
		self.player.y = 284
		self.player.sprite:setSprite("minigames/ball_jump/player_pose")
		
		self.all_coins = true
		for k,v in pairs(self.coins_gotten) do
			if v == false then
				self.all_coins = false
				break
			end
		end
		
		self.total_score = self.score + (250 * self.lives) + (self.all_coins and 1000 or 0)
	elseif new == "DEAD" then
		self.player.on_ground = true
		self.player.velocity = 0
		self.player.sprite:setSprite("minigames/ball_jump/player_hurt")
	elseif new == "TRANSITIONOUT1" or new == "TRANSITIONOUT3" then
		self.music:fade(0,1)
	elseif new == "TRANSITIONOUT2" then
		self:preEndCleanup()
	end
end

function BallJump:addEntity(entity)
	local item = entity
	self:addChild(item)
	table.insert(self.entities, item)
end

function BallJump:addCountedEntity(entity)
	self:addEntity(entity)
	self.entity_count = self.entity_count + 1
end

function BallJump:endMinigame()
	for _,v in pairs(self.entities) do
		v:remove()
	end
	self.player:remove()
	self.ground:remove()
	super.endMinigame(self)
end

return BallJump
