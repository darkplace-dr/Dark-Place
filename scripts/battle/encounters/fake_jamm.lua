local Dummy, super = Class(Encounter)

function Dummy:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Battle against a faker."

    -- Battle music ("battle" is rude buster)
    self.music = "battle"
    -- Enables the purple grid battle background
    self.background = false

    -- Add the dummy enemy to the encounter
    self:addEnemy("fake_jamm", 520, 240)

    --- Uncomment this line to add another!
    --self:addEnemy("dummy")

	self.flee = false
end

function Dummy:beforeStateChange(old, new)
	if new == "ENEMYDIALOGUE" then
		local cutscene = Game.battle:startCutscene("fake_jamm.talk")
		cutscene:after(function()
			if Game.battle.turn_count == 3 then
				Game.battle:setState("TRANSITIONOUT")
			else
				Game.battle:setState("DIALOGUEEND")
			end
		end)
	end
end

function Dummy:getPartyPosition(index)
    local x, y = 0, 0
    x = 200 - (20 * (index - 1))
    y = 160 + (50 * (index - 1))
    return x, y
end

return Dummy
