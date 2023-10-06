local Room1, super = Class(Map)

function Room1:onEnter()
    super.onEnter(self)

	self.ina = Music("inainaina", 0)

    if not self:getFlag("played_intro", false) then
        self:setFlag("played_intro", true)

        if Game:hasPartyMember("YOU") then
            Game.world:startCutscene("room1", "react_to_YOU")
        end
    end
	
	self.month = tonumber(os.date("%m"))
	
    if self.month == 10 then
        Game:setFlag("spookymonth", true)
    else
        Game:setFlag("spookymonth", false)
    end
end

function Room1:onExit()
    super.onExit(self)
	self.ina:remove()
end

return Room1