---@class Battle : Battle
---@overload fun(...) : Battle
local Battle, super = Class(Battle)

function Battle:updateIntro()
    self.intro_timer = self.intro_timer + 1 * DTMULT
    if self.intro_timer >= 15 then -- TODO: find out why this is 15 instead of 13
        for _,v in ipairs(self.party) do
            v:setAnimation("battle/idle")
        end
		if Mod.back_attack then
			self:setState("ENEMYDIALOGUE", "INTRO")
		else
			self:setState("ACTIONSELECT", "INTRO")
			self:nextTurn()
		end
    end
end

function Battle:onStateChange(old,new)
	super:onStateChange(self, old, new)
	
	if new == "ENEMYDIALOGUE" then
		local had_started = self.started
        if not self.started then
            self.started = true

            for _,battler in ipairs(self.party) do
                battler:resetSprite()
            end

            if self.encounter.music then
                self.music:play(self.encounter.music)
            end
        end

        self:showUI()
	end
end

return Battle