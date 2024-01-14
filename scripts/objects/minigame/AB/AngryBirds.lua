local AngryBirds, super = Class("MinigameHandler")

function AngryBirds:init()
    super.init(self)
	
    self.state = "TRANSITION" -- "TRANSITION", "SPLASHES", "MAINMENU", "LEVELSELECTION"
	Assets.playSound("minigames/ab/misc/star_collect")

    self.timer = Timer()
	
    self.music = Music()
	
    -- TODO: maybe make transition look more like the one from later AB Seasons versions?
	self.fade = Rectangle(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT)
	self.fade:setOrigin(0.5,0.5)
	self.fade.color = {1,1,1}
    self.fade.alpha = 0
	self:addChild(self.fade)
	
	self.state_timer = 0
	
    self.current_menu_page = 1
	
    self.menu_sunset_angle = 0
end

function AngryBirds:postInit()
	super.postInit(self)
end

function AngryBirds:setState(state)
	self.state = state
	self.state_timer = 0
	self:onStateChange(state)
end

function AngryBirds:onStateChange(state)
    if state == "LEVELSELECTION" then
        self.music:play("minigames/ab/levelselect")
    end
end

function AngryBirds:update()
    self.state_timer = self.state_timer + DT

    if self.state == "TRANSITION" then
        self.fade.alpha = self.state_timer
		if self.state_timer > 2.5 then
			self:setState("SPLASHES")
            self.fade:remove()
		end
	elseif self.state == "SPLASHES" then
		if self.state_timer < 2.5 then
			self.ls_alpha = self.state_timer
        else
            self.ls_alpha = 1
        end
    end
    super.update(self)
end

function AngryBirds:updateSplashes()
    -- should hopefully function like how it does in the original game.
    if self.splash_timer == nil then
        self.splash_timer = 0
        self.current = 1
        self.splashes = {
            {
                sprite = "minigames/ab/splash_disclaimer",
                splash_time = 2
            },
            {
                sprite = "minigames/ab/splash_logo",
                splash_time = 4
            }
        }
    end

    self.splash_timer = self.splash_timer + DT

    if Input.pressed("confirm") or love.mouse.isDown(1) then
        self.splash_timer = self.splashes[self.current].splash_time + 1
    end
	
    Draw.draw(Assets.getTexture(self.splashes[self.current].sprite), 0, 0)
    if self.current == 2 then
        Draw.draw(Assets.getTexture("minigames/ab/splash_loading"), 0, SCREEN_HEIGHT - 27)
    end

    -- changes splash screen if showed long enough
    if self.splash_timer > self.splashes[self.current].splash_time then
        self.splash_timer = 0
        self.current = self.current + 1
        if self.current > #self.splashes then
            self:setState("LEVELSELECTION")
        end
    end
end

function AngryBirds:draw()
    super.draw(self)
	
    love.graphics.setColor(1, 1, 1, 1)
	
    if self.state == "SPLASHES" then
        self:updateSplashes()
    end

    if self.state == "LEVELSELECTION" then
        love.graphics.setColor(143/255, 116/255, 185/255)
        love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

        love.graphics.setColor(1, 1, 1)
        Draw.draw(Assets.getTexture("minigames/ab/levelselect/bg"), 0, 0)
        Draw.draw(Assets.getTexture("minigames/ab/levelselect/left"), 0, 293)
        Draw.draw(Assets.getTexture("minigames/ab/levelselect/right"), 427, 286)
    end
end

return AngryBirds