local Ceroba, super = Class(LightEncounter)

function Ceroba:init()
    super:init(self)

    self.text = "* The atmosphere chills with\nire."

    self.music = "undertale_yellow/trial_by_fury"

    self:addEnemy("ceroba_geno")

    self.background = true

    self.offset = 0

    self.can_flee = false

    self.intro_finished = false

end

function Ceroba:drawBackground()
    for i = 1, 4 do
        Draw.setColor(73/255, 24/255, 31/255)
        love.graphics.rectangle("fill", 0, 230, 640, 106)
    end
    for i = 2, 4 do
        Draw.setColor(157/255, 23/255, 50/255)
        love.graphics.rectangle("fill", 0, 242, 640, 88)
    end
    for i = 3, 4 do
        Draw.setColor(216/255, 31/255, 68/255)
        love.graphics.rectangle("fill", 0, 268, 640, 56)
    end
    for i = 4, 4 do
        Draw.setColor(228/255, 69/255, 101/255)
        love.graphics.rectangle("fill", 0, 310, 640, 14)
    end
end

function Ceroba:beforeStateChange(old, new)
    local ceroba = Game.battle:getEnemyBattler("ceroba_geno")
    if old == "TRANSITION" and new ~= "TRANSITION" then
        ceroba:toggleOverlay(true)
        ceroba:getActiveSprite():setSprite("lightbattle/animations/intro_1")
        Game.battle:setState("ENEMYDIALOGUE")
        Game.battle.music:play(Game.battle.encounter.music)
    end
    if old == "DEFENDINGEND" and new ~= "DEFENDINGEND" and self.intro_finished == false then
        self.intro_finished = true
        Game.battle:setState("NONE")
        Game.battle:startCutscene("ceroba_geno", "intro")
    end
    if old == "ENEMYDIALOGUE" and new ~= "ENEMYDIALOGUE" and ceroba.health <= 500 and ceroba.phase == 1 then
        ceroba.phase = 2
        Game.battle:setState("NONE")
        Game.battle:startCutscene("ceroba_geno", "phase_switch")
    end
end

return Ceroba