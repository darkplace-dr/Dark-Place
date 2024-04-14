local AngryBirdsButton, super = Class(Object)

function AngryBirdsButton:init(x, y, image, sound)
	super:init(self, x, y, 0, 0)
	
	if image then
		self.path = "minigames/ab/ui/buttons/" .. image
		
		self.sprite = Sprite(self.path)
		self:addChild(self.sprite)
		self:setOrigin(0.5,0.5)
		
		self.width = self.sprite.width
		self.height = self.sprite.height
	end

    self.sound = "minigames/ab/" .. sound
	self.played_sound = false
end

function AngryBirdsButton:update() 
	super.update(self)

	local mx, my = love.mouse.getPosition()
	local screen_x, screen_y = self:getScreenPos()
	screen_x, screen_y = screen_x-self.width/2, screen_y-self.height/2
	if not self.pressed then
		if (mx / Kristal.getGameScale() > screen_x) and (mx / Kristal.getGameScale() < (screen_x + self.width)) and (my / Kristal.getGameScale() > screen_y) and (my / Kristal.getGameScale() < (screen_y + self.height)) and self:canHover() then
			if self:canClick() then
				if self.scale_x < 1.15 then
					self.scale_x = self.scale_x + 0.1*DTMULT
					self.scale_y = self.scale_y + 0.1*DTMULT
				end
				if not self.played_sound then
					self.played_sound = true
				end
				if not self.pressed and love.mouse.isDown(1) then
					self.pressed = true
					self:onClick()
				end
			end
		else
			if self.scale_x > 1 then
				self.scale_x = self.scale_x - 0.1*DTMULT
				self.scale_y = self.scale_y - 0.1*DTMULT
			end
			self.played_sound = false
		end
	else
	end
end

function AngryBirdsButton:draw() super:draw(self) end

function AngryBirdsButton:onClick()
	Assets.playSound(self.sound)
end

function AngryBirdsButton:canClick() return true end
function AngryBirdsButton:canHover() return true end

return AngryBirdsButton
