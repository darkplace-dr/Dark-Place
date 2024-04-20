local AngryBirdsMainMenu, super = Class(Object)

function AngryBirdsMainMenu:init()
	super.init(self)

    self.main_menu_state = "MAINMENU" -- "MAINMENU", "POPUP", "CREDITS"
	
    self.backgroundColour = {
        r = 11,
        g = 101,
        b = 76,
        a = 255
    }
	
    self.bird_sprites = {}
    self.bird_animations = {}
    self.menu_sunset_angle = 0

	-- menu buttons
    self.playButton     = AngryBirdsButton(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2 + 20, 1, 1, 1, 1.15, "play", "ui_button_select")
    self.backButton     = AngryBirdsButton(58, SCREEN_HEIGHT - 45, 0.8, 0.8, 0.8, 0.95, "back", "ui_button_select")
    self.settingsButton = AngryBirdsButton(SCREEN_WIDTH - 53, SCREEN_HEIGHT - 48, 0.8, 0.8, 0.8, 0.95, "settings", "ui_button_select")
    self.editorButton   = AngryBirdsButton(SCREEN_WIDTH /2, SCREEN_HEIGHT - 48, 0.8, 0.8, 0.8, 0.95, "editor", "ui_button_select")
	
    self:addChild(self.playButton)
    self:addChild(self.backButton)
    self:addChild(self.settingsButton)
    self:addChild(self.editorButton)
	
    self.minigame = Game.minigame ---@type AngryBirds
	
    self:buildBirdList()
	
    self.popup = false
end

function AngryBirdsMainMenu:setState(state)
	self.menu_state = state
	self.state_timer = 0
	self:onStateChange(state)
end

function AngryBirdsMainMenu:onStateChange(state)
    if self.menu_state == "POPUP" or self.menu_state == "CREDITS" then
        self.playButton.enabled = false
        self.backButton.enabled = false
        self.settingsButton.enabled = false
        self.editorButton.enabled = false
    else
        self.playButton.enabled = true
        self.backButton.enabled = true
        self.settingsButton.enabled = true
        self.editorButton.enabled = true
    end
	
    if self.menu_state == "CREDITS" then
        self.playButton.visible = false
        self.backButton.visible = false
        self.settingsButton.visible = false
        self.editorButton.visible = false
    else
        self.playButton.visible = true
        self.backButton.visible = true
        self.settingsButton.visible = true
        self.editorButton.visible = true
    end
end

function AngryBirdsMainMenu:update() 
	super.update(self)
	
    self.menu_sunset_angle = self.menu_sunset_angle + 0.125 * (DTMULT / 30)
    if self.menu_sunset_angle > math.pi then
        self.menu_sunset_angle = self.menu_sunset_angle - 2 * math.pi
    end
	
    if self.minigame.state ~= "MENU" then
	    self:setState("POPUP")
	end
	
    self:animateBirds()
	
	if self.playButton.pressed == true then
        self.minigame:setState("LEVELSELECTION")
	end
	--[[if self.editorButton.pressed == true then
        self.minigame:setState("EDITORMENU")
	end]]
	
    if self.backButton.pressed == true and self.popup == false then
        self.minigame:addChild(AngryBirdsPopup())
        self:setState("POPUP")
		self.popup = true
    elseif self.settingsButton.pressed == true and self.popup == false then
        self.minigame:addChild(AngryBirdsCredits())
        self:setState("CREDITS")
		self.popup = true
    end
end

function AngryBirdsMainMenu:buildBirdList()

    -- adds a bird to the menu after unlocking its tutorial screen. TBA
    --[[
	if self.birds_data["tutorials"] ~= nil then
        for k, v in ipairs(self.birds_data["tutorials"]) do
            table.insert(self.bird_sprites, {sprite = k, reward = 0 })
        end
    end
	]]

    if #self.bird_sprites == 0 then
        table.insert(self.bird_sprites, {sprite = "minigames/ab/birds/red/idle", reward = 0 })
        table.insert(self.bird_sprites, {sprite = "minigames/ab/birds/blue/idle", reward = 0 })
        table.insert(self.bird_sprites, {sprite = "minigames/ab/birds/yellow/idle", reward = 0 })
        table.insert(self.bird_sprites, {sprite = "minigames/ab/birds/bomb/idle", reward = 0 })
        table.insert(self.bird_sprites, {sprite = "minigames/ab/birds/white/idle", reward = 0 })
        table.insert(self.bird_sprites, {sprite = "minigames/ab/birds/white/idle", reward = 0 })
        table.insert(self.bird_sprites, {sprite = "minigames/ab/birds/boomerang/idle", reward = 0 })
        table.insert(self.bird_sprites, {sprite = "minigames/ab/birds/bigbrother/idle", reward = 0 })
    end
