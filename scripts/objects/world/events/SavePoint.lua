--this hook is in the objects because objects are loaded after hooks
--so the hook from Ultimate RIBBIT can load without this messing it up
local SavePoint, super = Class("Savepoint", true)

function SavePoint:init(x, y, properties)
	super:init(self, x, y, properties)

	self.override_power = properties["override_power"]
end

function SavePoint:onInteract()
	if Game:getFlag("weird") and (self.text and #self.text > 0) and not self.override_power then
		local party_text = ""
		for i,member in ipairs(Game.party) do
			party_text = party_text .. member.name
			if i < #Game.party-1 then
				party_text = party_text ..",[wait:2] "
			elseif i == #Game.party-1 then
				party_text = party_text .." and "
			end
		end
		local verb = #Game.party == 1 and "is" or "are"
		self.text = {"* " .. party_text .. " "..verb.." filled with power."}
	end
	super:onInteract(self)
end

return SavePoint