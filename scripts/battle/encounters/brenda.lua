local Brenda, super = Class(Encounter)

function Brenda:init()
    super.init(self)

    self.text = "* "

    self.music = "b_boss"
    self.background = false

    self.brenda = self:addEnemy("brenda")

    self.flee = false
end

function Brenda:beforeStateChange(old, new)
	if new == "ENEMYDIALOGUE" and self.brenda.hits >= 1 then
		local cutscene = Game.battle:startCutscene("brenda.hurt")
		cutscene:after(function()
			Game.battle:setState("DIALOGUEEND")
		end)
	end
    if new == "ATTACKING" and self.brenda.hurt_progress == 5 then
        local cutscene = Game.battle:startCutscene("brenda.defeat_violence")
    end
end

return Brenda