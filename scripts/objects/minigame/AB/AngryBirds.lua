local AngryBirds, super = Class("MinigameHandler")

function AngryBirds:init()
    super.init(self)
	
    self.name = "Angry Birds"
	
    self.state = "TRANSITIONIN" -- "TRANSITIONIN", "SPLASHES", "MENU", "LEVEL", "TRANSITIONOUT"
	Assets.playSound("minigames/ab/star_collect")

    self.timer = Timer()
	
    self.music = Music()
	
    -- TODO: maybe make transition look more like the one from later AB Seasons versions?
	self.fade = Rectangle(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT)
	self.fade:setOrigin(0.5,0.5)
	self.fade.color = {1,1,1}
    self.fade.alpha = 0
	self:addChild(self.fade)
	
	self.state_timer = 0

    self.menu_sunset_angle = 0
    self.goldeneggs_stareffect_angle = 0
    self:menuInit()

    self.particles = {}
	
    self.audio_groups = {
        bird_misc = {
            "minigames/ab/birds/talk_a",
            "minigames/ab/birds/talk_b",
            "minigames/ab/birds/talk_c",
            "minigames/ab/birds/talk_d",
            "minigames/ab/birds/talk_e",
            "minigames/ab/birds/talk_f",
            "minigames/ab/birds/talk_g",
            "minigames/ab/birds/talk_h",
            "minigames/ab/birds/talk_i",
            "minigames/ab/birds/talk_j",
            "minigames/ab/birds/talk_k",
            "minigames/ab/birds/talk_l"
        },
        bird_next_military = {
            "minigames/ab/birds/next_military_a",
            "minigames/ab/birds/next_military_b",
            "minigames/ab/birds/next_military_c"
        },
        bird_shot = {
            "minigames/ab/misc/launched_a",
            "minigames/ab/misc/launched_b",
            "minigames/ab/misc/launched_c"
        },
        red_special = {
            "minigames/ab/birds/red/special_a",
            "minigames/ab/birds/red/special_b",
            "minigames/ab/birds/red/special_c"
        },
        level_clear_military = {
            "minigames/ab/birds/level_clear_military_a",
            "minigames/ab/birds/level_clear_military_b"
        },
        level_failed_piglets = {
            "minigames/ab/birds/level_failed_pigs_a",
            "minigames/ab/birds/level_failed_pigs_b"
        },
        level_start_military = {
            "minigames/ab/birds/level_start_military_a",
            "minigames/ab/birds/level_start_military_b"
        },
        light_collision = {
            "light collision a1",
            "light collision a2",
            "light collision a3",
            "light collision a4",
            "light collision a5",
            "light collision a6",
            "light collision a7",
            "light collision a8"
        },
        light_damage = {
            "light damage a1",
            "light damage a2",
            "light damage a3"
        },
        light_destroyed = {
            "light destroyed a1",
            "light destroyed a2",
            "light destroyed a3"
        },
        rock_collision = {
            "rock collision a1",
            "rock collision a2",
            "rock collision a3",
            "rock collision a4",
            "rock collision a5"
        },
        rock_damage = {
            "rock damage a1",
            "rock damage a2",
            "rock damage a3"
        },
        rock_destroyed = {
            "rock destroyed a1",
            "rock destroyed a2",
            "rock destroyed a3"
        },
        wood_collision = {
            "wood collision a1",
            "wood collision a2",
            "wood collision a3",
            "wood collision a4",
            "wood collision a5",
            "wood collision a6"
        },
        wood_damage = {
            "wood damage a1",
            "wood damage a2",
            "wood damage a3"
        },
        wood_destroyed = {
            "wood destroyed a1",
            "wood destroyed a2",
            "wood destroyed a3"
        },
        piglette = {
            "minigames/ab/birds/pigs/talk_a",
            "minigames/ab/birds/pigs/talk_b",
            "minigames/ab/birds/pigs/talk_c",
            "minigames/ab/birds/pigs/talk_d",
            "minigames/ab/birds/pigs/talk_e",
            "minigames/ab/birds/pigs/talk_f", -- unused in original game
            "minigames/ab/birds/pigs/talk_g", -- unused in original game
            "minigames/ab/birds/pigs/talk_h",
            "minigames/ab/birds/pigs/talk_i",
            "minigames/ab/birds/pigs/talk_j",
            "minigames/ab/birds/pigs/talk_k",
            "minigames/ab/birds/pigs/talk_l"
        },
        piglette_collision = {
            "minigames/ab/birds/pigs/collision_a",
            "minigames/ab/birds/pigs/collision_b",
            "minigames/ab/birds/pigs/collision_c",
            "minigames/ab/birds/pigs/collision_d",
            "minigames/ab/birds/pigs/collision_e",
            "minigames/ab/birds/pigs/collision_f",
            "minigames/ab/birds/pigs/collision_g",
            "minigames/ab/birds/pigs/collision_h"
        },
        piglette_damage = {
            "minigames/ab/birds/pigs/damage_a",
            "minigames/ab/birds/pigs/damage_b",
            "minigames/ab/birds/pigs/damage_c",
            "minigames/ab/birds/pigs/damage_d",
            "minigames/ab/birds/pigs/damage_e",
            "minigames/ab/birds/pigs/damage_f",
            "minigames/ab/birds/pigs/damage_g",
            "minigames/ab/birds/pigs/damage_h"
        },
    }
    self.ambience = {
        "minigames/ab/ambient/white_dryforest",
        "minigames/ab/ambient/greenish_jungle",
        "minigames/ab/ambient/red_savannah"
    }
    self.title_theme = {
        "minigames/ab/title_theme",
        "minigames/ab/title_theme_trilogy",
        "minigames/ab/funky_theme",
    }
