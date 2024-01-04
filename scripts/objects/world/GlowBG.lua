local GlowBG, super = Class(Object)

function GlowBG:init()
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

    self.siner = 0

    self.parallax_x = 0
    self.parallax_y = 0

    local bg = Rectangle(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)
    self:addChild(bg)
    bg.layer = 10

    Game.world.timer:tween(1, bg, {color = {244/255,254/255,190/255}}, 'in-out-sine', function()
        Game.world.timer:tween(1, bg, {color = {1,1,1}}, 'in-out-sine')
    end)
    Game.world.timer:every(2, function()
        Game.world.timer:tween(1, bg, {color = {244/255,254/255,190/255}}, 'in-out-sine', function()
            Game.world.timer:tween(1, bg, {color = {1,1,1}}, 'in-out-sine')
		end)
    end)
end

return GlowBG