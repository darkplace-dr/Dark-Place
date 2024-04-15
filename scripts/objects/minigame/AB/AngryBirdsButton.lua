local AngryBirdsButton, super = Class(Object)

function AngryBirdsButton:init(x, y, sx, sy, s_begin, s_end, image, sound)
	super:init(self, x, y, 0, 0)
	
    self.scale_x, self.scale_y = sx, sy
    self.scale_begin = s_begin
    self.scale_end = s_end
	
	if image then
		self.image_path = "minigames/ab/ui/buttons/" .. image
		
		self.sprite = Sprite(self.image_path)
		self:addChild(self.sprite)
		self:setOrigin(0.5,0.5)
		
		self.width = self.sprite.width
		self.height = self.sprite.height
	else
		self.image_path = "minigames/ab/ui/buttons/template"
		
		self.sprite = Sprite(self.image_path)
		self:addChild(self.sprite)
		self:setOrigin(0.5,0.5)
		
		self.width = self.sprite.width
		self.height = self.sprite.height
	end
    if sound then
        self.sound_path = "minigames/ab/" .. sound
		self.sound = self.sound_path
	end
	
    self.enabled = true
end

function AngryBirdsButton:update() 
	super.update(self)
    local minigame = Game.minigame ---@type AngryBirds

	local mx, my = love.mouse.getPosition()
	local screen_x, screen_y = self:getScreenPos()
	screen_x, screen_y = screen_x-self.width/2, screen_y-self.height/2
	--if not self.pressed then
	if (mx / Kristal.getGameScale() > screen_x) and (mx / Kristal.getGameScale() < (screen_x + self.width)) and (my / Kristal.getGameScale() > screen_y) and (my / Kristal.getGameScale() < (screen_y + self.height)) and self:canHover() then
		if self:canClick() then
            if self.scale_x < self.scale_end then
                self.scale_x = self.scale_x + DT
                self.scale_y = self.scale_y + DT
            end
			if not self.pressed and love.mouse.isDown(1) then
				self.pressed = true
				self:onClick()
			end
			if not love.mouse.isDown(1) then
				self.pressed = false
			end
		end
	else
		if self.scale_x > self.scale_begin then
			self.scale_x = self.scale_x - DT
			self.scale_y = self.scale_y - DT
		end
	end
	--else
	--end
end

function AngryBirdsButton:draw() super:draw(self) end

function AngryBirdsButton:onClick()
	Assets.playSound(self.sound)
end

function AngryBirdsButton:canClick() return self.enabled end
function AngryBirdsButton:canHover() return self.enabled end

return AngryBirdsButton
