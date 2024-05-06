local FireBG, super = Class(Object)
-- Recreated by Bor for Dark Place, included here with their permission

function FireBG:init()
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

    self.siner = 0

    --self.parallax_x = 0
    --self.parallax_y = 0

    local hugelavawave = Sprite("world/hugelavawave", 0, 0)
    hugelavawave:setWrap(true)
    hugelavawave:setScale(2)
    hugelavawave:addFX(ShaderFX(Mod.shaders["wave"], {
        ["wave_sine"] = function() return (Kristal.getTime() * 100) * 1 end,
        ["wave_mag"] = 6,
        ["wave_height"] = 24,
        ["texsize"] = {SCREEN_WIDTH, SCREEN_HEIGHT}
    }))
    self:addChild(hugelavawave)
    hugelavawave.layer = WORLD_LAYERS['bottom']

    

    --[[
    Game.world.timer:tween(3, hugelavawave, {color = {0.35,0.35,0.35}}, 'in-out-sine', function()
        Game.world.timer:tween(3, hugelavawave, {color = {1,1,1}}, 'in-out-sine')
    end)
    Game.world.timer:every(6.5, function()
        Game.world.timer:tween(3, hugelavawave, {color = {0.35,0.35,0.35}}, 'in-out-sine', function()
            Game.world.timer:tween(3, hugelavawave, {color = {1,1,1}}, 'in-out-sine')
		end)
    end)
    ]]

    Game.world.timer:tween(3, hugelavawave, {color = {0.35,0.35,0.35}}, 'in-out-sine', function()
        Game.world.timer:tween(3, hugelavawave, {color = {1,1,1}}, 'in-out-sine')
    end)
    Game.world.timer:every(6.5, function()
        Game.world.timer:tween(3, hugelavawave, {color = {0.35,0.35,0.35}}, 'in-out-sine', function()
            Game.world.timer:tween(3, hugelavawave, {color = {1,1,1}}, 'in-out-sine')
		end)
    end)
end

return FireBG