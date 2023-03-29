local AchievementPopUp, super = Class(Object)

function AchievementPopUp:init(achievement)
    super:init(self, SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
	
	self.achievement = Kristal.callEvent("getAchievement", achievement)
	
	self.icon = self.achievement.icon
	self.rarity = self.achievement.rarity
	self.name = self.achievement.name
	self.desc = self.achievement.description
	
	self.raritysprite = Sprite("achievements/frames/"..self.rarity, 0, 0)
	self.iconsprite = Sprite(self.icon, 8, 8)
	self.raritysprite:setScale(2,2)
	self.iconsprite:setScale(2,2)
	self:addChild(self.raritysprite)
	self:addChild(self.iconsprite)
	
	self.phase = 1
	self.timer = 0
	
	Assets.playSound("achievement")
end

function AchievementPopUp:update()
	super:update(self)
	
	if self.phase == 1 then
		self.x = self.x - (4 * DTMULT)
		if self.x < SCREEN_WIDTH - 80 then
			self.x = SCREEN_WIDTH - 80
			self.phase = 2
		end
	elseif self.phase == 2 then
		self.timer = self.timer + DT
		if self.timer >= 4 then
			self.phase = 3
		end
	else
		self.x = self.x + (4 * DTMULT)
		if self.x > SCREEN_WIDTH then
			self:remove()
		end
	end
end

return AchievementPopUp
