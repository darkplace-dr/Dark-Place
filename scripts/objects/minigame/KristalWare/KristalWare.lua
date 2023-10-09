local KristalWare, super = Class("MinigameHandler")

function KristalWare:init()
    super.init(self)
	
    self.state = "TRANSITION", -- "TRANSITION", "TITLE", "PREMICROGAME", "MICROGAME", "GAMEOVER"
	Assets.playSound("kristal_intro")

    self.timer = Timer()
	
    self.music = Music()
	
	self.fade = Rectangle(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT)
	self.fade:setOrigin(0.5,0.5)
	self.fade.color = {0,0,0}
    self.fade.alpha = 0
	self:addChild(self.fade)
	
	self.state_timer = 0

    self.font = Assets.getFont("main")

    self.title = Assets.getTexture("kristal/title_logo_shadow")
    self.title_bg = Assets.getTexture("kristal/title_bg_full")
end

function KristalWare:postInit()
	super.postInit(self)
end

function KristalWare:setState(state)
	self.state = state
	self.state_timer = 0
	self:onStateChange(state)
end

function KristalWare:update()
    self.state_timer = self.state_timer + DT

    if self.state == "TRANSITION" then
        self.fade.alpha = self.state_timer/2
		if self.state_timer > 5 then
			self:setState("TITLE")
            self.fade:remove()
		end
    end
    super.update(self)
end

function KristalWare:onStateChange(state)
    if self.state == "TITLE" then
        Game.world.music:play("mod_menu")
    end
end

function KristalWare:draw()
    if self.state == "TITLE" then
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(self.title_bg, 0, -40, 0, 2)
        love.graphics.draw(self.title, SCREEN_WIDTH/2 - 161, 50 + math.sin(self.state_timer) * 10)
        love.graphics.setFont(self.font)
        love.graphics.printf("INSTRUCTIONS:\nBeat mircogames to increase your score\nlosing one removes one of your lives\nlosing all of your lives causes a game over.", 0, 175, SCREEN_WIDTH, "center")
        love.graphics.printf("Press [Z] to start\nPress [X] to exit\nPress [C] to see highscores", 0, SCREEN_HEIGHT - 125, SCREEN_WIDTH, "center")
    end
    super.draw(self)
end

return KristalWare