end

function AngryBirds:postInit()
    super.postInit(self)

    --data and settings for the minigame
    if not love.filesystem.getInfo("saves/"..Mod.info.id.."/ab_settings.json") then
        self.birds_data = {
            ["current_title_theme"] = 1,
            ["tutorials"] = {},
        }
        love.filesystem.write("saves/"..Mod.info.id.."/ab_settings.json", JSON.encode(self.birds_data))
    else
        self.birds_data = JSON.decode(love.filesystem.read("saves/"..Mod.info.id.."/ab_settings.json"))
    end

    self.current_title_theme = self.birds_data["current_title_theme"]
end

function AngryBirds:setState(state)
	self.state = state
	self.state_timer = 0
	self:onStateChange(state)
end

function AngryBirds:onStateChange(state)
    if state == "MENU" then
        if self.music:isPlaying(self.title_theme[self.current_title_theme]) == false then
            self.music:play(self.title_theme[self.current_title_theme])
        end
    end
end

function AngryBirds:update()
    self.state_timer = self.state_timer + DT

    if self.state == "TRANSITIONIN" then
        self.fade.alpha = self.state_timer
		if self.state_timer > 2.5 then
			self:setState("SPLASHES")
            self.fade:remove()
		end
	elseif self.state == "SPLASHES" then
		if self.state_timer < 2.5 then
			self.ls_alpha = self.state_timer
        else
            self.ls_alpha = 1
        end
    end
	
    if self.state == "MENU" then
        if self.current_menu_page == self.main_menu then
            self.menu_sunset_angle = self.menu_sunset_angle + 0.125 * (DTMULT / 30)
            if self.menu_sunset_angle > math.pi then
                self.menu_sunset_angle = self.menu_sunset_angle - 2 * math.pi
            end
            self:animateBirds()
		end
    end

    super.update(self)
end

