local AngryBirds, super = Class("MinigameHandler")

function AngryBirds:init()
    super.init(self)
	
    self.state = "TRANSITION" -- "TRANSITION", "LEVELSELECTION", "LEVEL", "PAUSE", "LEVELCLEAR", "LEVELFAIL"
	Assets.playSound("minigames/ab/misc/star_collect")

    self.timer = Timer()
	
    self.music = Music()
	
	self.fade = Rectangle(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT)
	self.fade:setOrigin(0.5,0.5)
	self.fade.color = {1,1,1}
    self.fade.alpha = 0
	self:addChild(self.fade)
	
	self.state_timer = 0
	
    self.ls_page = 1
    self.ls_alpha = 0
	
    self.ls_bg = Assets.getTexture("minigames/ab/levelselect/bg")
    self.ls_left = Assets.getTexture("minigames/ab/levelselect/left")
    self.ls_right = Assets.getTexture("minigames/ab/levelselect/right")
	
    --self.reward_popup = self:spawnObject(ABRewardPopUp())
end

function AngryBirds:postInit()
	super.postInit(self)
end

function AngryBirds:setState(state)
	self.state = state
	self.state_timer = 0
	self:onStateChange(state)
end

function AngryBirds:update()
    self.state_timer = self.state_timer + DT

    if self.state == "TRANSITION" then
        self.fade.alpha = self.state_timer
		if self.state_timer > 2.5 then
			self:setState("LEVELSELECTION")
		end
	elseif self.state == "LEVELSELECTION" then
		if self.state_timer < 2.5 then
			self.ls_alpha = self.state_timer
        else
            self.ls_alpha = 1
        end
    end
    super.update(self)
end

function AngryBirds:onStateChange(state)
    if state == "LEVELSELECTION" then
        self.music:play("minigames/ab/levelselect")
    end
end

function AngryBirds:draw()
    super.draw(self)
	
    love.graphics.setColor(1, 1, 1, self.ls_alpha)
    if self.state == "LEVELSELECTION" then
        love.graphics.setColor(143/255, 116/255, 185/255)
        love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(self.ls_bg, 0, 0)
        love.graphics.draw(self.ls_left, 0, 293)
        love.graphics.draw(self.ls_right, 427, 286)
    end
end

--[[function AngryBirds:showRewardPopup(block_type)
    if block_type == "golden_egg" then
        Assets.playSound("minigames/ab/misc/goldenegg")
    elseif block_type == "boomerang_bird" or block_type == "star" or block_type == "generic_reward" then
        Assets.playSound("minigames/ab/misc/star_collect")
    end

    self:addChild(self.reward_popup)
end]]

return AngryBirds