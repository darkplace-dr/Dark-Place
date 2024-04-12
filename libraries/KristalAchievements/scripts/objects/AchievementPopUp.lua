---@class AchievementPopUp : Object
local AchievementPopUp, super = Class(Object)

function AchievementPopUp:init(achievement)
    super.init(self, SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

	self.achievement = Kristal.callEvent("getAchievement", achievement)

	self.icon = self.achievement.icon
	self.rarity = self.achievement.rarity
	self.name = self.achievement.name
	self.desc = self.achievement.description

	self.rarity_sprite = Sprite("achievements/frames/"..self.rarity, 0, 0)
	self.icon_sprite = Sprite(self.icon, 8, 8)
	self.rarity_sprite:setScale(2, 2)
	self.icon_sprite:setScale(2, 2)
	self.icon_sprite:play(self.achievement.icon_anim_delay)
	self:addChild(self.rarity_sprite)
	self:addChild(self.icon_sprite)
end

function AchievementPopUp:onAdd()
	Assets.playSound("achievement")

	---@type Timer
	local timer = self.stage.timer
	timer:tween(0.25, self, { x = SCREEN_WIDTH - 80 }, "linear", function()
		timer:after(4, function()
			timer:tween(0.25, self, { x = SCREEN_WIDTH }, "linear", function()
				self:remove()
			end)
		end)
	end)
end

return AchievementPopUp