local AngryBirds, super = Class("MinigameHandler")

function AngryBirds:init()
    super.init(self)

    self.state = "TRANSITION" -- "TRANSITION", "SPLASHES", "MAINMENU", "LEVELSELECTION"
	Assets.playSound("minigames/ab/misc/star_collect")

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

    -- TBA
    self.bird_animations = {}

    -- TBA
    self.audio_groups = {
        bird_misc = Utils.pick{
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
        bird_next_military = Utils.pick{
            "minigames/ab/birds/next_military_a",
            "minigames/ab/birds/next_military_b",
            "minigames/ab/birds/next_military_c"
        },
        bird_shot = Utils.pick{
            "minigames/ab/misc/launched_a",
            "minigames/ab/misc/launched_b",
            "minigames/ab/misc/launched_c"
        },
        red_special = Utils.pick{
            "minigames/ab/birds/red/special_a",
            "minigames/ab/birds/red/special_b",
            "minigames/ab/birds/red/special_c"
        },
        level_clear_military = Utils.pick{
            "minigames/ab/birds/level_clear_military_a",
            "minigames/ab/birds/level_clear_military_b"
        },
        level_failed_piglets = Utils.pick{
            "minigames/ab/birds/level_failed_pigs_a",
            "minigames/ab/birds/level_failed_pigs_b"
        },
        level_start_military = {
            "minigames/ab/birds/level_start_military_a",
            "minigames/ab/birds/level_start_military_b"
        },
        light_collision = Utils.pick{
            "light collision a1",
            "light collision a2",
            "light collision a3",
            "light collision a4",
            "light collision a5",
            "light collision a6",
            "light collision a7",
            "light collision a8"
        },
        light_damage = Utils.pick{
            "light damage a1",
            "light damage a2",
            "light damage a3"
        },
        light_destroyed = Utils.pick{
            "light destroyed a1",
            "light destroyed a2",
            "light destroyed a3"
        },
        rock_collision = Utils.pick{
            "rock collision a1",
            "rock collision a2",
            "rock collision a3",
            "rock collision a4",
            "rock collision a5"
        },
        rock_damage = Utils.pick{
            "rock damage a1",
            "rock damage a2",
            "rock damage a3"
        },
        rock_destroyed = Utils.pick{
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
        wood_damage = Utils.pick{
            "wood damage a1",
            "wood damage a2",
            "wood damage a3"
        },
        wood_destroyed = Utils.pick{
            "wood destroyed a1",
            "wood destroyed a2",
            "wood destroyed a3"
        },
        piglette = Utils.pick{
            "minigames/ab/birds/pigs/talk_a",
            "minigames/ab/birds/pigs/talk_b",
            "minigames/ab/birds/pigs/talk_c",
            "minigames/ab/birds/pigs/talk_d",
            "minigames/ab/birds/pigs/talk_e",
            "minigames/ab/birds/pigs/talk_f",
            "minigames/ab/birds/pigs/talk_g",
            "minigames/ab/birds/pigs/talk_h",
            "minigames/ab/birds/pigs/talk_i",
            "minigames/ab/birds/pigs/talk_j",
            "minigames/ab/birds/pigs/talk_k",
            "minigames/ab/birds/pigs/talk_l"
        },
        piglette_collision = Utils.pick{
            "minigames/ab/birds/pigs/collision_a",
            "minigames/ab/birds/pigs/collision_b",
            "minigames/ab/birds/pigs/collision_c",
            "minigames/ab/birds/pigs/collision_d",
            "minigames/ab/birds/pigs/collision_e",
            "minigames/ab/birds/pigs/collision_f",
            "minigames/ab/birds/pigs/collision_g",
            "minigames/ab/birds/pigs/collision_h"
        },
        piglette_damage = Utils.pick{
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
end

function AngryBirds:postInit()
	super.postInit(self)
end

function AngryBirds:setState(state)
	self.state = state
	self.state_timer = 0
	self:onStateChange(state)
end

function AngryBirds:onStateChange(state)
    if state == "MAINMENU" then
        self.music:play("minigames/ab/funky_theme")
    end
end

-- TBA
function AngryBirds:createMenuPages()
end

function AngryBirds:update()
    self.state_timer = self.state_timer + DT

    if self.state == "TRANSITION" then
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
	
    if self.state == "MAINMENU" then
        -- this specific stuff here was in a function called updateMenu() in the OG game, but this'll do in update() for now until I get around to porting some of the other stuff lol.
        self.menu_sunset_angle = self.menu_sunset_angle + 0.0125 * DTMULT
        if self.menu_sunset_angle > math.pi then
            self.menu_sunset_angle = self.menu_sunset_angle - 2 * math.pi
        end
    end

    super.update(self)
end

function AngryBirds:animateBirds()
end

function AngryBirds:drawSplashes()
    -- functions like how it does in the original game.
    if self.splash_timer == nil then
        self.splash_timer = 0
        self.current = 1
        self.splashes = {
            {
                sprite = "minigames/ab/splash_disclaimer",
                splash_time = 2
            },
            {
                sprite = "minigames/ab/splash_logo",
                splash_time = 4 -- it's 1 in the original Angry Birds code, but it felt too short when I ported it over, so it's 4 here lol.
            }
        }
    end

    self.splash_timer = self.splash_timer + DT

    -- skips over a splash screen when clicked or pressed. when there's no more splash to display, it goes to the "MAINMENU" state.
    if Input.pressed("confirm") or love.mouse.isDown(1) then
        self.splash_timer = self.splashes[self.current].splash_time + 1
    end
	
    Draw.draw(Assets.getTexture(self.splashes[self.current].sprite), 0, 0)
    if self.current == 2 then
        Draw.draw(Assets.getTexture("minigames/ab/splash_loading"), SCREEN_WIDTH - 112, SCREEN_HEIGHT - 27)
    end

    -- changes splash screen if showed long enough
    if self.splash_timer > self.splashes[self.current].splash_time then
        self.splash_timer = 0
        self.current = self.current + 1
        if self.current > #self.splashes then
            self:setState("MAINMENU")
        end
    end
end

function AngryBirds:drawMenu()
    love.graphics.setColor(255/255, 238/255, 159/255)
    love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    love.graphics.setColor(COLORS.white)

    love.graphics.setBlendMode("alpha")
    Draw.draw(Assets.getTexture("minigames/ab/menu/bg_menu_top"), 0, 0, 0, 1, 1)

    love.graphics.setBlendMode("add")
    for add_angle = 0, math.pi * 2, 0.6284 do
        local final_angle = self.menu_sunset_angle + add_angle
        if final_angle > math.pi then
            final_angle = final_angle - 2 * math.pi
        end
        if final_angle > -math.pi * 0.5 and final_angle < math.pi * 0.5 then
            Draw.draw(Assets.getTexture("minigames/ab/menu/bg_sunray"), math.floor(SCREEN_WIDTH / 2), math.floor((SCREEN_HEIGHT - 50)), final_angle, 1, 1, 73, 734)
        end
    end
    love.graphics.setBlendMode("alpha")

    Draw.draw(Assets.getTexture("minigames/ab/menu/bg_sun"), math.floor(SCREEN_WIDTH / 2), math.floor((SCREEN_HEIGHT - 50)), 0, 1, 1, 197, 229)
	
    love.graphics.setBlendMode("alpha", "premultiplied")
    Draw.drawWrapped(Assets.getTexture("minigames/ab/menu/bg_hills_5"), true, false, (SCREEN_WIDTH / 2) - (Kristal.getTime() * 10) % (800 - 0.5), math.floor(SCREEN_HEIGHT), 0, 1, 1, 400, 172)
    Draw.drawWrapped(Assets.getTexture("minigames/ab/menu/bg_hills_4"), true, false, (SCREEN_WIDTH / 2) - (Kristal.getTime() * 15) % (800 - 0.5), math.floor(SCREEN_HEIGHT), 0, 1, 1, 400, 158)
    Draw.drawWrapped(Assets.getTexture("minigames/ab/menu/bg_hills_3"), true, false, (SCREEN_WIDTH / 2) - (Kristal.getTime() * 22) % (800 - 0.5), math.floor(SCREEN_HEIGHT), 0, 1, 1, 400, 130)
    Draw.drawWrapped(Assets.getTexture("minigames/ab/menu/bg_hills_2"), true, false, (SCREEN_WIDTH / 2) - (Kristal.getTime() * 33) % (800 - 0.5), math.floor(SCREEN_HEIGHT), 0, 1, 1, 400, 130)
    Draw.drawWrapped(Assets.getTexture("minigames/ab/menu/bg_hills_1"), true, false, (SCREEN_WIDTH / 2) - (Kristal.getTime() * 50) % (800 - 0.5), math.floor(SCREEN_HEIGHT), 0, 1, 1, 400, 79)
    love.graphics.setBlendMode("alpha")
end

function AngryBirds:draw()
    super.draw(self)

    love.graphics.setColor(1, 1, 1, 1)
	
    if self.state == "SPLASHES" then
        self:drawSplashes()
    end
	
    if self.state == "MAINMENU" then
		self:drawMenu()
    end

    if self.state == "LEVELSELECTION" then
        love.graphics.setColor(143/255, 116/255, 185/255)
        love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

        love.graphics.setColor(1, 1, 1)
        Draw.draw(Assets.getTexture("minigames/ab/menu/levelselect/bg"), 0, 0)
        Draw.draw(Assets.getTexture("minigames/ab/menu/levelselect/left"), 0, 293)
        Draw.draw(Assets.getTexture("minigames/ab/menu/levelselect/right"), 427, 286)
    end
end

return AngryBirds