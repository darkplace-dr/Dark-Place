---@class Soul
local Soul, super = Class(Soul)

function Soul:init(x, y, color)
	super.init(self, x, y, color)

	self.sprite_focus = Sprite("player/heart_dodge_focus")
    self.sprite_focus:setOrigin(0.5, 0.5)
    self.sprite_focus.inherit_color = false
	self.sprite_focus.alpha = 0
    self:addChild(self.sprite_focus)
end

function Soul:update()
	super.update(self)

	if Input.down("cancel") then
		self.collider.radius = 4
		self.sprite_focus.alpha = 1
	else
		self.collider.radius = 8
		self.sprite_focus.alpha = 0
	end
end

return Soul