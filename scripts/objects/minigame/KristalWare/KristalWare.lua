---@class KristalWare : MinigameHandler
local KristalWare, super = Class("MinigameHandler")

function KristalWare:init()
    super.init(self)

    self.name = "KristalWare"

    self.state = "TRANSITION" -- "TRANSITION", "TITLE", "PREMICROGAME", "MICROGAME", "GAMEOVER", "EXIT"
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

    self.leaderboard = {{"MATT", 100}, {"SPAMTON", 97}, {"WARIO", 27}}
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
    if self.state == "EXIT" then
        self.fade.alpha = self.state_timer/2
		if self.state_timer > 5 then
			self:endMinigame()
            return
		end
    end
    super.update(self)
end

function KristalWare:onStateChange(state)
    if self.state == "TITLE" then
        self.music:play("mod_menu")
    end
    if self.state == "EXIT" then
        self.music:stop()
        Assets.playSound("kristal_intro_end")
        self.fade.alpha = 0
	    self:addChild(self.fade)
    end
end

function KristalWare:onKeyPressed(key)
	super.onKeyPressed(self, key)
    if self.state == "TITLE" then
        if key == "x" then
            Assets.stopAndPlaySound("ui_select")
            self:setState("EXIT")
        end
        if key == "c" then
            Assets.stopAndPlaySound("ui_select")
            -- TODO: Figure out how to open files in Kristal
            --love.filesystem.open("saves/"..Mod.info.id.."/kristalware_leaderboard.txt")
        end
    end
end

function KristalWare:updateLeaderboards()
    
end

function KristalWare:draw()
    if self.state == "TITLE" or self.state == "EXIT" then
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(self.title_bg, 0, -40, 0, 2)
        if self.state == "TITLE" then
            love.graphics.draw(self.title, SCREEN_WIDTH/2 - 161, 50 + math.sin(self.state_timer) * 10)
            love.graphics.setFont(self.font)
            love.graphics.printf("INSTRUCTIONS:\nBeat mircogames to increase your score\nlosing one removes one of your lives\nlosing all of your lives causes a game over.", 0, 175, SCREEN_WIDTH, "center")
            love.graphics.printf("Press [Z] to start\nPress [X] to exit\nPress [C] to see highscores", 0, SCREEN_HEIGHT - 125, SCREEN_WIDTH, "center")
        end
    end
    super.draw(self)
end

return KristalWare
