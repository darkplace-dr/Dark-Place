local AngryBirds, super = Class("MinigameHandler")

-- TO-DO: Add a LOT more stuff to this lmao.

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

    self.particles = {}
	
    -- TO-DO: move audio-related tables to its own separate thing as well maybe? Something similar the "jukebox_songs" table for example
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
        "minigames/ab/ambient/red_savannah",
    }
    self.title_theme = {
        "minigames/ab/title_theme",
        --"minigames/ab/title_theme_trilogy",
        "minigames/ab/funky_theme",
    }

    self.show_editor = true

    Game:setBorder("minigames/angrybirds")
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
        self:addChild(AngryBirdsMainMenu())
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
end

function AngryBirds:getAudioName(name)
	if self.audio_groups[name] ~= nil then
		local index = math.random(1, #self.audio_groups[name])
		return self.audio_groups[name][index]
	end
	return name
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

function AngryBirds:draw()
    super.draw(self)

    love.graphics.setColor(1, 1, 1, 1)
	
    if self.state == "SPLASHES" then
        self:drawSplashes()
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