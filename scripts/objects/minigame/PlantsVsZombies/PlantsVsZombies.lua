---@class PlantsVsZombies : MinigameHandler
local PlantsVsZombies, super = Class("MinigameHandler")

function PlantsVsZombies:init()
    super.init(self)

    self.name = "Plants VS Zombies"

    self.state = "TRANSITION" -- "TRANSITION", "TITLE", "PREMICROGAME", "MICROGAME", "GAMEOVER", "EXIT"

    self.timer = Timer()
	
    self.music = Music()
	
	self.fade = Rectangle(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT)
	self.fade:setOrigin(0.5,0.5)
	self.fade.color = {0,0,0}
    self.fade.alpha = 0
	self:addChild(self.fade)
	
	self.state_timer = 0

    self.font = Assets.getFont("main")

    self.logo = Assets.getTexture("minigames/pvz/logo")
    self.title_bg = Assets.getTexture("minigames/pvz/title_bg") --CURRENT SPRITE IS JUST A PLACEHOLDER, YES I KNOW IT DOESN'T LOOK GOOD
end

function PlantsVsZombies:postInit()
	super.postInit(self)
end

function PlantsVsZombies:setState(state)
	self.state = state
	self.state_timer = 0
	self:onStateChange(state)
end

function PlantsVsZombies:update()
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

function PlantsVsZombies:onStateChange(state)
    if self.state == "TITLE" then
        self.music:play("minigames/pvz/menu")
    end
    if self.state == "EXIT" then
        self.music:stop()
        self.fade.alpha = 0
	    self:addChild(self.fade)
    end
end

function PlantsVsZombies:onKeyPressed(key)
	super.onKeyPressed(self, key)
    if self.state == "TITLE" then
        if key == "x" then
            Assets.stopAndPlaySound("ui_select")
            self:setState("EXIT")
        end
        if key == "t" then
            Assets.stopAndPlaySound("ui_select")
            self:setState("TESTING") --For testing plants & crud
        end
    end
end

function PlantsVsZombies:draw()
    super.draw(self)

    if self.state == "TITLE" then
        love.graphics.draw(self.title_bg, 0, 0, 0, 3)
        love.graphics.draw(self.logo, SCREEN_WIDTH/2 - 185/2, 30)
    end
end

return PlantsVsZombies
