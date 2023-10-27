local Dummy, super = Class(Encounter)

function Dummy:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* It's...[wait:15] you?"

    -- Battle music ("battle" is rude buster)
    self.music = "mus_unknown"
    -- Enables the purple grid battle background
    self.background = false
    --self.hide_world = false

    self.timer = Timer()
    Game.battle:addChild(self.timer)

    self.flee_chance = 0
    
    -- Custom BG.
    self.bg = Sprite("battle/MirrorBG_Fixed")
    self.bg.layer = BATTLE_LAYERS["below_battlers"]
    self.bg:setScale(1,1)
    self.bg:setColor(0.2,0.2,0.5)
    self.bg.alpha = 0
    Game.battle:addChild(self.bg)
    self.bg_wave = ShaderFX(Mod.wave_shader, {
        ["wave_sine"] = function() return Kristal.getTime() * 100 end,
        ["wave_mag"] = 20,
        ["wave_height"] = 10,
        ["texsize"] = {SCREEN_WIDTH, SCREEN_HEIGHT}
    })
    self.bg:addFX(self.bg_wave, "funky_mode")
    self.fadein = false
    self.darkbg = Sprite("battle/MirrorBG_Fixed")
    self.darkbg.alpha = 0
    self.darkbg.color = {0,0,0}
    self.darkbg.layer = BATTLE_LAYERS["bottom"]
    Game.battle:addChild(self.darkbg)


    self.afterimage_count = 0
    self.transition_timer = 10
    self.afterimage_delay = 2

    -- Turn counter for how long pacify should last.
    self.pacified = 0

    -- The enemy's TP
    self.enemy_tension = 0

    -- Add an enemy for each party member
    self.mirror_battlers = {}
    for i, battler in ipairs(Game.party) do
        --if not love.filesystem.getInfo("battle/enemies/mirrored/"..battler.id:lower()) then
        --    self.mirror_battlers[i] = self:addEnemy("mirrored/dummy")
        --else
            self.mirror_battlers[i] = self:addEnemy("mirrored/"..battler.id:lower())
        --end
    end

    --[[
    self:addEnemy("mirrored/kris")
    self:addEnemy("mirrored/noelle")
    self:addEnemy("mirrored/berdly")
    self:addEnemy("mirrored/ostarwalker")
    self:addEnemy("mirrored/robo_susie")
    self:addEnemy("mirrored/noyno")
    self:addEnemy("mirrored/pauling")
    self:addEnemy("mirrored/eusei")
    self:addEnemy("mirrored/frisk2")
    self:addEnemy("mirrored/dess")
    self:addEnemy("mirrored/alseri")
    self:addEnemy("mirrored/brandon")
    self:addEnemy("mirrored/jamm")
    self:addEnemy("mirrored/bor")
    self:addEnemy("mirrored/dumbie")
    self:addEnemy("mirrored/iphone")
    --]]



end

function Dummy:update()
    super:update(self)
    if self.fadein == true and self.bg then
        self.bg.alpha = Utils.approach(self.bg.alpha, 1, DT/8)
    end
    if self.darkbg.alpha ~= 1 and not fadein then
        self.darkbg.alpha = Utils.approach(self.darkbg.alpha, 1, 0.05)
    end
end

function Dummy:beforeStateChange(old, new)
    if new == "ENEMYDIALOGUE" and Game.battle.state_reason == "FLEE" then
        self.no_escape = true
        Game.battle:startCutscene("mirrormatch.no_escape")
    end
    
end

function Dummy:getEncounterText()
    if self.no_escape then
        self.no_escape = false
        self.flee = false
        return "* Who are you running from?"
    end
    return super:getEncounterText(self)
end

function Dummy:onStateChange(old, new)
    Log:print(new)
    if new == "DEFENDING" and self.no_escape then
        Game.battle.encounter:onWavesDone()
    end
    if old == "INTRO" and new == "ACTIONSELECT" then
        self.fadein = true
        self.introtimer = self.timer:after(19.64, function () -- Exact length of the BGM's intro
            self.timer:tween(1, self.bg, {color = {1,1,1}})
        end)
    end
end

function Dummy:onBattleEnd()
    self.bg:fadeOutAndRemove(0.5)
end

return Dummy