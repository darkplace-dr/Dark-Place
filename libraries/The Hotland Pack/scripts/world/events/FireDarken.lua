local Fire, super = Class(Event, "firedarken")
-- Recreated by Bor for Dark Place, included here with their permission

function Fire:init(data)
    super:init(self, data.x, data.y, data.width, data.height)

    data.properties = data.properties or {}

    local darkness = Rectangle(0,0,data.width,data.height)
    darkness.color = {0,0,0}
    darkness.alpha = 0
    self:addChild(darkness)
    darkness.layer = 10

    local darkness2 = Rectangle(0,data.height/3.5,data.width,data.height/1.4)
    darkness2.color = {0,0,0}
    darkness2.alpha = 0
    self:addChild(darkness2)
    darkness2.layer = 12

    local darkness3 = Rectangle(0,data.height/2,data.width,data.height/2)
    darkness3.color = {0,0,0}
    darkness3.alpha = 0
    self:addChild(darkness3)
    darkness3.layer = 14

    Game.world.timer:tween(3, darkness, {alpha = 0.35}, 'in-out-sine', function()
        Game.world.timer:tween(3, darkness, {alpha = 0}, 'in-out-sine')
    end)
    Game.world.timer:tween(3, darkness2, {alpha = 0.6}, 'in-out-sine', function()
        Game.world.timer:tween(3, darkness2, {alpha = 0}, 'in-out-sine')
    end)
    Game.world.timer:tween(3, darkness3, {alpha = 0.8}, 'in-out-sine', function()
        Game.world.timer:tween(3, darkness3, {alpha = 0}, 'in-out-sine')
    end)
    Game.world.timer:every(6.5, function()
        Game.world.timer:tween(3, darkness, {alpha = 0.35}, 'in-out-sine', function()
            Game.world.timer:tween(3, darkness, {alpha = 0}, 'in-out-sine')
		end)
        Game.world.timer:tween(3, darkness2, {alpha = 0.6}, 'in-out-sine', function()
            Game.world.timer:tween(3, darkness2, {alpha = 0}, 'in-out-sine')
        end)
        Game.world.timer:tween(3, darkness3, {alpha = 0.8}, 'in-out-sine', function()
            Game.world.timer:tween(3, darkness3, {alpha = 0}, 'in-out-sine')
        end)
    end)
end

return Fire