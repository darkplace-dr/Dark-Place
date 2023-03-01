local WhiteSpace, super = Class(Map)

function WhiteSpace:onLoad()
    super:load(self)
end

function WhiteSpace:update()
    if Game.world.player.x <= 360 then
        Game.world.player.x = Game.world.player.x + 5060
        Game.world.followers = {}
    elseif Game.world.player.x >= 5420 then
        Game.world.player.x = Game.world.player.x - 5060
        Game.world.followers = {}
    end
    if Game.world.player.y <= 280 then
        Game.world.player.y = Game.world.player.y + 3780
        Game.world.followers = {}
    elseif Game.world.player.y >= 4060 then
        Game.world.player.y = Game.world.player.y - 3780
        Game.world.followers = {}
	end
    super:update(self)
end

return WhiteSpace