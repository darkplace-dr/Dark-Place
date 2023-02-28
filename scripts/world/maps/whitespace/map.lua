local WhiteSpace, super = Class(Map)

function WhiteSpace:onLoad()
    super:load(self)
end

function WhiteSpace:update()
    if Game.world.player.x <= 320 then
        Game.world.player.x = Game.world.player.x + 2560
        Game.world.followers = {}
    elseif Game.world.player.x >= 2880 then
        Game.world.player.x = Game.world.player.x - 2560
        Game.world.followers = {}
    end
    super:update(self)
end

return WhiteSpace