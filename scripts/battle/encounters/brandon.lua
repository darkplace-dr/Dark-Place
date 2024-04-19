local Brandon, super = Class(Encounter)

function Brandon:init()
    super.init(self)

    self.text = "* "

    self.music = "b_boss"
    self.background = false

    self.brandon = self:addEnemy("brandon")

    self.flee = false
end

function Brandon:beforeStateChange(old, new)
	if new == "ENEMYDIALOGUE" and self.brandon.hits >= 1 then
		local cutscene = Game.battle:startCutscene("brandon.hurt")
		cutscene:after(function()
			Game.battle:setState("DIALOGUEEND")
		end)
	end
    if new == "ATTACKING" and self.brandon.hurt_progress == 5 then
        local cutscene = Game.battle:startCutscene("brandon.defeat_violence")
    end
end

return Brandon