function AngryBirds:menuInit()
    self.level_order = {
        packs = {
            "pack1",
            "packDR",
            "packGE"
        },
        pack1 = {
            "Level1",
            "Level2",
            "Level3",
            "Level4",
            "Level5",
            "Level6",
            "Level7",
            "Level8",
            "Level9",
            "Level10"
        },
        packDR = {
            "DR_Level1",
            "DR_Level2",
            "DR_Level3",
            "DR_Level4",
            "DR_Level5",
            "DR_Level6",
            "DR_Level7",
            "DR_Level8",
            "DR_Level9",
            "DR_Level10"
        },
        packGE = {
            "GE_LevelHatchery",
            "GE_LevelConcept",
            "GE_LevelSpace",
            "GE_LevelGoldberg",
            "GE_LevelDeltaRune"
        },
    }
    self.level_order_pack1 = self.level_order["packGE"]
    self.level_order_deltarune = self.level_order["packDR"]
    self.level_order_goldeneggs = self.level_order["packGE"]

    self:createMenuPages()
	
	self.selected_menu_item = -1
	self.current_menu_page = self.main_menu
	self.old_menu_page = nil
	
    self:prepareMenuPage(self.main_menu)

    self.bird_animations = {}
end

function AngryBirds:createMenuPages()
    self.main_menu = {
        name = "main_menu",
        back = nil,
        title = {
            sprite = "minigames/ab/ui/menu/bg/logo",
            x = SCREEN_WIDTH / 2,
            y = 7
        },
        items = {
            {
                sprite = "minigames/ab/ui/buttons/play",
                x = SCREEN_WIDTH / 2,
                y = SCREEN_HEIGHT / 2 + 20,
                updateFunction = self:gotoLevelSelection(),
                scale_x = 1, 
                scale_y = 1,
                origin_x = 45,
                origin_y = 24,
            },
            {
                sprite = "minigames/ab/ui/buttons/back",
                x = 58,
                y = SCREEN_HEIGHT - 45,
                updateFunction = self:gotoExitPopup(),
                scale_x = 0.8, 
                scale_y = 0.8,
                origin_x = 45,
                origin_y = 45,
            },
            {
                sprite = "minigames/ab/ui/buttons/settings",
                x = SCREEN_WIDTH - 53,
                y = SCREEN_HEIGHT - 48,
                updateFunction = self:gotoSettingsMenu(),
                scale_x = 0.8, 
                scale_y = 0.8,
                origin_x = 53,
                origin_y = 48,
            },
            {
                sprite = "minigames/ab/ui/buttons/editor",
                x = SCREEN_WIDTH / 2,
                y = SCREEN_HEIGHT - 48,
                updateFunction = self:gotoSettingsMenu(),
                scale_x = 0.8, 
                scale_y = 0.8,
                origin_x = 53,
                origin_y = 48,
            },
        }
    }
    self.settings_page = {
        name = "settings_page",
        back = nil,
        sound = "minigames/ab/ui_menu_confirm",
        bg_overlay = {sprite = "minigames/ab/menu/dim_block", visible = true},
        popup = true,
        items = {}
    }
	
    --[[if self.birds_data["tutorials"] == nil then
        self.birds_data["tutorials"] = {}
    end]]
end

function AngryBirds:offsetCoordinates(page, x, y)
    if page.offset_x ~= nil then
        x = x + page.offset_x
    end

    if page.offset_y ~= nil then
        y = y + page.offset_y
    end

    return x, y
end

function AngryBirds:prepareMenuPage(page)
    if page == nil then
        return
    end
	
    if page.bg_overlay ~= nil then
        page.bg_overlay.shade = 0
    end
	
    if page == self.main_menu then
        self.bird_sprites = {}
		
        -- adds a bird to the menu after unlocking its tutorial screen
        --[[if self.birds_data["tutorials"] ~= nil then
            for k, v in ipairs(self.birds_data["tutorials"]) do
                table.insert(self.bird_sprites, {sprite = k, reward = 0 })
            end
        end]]

        -- for testing the birds and rewards that appear on the menu
        if #self.bird_sprites == 0 then
            table.insert(self.bird_sprites, {sprite = "minigames/ab/birds/red/idle", reward = 0 })
        end
    end
end