end

function AngryBirdsMainMenu:animateBirds()
    local items_per_category = 3
    local items_in_total = #self.bird_sprites * items_per_category
	
    if #self.bird_animations < items_in_total and love.math.random(1,3) == 1 then
        local layer = love.math.random(1, 5)
        local tx = love.math.random(-SCREEN_WIDTH * 0.75, SCREEN_WIDTH * 0.75)
        local ty = SCREEN_HEIGHT - 30

        local scale = layer * 0.2
        local tx_vel = love.math.random(100, 350) * scale * 1.75
        local ty_vel = love.math.random(-400, -150) * scale * 1.75
		
        local temp_bird_sprite = self.bird_sprites[love.math.random(#self.bird_sprites)]
        local sprite = temp_bird_sprite.sprite
        local reward = temp_bird_sprite.reward

        local angle_speed = 0

        -- used for the rewards you get after completing an episode.
        if reward == 1 then
            angle_speed = love.math.random() * math.pi * 1.5
        elseif reward == 2 then
            tx = love.math.random(SCREEN_WIDTH * 0.1, SCREEN_WIDTH * 0.9)
            ty_vel = love.math.random(-250, -150) * scale * (SCREEN_HEIGHT / 320 + 1) * 0.175
            tx_vel = 0
        end
		
        local yell_sprite = sprite .. "/yell" or sprite

        table.insert(self.bird_animations, { 
		    sprite = sprite,
            yell_sprite = yell_sprite,
			angle = 0, 
			angle_speed = angle_speed, 
			x = tx, 
			y = ty, 
			x_vel = tx_vel, 
			y_vel = ty_vel, 
			scale = scale, 
			layer = layer, 
			reward = reward
		} )
    end

    for i = #self.bird_animations, 1, -1 do
        local v = self.bird_animations[i]
        if v.reward == 2 then -- danger above movement
            v.angle = math.sin(v.angle_speed) * 0.15
            v.angle_speed = (v.angle_speed + DT * 2) % (math.pi * 2)
            v.x = v.x - v.angle * v.layer / 2
        else
            v.y_vel = v.y_vel + 150 * DT
            v.angle = v.angle + v.angle_speed * DT
        end
        v.x = v.x + v.x_vel / 2 * DT
        v.y = v.y + v.y_vel / 2 * DT
		
        if v.y > SCREEN_HEIGHT + 50 * SCREEN_HEIGHT / 320 --[[or ((v.reward == 2 or v.reward == 2) and v.y < -v:spriteHeight)]] then
            table.remove(self.bird_animations, i)
        end
    end
	
    -- easter egg that occurs when a bird on layer 5 is clicked on. probably gonna need help with getting this one working lol.

	--[[if keyPressed["LBUTTON"] and currentMenuPage ~= about then
		for i = 1, #self.bird_animations do
            local v = self.bird_animations[i]
			if v.layer == 5 then
				v.renderState = true
				if SpriteItem.checkBounds(v, cursor.x, cursor.y) 
				   and v.yelling ~= true 
				   and _G.string.sub(v.sprite, 1, 4) == "BIRD" then
					v.yelling = true
					Assets.playSound(self:birdSpriteSoundMapping[v.sprite])
					v.sprite = v.yell_sprite
				end
			end
		end
	end]]
end

function AngryBirdsMainMenu:drawMenu()
    love.graphics.setColor(255/255, 238/255, 159/255)
    love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    love.graphics.setColor(COLORS.white)

    love.graphics.setBlendMode("alpha")
    Draw.draw(Assets.getTexture("minigames/ab/ui/menu/bg/menu_top"), 0, 0, 0, 1, 1)

    love.graphics.setBlendMode("add")
    for add_angle = 0, math.pi * 2, 0.6284 do
        local final_angle = self.menu_sunset_angle + add_angle
        if final_angle > math.pi then
            final_angle = final_angle - 2 * math.pi
        end
        if final_angle > -math.pi * 0.5 and final_angle < math.pi * 0.5 then
            Draw.draw(Assets.getTexture("minigames/ab/ui/menu/bg/sunray"), math.floor(SCREEN_WIDTH / 2), math.floor((SCREEN_HEIGHT - 50)), final_angle, 1, 1, 73, 734)
        end
    end
    love.graphics.setBlendMode("alpha")

    love.graphics.setBlendMode("alpha", "premultiplied")
    Draw.draw(Assets.getTexture("minigames/ab/ui/menu/bg/sun"), math.floor(SCREEN_WIDTH / 2), math.floor((SCREEN_HEIGHT - 50)), 0, 1, 1, 197, 229)
    love.graphics.setBlendMode("alpha")

   -- hill backgrounds and birds/rewards
    love.graphics.setBlendMode("alpha", "premultiplied")	
    Draw.drawWrapped(Assets.getTexture("minigames/ab/ui/menu/bg/hills_5"), true, false, (SCREEN_WIDTH / 2) - (Kristal.getTime() * 10) % (800 - 0.5), math.floor(SCREEN_HEIGHT), 0, 1, 1, 400, 172)
    love.graphics.setBlendMode("alpha")
	
    for k, v in ipairs(self.bird_animations) do
        local scale_x,scale_y = v.scale * 0.75
        Draw.draw(Assets.getTexture(v.sprite), math.floor(v.x / (v.scale * 0.75)), math.floor(v.y / (v.scale * 0.75) - SCREEN_HEIGHT * 0.5 / v.scale), v.angle, scale_x, scale_y)
    end

    love.graphics.setBlendMode("alpha", "premultiplied")
    Draw.drawWrapped(Assets.getTexture("minigames/ab/ui/menu/bg/hills_4"), true, false, (SCREEN_WIDTH / 2) - (Kristal.getTime() * 15) % (800 - 0.5), math.floor(SCREEN_HEIGHT), 0, 1, 1, 400, 158)
    love.graphics.setBlendMode("alpha")

    for k, v in ipairs(self.bird_animations) do
        local scale_x,scale_y = v.scale * 0.5
        if v.layer == 2 then
            Draw.draw(Assets.getTexture(v.sprite), math.floor(v.x / (v.scale * 0.5)), math.floor(v.y / (v.scale * 0.5) - SCREEN_HEIGHT * 0.5 / v.scale), v.angle, scale_x, scale_y)
        end
    end

    love.graphics.setBlendMode("alpha", "premultiplied")
    Draw.drawWrapped(Assets.getTexture("minigames/ab/ui/menu/bg/hills_3"), true, false, (SCREEN_WIDTH / 2) - (Kristal.getTime() * 22) % (800 - 0.5), math.floor(SCREEN_HEIGHT), 0, 1, 1, 400, 130)
    love.graphics.setBlendMode("alpha")

    for k, v in ipairs(self.bird_animations) do
        local scale_x,scale_y = v.scale * 0.5
        if v.layer == 3 then
            Draw.draw(Assets.getTexture(v.sprite), math.floor(v.x / (v.scale * 0.5)), math.floor(v.y / (v.scale * 0.5) - SCREEN_HEIGHT * 0.2 / v.scale), v.angle, scale_x, scale_y)
        end
    end

    love.graphics.setBlendMode("alpha", "premultiplied")
    Draw.drawWrapped(Assets.getTexture("minigames/ab/ui/menu/bg/hills_2"), true, false, (SCREEN_WIDTH / 2) - (Kristal.getTime() * 33) % (800 - 0.5), math.floor(SCREEN_HEIGHT), 0, 1, 1, 400, 130)
    love.graphics.setBlendMode("alpha")

    for k, v in ipairs(self.bird_animations) do
        local scale_x,scale_y = v.scale * 0.65
        if v.layer == 4 then
            Draw.draw(Assets.getTexture(v.sprite), math.floor(v.x / (v.scale * 0.5)), math.floor(v.y / (v.scale * 0.5) - SCREEN_HEIGHT * 0.125 / v.scale), v.angle,  scale_x,  scale_y)
        end
    end

    love.graphics.setBlendMode("alpha", "premultiplied")
    Draw.drawWrapped(Assets.getTexture("minigames/ab/ui/menu/bg/hills_1"), true, false, (SCREEN_WIDTH / 2) - (Kristal.getTime() * 50) % (800 - 0.5), math.floor(SCREEN_HEIGHT), 0, 1, 1, 400, 79)
    love.graphics.setBlendMode("alpha")

    for k, v in ipairs(self.bird_animations) do
        if v.layer == 5 then
            Draw.draw(Assets.getTexture(v.sprite), math.floor(v.x / (v.scale * 0.5)), math.floor(v.y / (v.scale * 0.5) - SCREEN_HEIGHT * 0.2 / v.scale), v.angle, v.scale, v.scale)
        end
    end
end

function AngryBirdsMainMenu:draw()
    self:drawMenu()
	
	if self.menu_state ~= "CREDITS" then
        Draw.draw(Assets.getTexture("minigames/ab/ui/menu/bg/logo"), SCREEN_WIDTH / 2, 327, 0, 1, 1, 249, 285)
	end
	
    super.draw(self)
	
	if self.menu_state == "POPUP" then
	    Draw.setColor(0, 0, 0, 0.5)
	    love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
	end
end

return AngryBirdsMainMenu
