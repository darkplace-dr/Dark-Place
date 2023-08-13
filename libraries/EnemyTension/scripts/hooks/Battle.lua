local Battle, super = Class(Battle)

function Battle:init()
    super:init(self)
end


function Battle:postInit(state, encounter)
    super:postInit(self, state, encounter)
    -- If the enemy has a TP value defined, create a bar for it.
    if Game.battle.encounter.enemy_tension then
        self.enemy_tension_bar = EnemyTensionBar(639, 40, true)
        self:addChild(self.enemy_tension_bar)
    end
end

function Battle:showUI()
    if self.enemy_tension_bar then
        self.enemy_tension_bar:show()
    end
    super:showUI(self)
end

function Battle:onStateChange(old,new)
    super:onStateChange(self,old,new)
    if new == "VICTORY" then
        if self.enemy_tension_bar then
            self.enemy_tension_bar.animating_in = false
            self.enemy_tension_bar.shown = false
            self.enemy_tension_bar.physics.speed_x = 10
            self.enemy_tension_bar.physics.friction = -0.4
        end
    end
end


return Battle