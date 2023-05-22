local BlackSpace, super = Class(Map)

function BlackSpace:onLoad()
    super.load(self)
    Game.isOmori = true
end

function BlackSpace:onEnter()
    Game.isOmori = true
end

function BlackSpace:update()
    if Game.world.player.x <= 360 then
        Game.world.player.x = Game.world.player.x + 5060
        for _,follower in ipairs(Game.world.followers) do
            follower.x = follower.x + 5060
            for _,point in ipairs(follower.history) do
                point.x = point.x + 5060
            end
        end
    elseif Game.world.player.x >= 5420 then
        Game.world.player.x = Game.world.player.x - 5060
        for _,follower in ipairs(Game.world.followers) do
            follower.x = follower.x - 5060
            for _,point in ipairs(follower.history) do
                point.x = point.x - 5060
            end
        end
    end
    if Game.world.player.y <= 280 then
        Game.world.player.y = Game.world.player.y + 3780
        for _,follower in ipairs(Game.world.followers) do
            follower.y = follower.y + 3780
            for _,point in ipairs(follower.history) do
                point.y = point.y + 3780
            end
        end
    elseif Game.world.player.y >= 4060 then
        Game.world.player.y = Game.world.player.y - 3780
        for _,follower in ipairs(Game.world.followers) do
            follower.y = follower.y - 3780
            for _,point in ipairs(follower.history) do
                point.y = point.y - 3780
            end
        end
    end
    super.update(self)
end

function BlackSpace:onExit()
    Game.isOmori = false
end

return BlackSpace
