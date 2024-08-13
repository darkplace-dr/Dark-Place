local Seawalker, super = Class(Encounter)

function Seawalker:init()
    super.init(self)

    self.text = "* Sea walker has      changed forms and      is [color:blue]underwater"

    self.seawalker = self:addEnemy("seawalker", 530, 238)

    self.music = "battle2ut"

    self.background = true

    self.no_end_message = true

    self.timer = 0

    self.mode = "normal"

    self.old_x = self.seawalker.x
    self.old_y = self.seawalker.y

    self.ease = false

    self.ease_timer = 0

    --self.default_xactions = false

    --Game.battle:registerXAction("susie", "Snap")
    --Game.battle:registerXAction("susie", "Supercharge", "Charge\nfaster", 80)
	
	self.flee = false

    self.boss_rush = false
	
    if Game:getFlag("seawalker_defeated") == true then
        self.boss_rush = true
    end
end

function Seawalker:onBattleInit()
    super.onBattleInit(self)
    if self.boss_rush == true then
        Game.battle.dojo_bg = DojoBG({1, 1, 1})
        Game.battle:addChild(Game.battle.dojo_bg)
    end
end

function Seawalker:setMode(mode)
    self.mode = mode
    self.old_x = self.seawalker.x
    self.old_y = self.seawalker.y
    self.ease = true
    self.ease_timer = 0
end

function Seawalker:update()
    super.update(self)

    if not self.seawalker.done_state and (Game.battle:getState() ~= "TRANSITION") then
        self.timer = self.timer + (1 * DTMULT)

        local wanted_x = self.seawalker.old_x
        local wanted_y = self.seawalker.old_y

        if self.mode == "normal" then
            wanted_x = 530 + (math.sin(self.timer * 0.08) * 20)
            wanted_y = 238 + (math.sin(self.timer * 0.04) * 10)
        elseif self.mode == "shoot" then
            wanted_x = 530 - 40 + (math.sin(self.timer * 0.08) * 10)
            wanted_y = 238 - 50 + (math.sin(self.timer * 0.04) * 40)
        end

        if not self.ease then
            self.seawalker.x = wanted_x
            self.seawalker.y = wanted_y
        else
            self.ease_timer = self.ease_timer + (0.05 * DTMULT)
            self.seawalker.x = Ease.outQuad(self.ease_timer, self.old_x, wanted_x - self.old_x, 1)
            self.seawalker.y = Ease.outQuad(self.ease_timer, self.old_y, wanted_y - self.old_y, 1)
            if self.ease_timer >= 1 then
                self.ease = false
            end
        end
    end

    if self.seawalker.done_state and self.seawalker.done_state == "KILLED" then
        for _,enemy in pairs(Game.battle.enemy_world_characters) do
            enemy:remove()
        end
    end
end

function Seawalker:onActionsEnd()
    if (self.seawalker.done_state == "VIOLENCE" or self.seawalker.done_state == "KILLED")
        and not self.death_cine_played then
        self.death_cine_played = true
        Game.battle:startCutscene("starwalkerb.die", nil, self.seawalker)
        return true
    end
end

return Seawalker