function AngryBirds:getAudioName(name)
	if self.audio_groups[name] ~= nil then
		local index = math.random(1, #self.audio_groups[name])
		return self.audio_groups[name][index]
	end
	return name
end

function AngryBirds:gotoLevelSelection()
end

function AngryBirds:gotoSettingsMenu()
end

function AngryBirds:gotoExitPopup()
end

-- birds move at ludicrous speed for some reason. not sure why.
function AngryBirds:animateBirds()
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

        table.insert(self.bird_animations, { sprite = sprite, angle = 0, angle_speed = angle_speed, x = tx, y = ty, x_vel = tx_vel, y_vel = ty_vel, scale = scale, layer = layer, reward = reward} )
    end

    for i = #self.bird_animations, 1, -1 do
        local v = self.bird_animations[i]
        if v.reward == 2 then -- danger above movement
            v.angle = math.sin(v.angle_speed) * 0.15
            v.angle_speed = (v.angle_speed + (DTMULT / 30) * 2) % (math.pi * 2)
            v.x = v.x - v.angle * v.layer / 2
        else
            v.y_vel = v.y_vel + 150 * (DTMULT / 30)
            v.angle = v.angle + v.angle_speed * (DTMULT / 30)
        end
        v.x = v.x + v.x_vel / 2 * (DTMULT / 30)
        v.y = v.y + v.y_vel / 2 * (DTMULT / 30)
		
        if v.y > SCREEN_HEIGHT + 50 * SCREEN_HEIGHT / 320 --[[or ((v.reward == 2 or v.reward == 2) and v.y < -v.sprite.height)]] then
            table.remove(self.bird_animations, i)
        end
    end
	
    -- easter egg that occurs when a bird on layer 5 is clicked on. probably gonna need help with getting this one working lol.

	--[[if keyPressed["LBUTTON"] and currentMenuPage ~= about then
		for i = 1, #self.bird_animations do
			if self.bird_animations[i].layer == 5 then
				self.bird_animations[i].renderState = true
				if SpriteItem.checkBounds(self.bird_animations[i], cursor.x, cursor.y) 
				   and self.bird_animations[i].yelling ~= true 
				   and _G.string.sub(self.bird_animations[i].sprite, 1, 4) == "BIRD" then
					self.bird_animations[i].yelling = true
					Assets.playSound(self:birdSpriteSoundMapping[self.bird_animations[i].sprite])
					self.bird_animations[i].sprite = self.bird_animations[i].sprite .. "/yell"
				end
			end
		end
	end]]
	
end

function AngryBirds:drawSplashes()
    -- functions like how it does in the original game.
    if self.splash_timer == nil then
        self.splash_timer = 0
        self.current = 1
        self.splashes = {
            {
                sprite = "minigames/ab/splashes/disclaimer",
                splash_time = 2
            },
            {
                sprite = "minigames/ab/splashes/logo",
                splash_time = 4 -- it's 1 in the original Angry Birds code, but it felt too short when I ported it over, so it's 4 here lol.
            }
        }
    end

    self.splash_timer = self.splash_timer + DT

    -- skips over a splash screen when clicked or pressed. when there's no more splash to display, it goes to the "MENU" state.
    if Input.pressed("confirm") or love.mouse.isDown(1) then
        self.splash_timer = self.splashes[self.current].splash_time + 1
    end
	
    Draw.draw(Assets.getTexture(self.splashes[self.current].sprite), 0, 0)
    if self.current == 2 then
        Draw.draw(Assets.getTexture("minigames/ab/splashes/loading"), SCREEN_WIDTH - 112, SCREEN_HEIGHT - 27)
    end

    -- changes splash screen if showed long enough
    if self.splash_timer > self.splashes[self.current].splash_time then
        self.splash_timer = 0
        self.current = self.current + 1
        if self.current > #self.splashes then
            self:setState("MENU")
        end
    end
end

function AngryBirds:drawMenu()
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

    Draw.draw(Assets.getTexture("minigames/ab/ui/menu/bg/sun"), math.floor(SCREEN_WIDTH / 2), math.floor((SCREEN_HEIGHT - 50)), 0, 1, 1, 197, 229)

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
	
    self:drawMenuPage(self.main_menu)
	
    if self.loading then
        self:drawMenuPage(self.loading_page)
    end
end

function AngryBirds:drawMenuPage(page)
    if page == nil then
        return
    end
	
    if page.v ~= nil and page.bg_overlay.sprite ~= nil and page.bg_overlay.visible ~= false then
        if page.bg_overlay.sprite == "minigames/ab/menu/dim_block" and page.bg_overlay.shade ~= nil then
            Draw.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
        else
            for k = 0, SCREEN_HEIGHT do
                for v = 0, SCREEN_WIDTH do
                    Draw.draw(Assets.getTexture(page.bg_overlay.sprite), math.floor(v), math.floor())
                end
            end
        end
    end
  
    --self:drawMenuBackground(page)
    self:drawMenuItems(page)
    self:drawMenuTitle(page)
end

--[[function AngryBirds:drawMenuBackground(page)
end]]

function AngryBirds:drawMenuTitle(page)
    if page.title == nil then
        return
    end
  
    local title_y = 0
	
    if page.title.y ~= nil then
        title_y = page.title.y
    end
	
    title_y = self:offsetCoordinates(page, page.title.x, y)

    if page.title.sprite ~= nil then
        Draw.draw(Assets.getTexture(page.title.sprite), math.floor(self:offsetCoordinates(page, page.title.x, title_y)), math.floor(title_y), 0, 1, 1, 249, 285)
    end
end

function AngryBirds:drawMenuItems(page)

    local draw_sprites = true
    local draw_text = true
    local loops = 0

    if page.draw_sprites_first == true then
        draw_text = false
        loops = 1
    end

    for k = 0, loops do
        local index = 1
        while index <= #page.items do
            local current_item = page.items[index]
            if current_item.visible ~= false then
                local x = SCREEN_WIDTH/2
                local y = SCREEN_HEIGHT/(#page.items + 1) * index
				
                x = current_item.x and current_item.x or x
                y = current_item.y and current_item.y or y
                if current_item.dont_offset ~= true then
                    x, y = self:offsetCoordinates(page, x, y)
                end
                if current_item.item_draw_function ~= nil then
                    current_item.item_draw_function(page, current_item, x, y, draw_sprites, draw_text)
                else	
                    self:drawMenuItem(page, current_item, math.floor(x), math.floor(y), draw_sprites, draw_text)
                end
            end
            index = index + 1
        end
		draw_sprites = not draw_sprites
		draw_text = not draw_text
	end
end

function AngryBirds:drawMenuItem(page, item, x, y, draw_sprites, draw_text)
    if draw_sprites == true and item.sprite ~= nil then
        Draw.draw(Assets.getTexture(item.sprite), math.floor(x), math.floor(y), 0, item.scale_x, item.scale_y, item.origin_x, item.origin_y)
    end
    
    --[[if draw_text == true and item.lines ~= nil then
        setFont(item.font)
        while 1 <= #item.lines do
            _G.res.drawString("", item.lines[1], _G.math.floor(x), _G.math.floor(y - item.h * 0.5 + _G.res.getFontLeading() * (1 - 0.5)), item.hanchor and item.hanchor or "HCENTER", item.vanchor and item.vanchor or "VCENTER")
        end
        love.graphics.setFont("FONT_MENU")
    end]]
end

function AngryBirds:drawSettingsPage()
    self:drawMenuPage(self.settings_page)
end

function AngryBirds:draw()
    super.draw(self)

    love.graphics.setColor(1, 1, 1, 1)
	
    if self.state == "SPLASHES" then
        self:drawSplashes()
    end
	
    if self.state == "MENU" then
		self:drawMenu()
    end

    if self.state == "LEVELSELECTION" then
        love.graphics.setColor(143/255, 116/255, 185/255)
        love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

        love.graphics.setColor(1, 1, 1)
        Draw.draw(Assets.getTexture("minigames/ab/ui/menu/levelselect/bg"), 0, 0)
        Draw.draw(Assets.getTexture("minigames/ab/ui/menu/levelselect/left"), 0, 293)
        Draw.draw(Assets.getTexture("minigames/ab/ui/menu/levelselect/right"), 427, 286)
    end
end

return AngryBirds