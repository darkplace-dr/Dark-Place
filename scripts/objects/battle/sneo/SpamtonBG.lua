local BG, super = Class(Object)

function BG:init()
    super:init(self)
	
	local backdrop = Rectangle(0, 0, 640, 480)
	backdrop:setColor(0, 0, 0)
	self:addChild(backdrop)
	
	local background = Sprite("battle/backgrounds/sneo/cityscape_background", 0, 0)
	background.wrap_texture_x = true
	background:setScale(2)
	background.physics.speed_x = -6
	self:addChild(background)
	
	local midground = Sprite("battle/backgrounds/sneo/cityscape_midground", 0, 0)
	midground.wrap_texture_x = true
	midground:setScale(2)
	midground.physics.speed_x = -7
	self:addChild(midground)
	
	local foreground = Sprite("battle/backgrounds/sneo/cityscape_foreground", 0, 0)
	foreground.wrap_texture_x = true
	foreground:setScale(2)
	foreground.physics.speed_x = -8
	self:addChild(foreground)

	self.layer = BATTLE_LAYERS["bottom"]
end

function BG:draw()
  super:draw(self)
  love.graphics.setColor(0,0,0, Game.battle.background_fade_alpha)
  love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
end

return BG