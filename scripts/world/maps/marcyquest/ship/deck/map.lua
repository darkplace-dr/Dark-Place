local Ship, super = Class(Map)

function Ship:onEnter()
	if not Game:getFlag("marcy_with_party") then
		for k,v in ipairs(Game.world.followers) do
			v:remove()
		end
		Game.world.player:setActor("marcy")
		Game.world.disable_dark_menu = true
	end
	if not Game:getFlag("marcyquest_party_1") then
		if #Game.party >= 2 then
			local party1 = NPC(Game.party[2]:getActor().id, 1640, 640, {cutscene="marcyquest.party_1", facing="left", turn=true})
			Game.world:spawnObject(party1)
			party1.partyslot = 2
			if #Game.party >= 3 then
				local party2 = NPC(Game.party[3]:getActor().id, 1802, 500, {cutscene="marcyquest.party_1", facing="up", turn=true})
				Game.world:spawnObject(party2)
				party2.partyslot = 3
				if #Game.party >= 4 then
					local party3 = NPC(Game.party[4]:getActor().id, 1360, 940, {cutscene="marcyquest.party_1", facing="down", turn=true})
					Game.world:spawnObject(party3)
					party3.partyslot = 4
				end
			end
		end
	end
end

return Ship