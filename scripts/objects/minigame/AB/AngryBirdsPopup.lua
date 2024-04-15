local AngryBirdsPopup, super = Class(Object)

function AngryBirdsPopup:init(x, y, width, height, default_font, default_font_size)
    super.init(self, x, y, width, height)
	
    self.box = AngryBirdsUIBox(80, 170, 480, 120, "popup", {98/255, 212/255, 187/255})
    self.box.debug_select = false
    self:addChild(self.box)
	
    self.default_font = default_font or "main_mono"
    self.default_font_size = default_font_size

    self.font = self.default_font
    self.font_size = self.default_font_size
	
    self.text = Text("Are you sure you want to quit?", 135, 205, SCREEN_WIDTH, SCREEN_HEIGHT)
    self:addChild(self.text)
	
    self.confirm_button = AngryBirdsButton(self.box.x + 360, self.box.y + (self.box.height + 20), 0.8, 0.8, 0.8, 0.95, nil, "ui_button_select")
    self.confirm_button.layer = self.box.layer + 1
	self:addChild(self.confirm_button)
	
    self.deny_button = AngryBirdsButton(self.box.x + 120, self.box.y + (self.box.height + 20), 0.8, 0.8, 0.8, 0.95, nil, "ui_button_back")
    self.deny_button.layer = self.box.layer + 1
	self:addChild(self.deny_button)
	
    self.minigame = Game.minigame ---@type AngryBirds
    self.mainMenu = self.minigame.mainMenu
end

function AngryBirdsPopup:update()
    super.update(self)
	
    if self.deny_button.pressed == true then
        self:remove()
        self.mainMenu:setState("MENU")
		self.mainMenu.popup = false
		self.mainMenu.backButton.pressed = false
    end
	
    if self.confirm_button.pressed == true then
        self.minigame:endMinigame()
    end
end

return AngryBirdsPopup