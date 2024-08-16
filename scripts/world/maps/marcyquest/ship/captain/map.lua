local Ship, super = Class(Map)

function Ship:onEnter()
	if not Game:getFlag("marcy_with_party") then
		for k,v in ipairs(Game.world.followers) do
			v:remove()
		end
		Game.world.player:setActor("marcy")
		Game.world.disable_dark_menu = true
	end
end

function Ship:onExit()
	Game.world.disable_dark_menu = false
end

return Ship