---@class Battle
local Battle, super = Class("Battle", true)

function Battle:init()
	super.init(self)

	self.super_timer = 0

	self.superpower = false
end

-- FIXME: \/ copied from libraries/EnemyTension/scripts/hooks/Battle.lua

function Battle:postInit(state, encounter)
    super.postInit(self, state, encounter)

    -- If the enemy has a TP value defined, create a bar for it.
    if self.encounter.enemy_tension then
        self.enemy_tension_bar = EnemyTensionBar(639, 40, true)
        self:addChild(self.enemy_tension_bar)
    end
end

function Battle:showUI()
    super.showUI(self)
    if self.enemy_tension_bar then
        self.enemy_tension_bar:show()
    end
end

function Battle:onStateChange(old,new)
    super.onStateChange(self,old,new)

    if new == "VICTORY" then
        if self.enemy_tension_bar then
            self.enemy_tension_bar.animating_in = false
            self.enemy_tension_bar.shown = false
            self.enemy_tension_bar.physics.speed_x = 10
            self.enemy_tension_bar.physics.friction = -0.4
        end
    end
end

---Adds TP to the enemy's TP bar. Doesn't work if no enemy TP bar exists.
---@param tp integer Amount to give.
function Battle:giveEnemyTension(tp)
    self.encounter.enemy_tension = self.encounter.enemy_tension + tp
end

---Removes TP from the enemy's TP bar. Doesn't work if no enemy TP bar exists.
---@param tp integer Amount to remove.
function Battle:removeEnemyTension(tp)
    if self.encounter.enemy_tension - tp < 0 then
        self.encounter.enemy_tension = 0
    else
        self.encounter.enemy_tension = self.encounter.enemy_tension - tp
    end
end

---Returns current enemy TP value. Doesn't work if no enemy TP bar exists.
---@return integer tp
function Battle:getEnemyTension()
    return self.encounter.enemy_tension
end

---Sets enemy TP to the given value. Doesn't work if no enemy TP bar exists.
---@param tp integer Amount to set.
function Battle:setEnemyTension(tp)
    self.encounter.enemy_tension = tp
end

-- FIXME: /\ copied from libraries/EnemyTension/scripts/hooks/Battle.lua

function Battle:update()
	super.update(self)

	if self.superpower then
		if (self.super_timer - (DT * 30))%10 > self.super_timer%10 then
			Game:removeTension(1)

			if Game.tension <= 0 then
				self.superpower = false
				self.music:play(self.encounter.music)
			end
		end

		self.super_timer = self.super_timer + DT * 30
	end
end

return Battle