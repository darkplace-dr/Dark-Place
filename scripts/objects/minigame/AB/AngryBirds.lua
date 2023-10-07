local AngryBirds, super = Class("MinigameHandler")

function AngryBirds:init()
    super.init(self)
	
    self.state = "LEVELSELECTION", -- "TRANSITION", "LEVELSELECTION", "LEVEL", "PAUSE", "LEVELCLEAR", "LEVELFAIL"
	Assets.playSound("minigames/ab/misc/star_collect")
	
    self.music = Music()
    self.timer = Timer()
	
	self.state_timer = 0
	
	self.bg = Rectangle(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, 0, 0)
	self.bg:setOrigin(0.5,0.5)
	self.bg.color = {1,1,1}
    self.bg.alpha = 0
	self:addChild(self.bg)
	
    self.ls_page = 1
	
    self.ls_bg = Assets.getTexture("minigames/ab/levelselect/bg")
    self.ls_left = Assets.getTexture("minigames/ab/levelselect/left")
    self.ls_right = Assets.getTexture("minigames/ab/levelselect/right")
	
    --self.reward_popup = self:spawnObject(ABRewardPopUp())
end

function AngryBirds:setState(state)
	self.state = state
	self.state_timer = 0
	self:onStateChange(state)
end

function AngryBirds:onStateChange(state)
    if state == "TRANSITION" then
        self.timer:tween()
    end
    if state == "LEVELSELECTION" then
        self.music:play("minigames/ab/levelselect")
    end
end

function AngryBirds:draw()
    super.draw(self)
	
    love.graphics.setColor(1, 1, 1)
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