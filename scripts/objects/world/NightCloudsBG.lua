local GoldBG, super = Class(Object)

function GoldBG:init()
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

    self.parallax_x = 0
    self.parallax_y = 0

    local backdrop = Sprite("world/maps/_gildedgrove/gold_parallax_clouds_dark", 0, 0)
    backdrop:setWrap(true)
    backdrop:setScale(2)
    self:addChild(backdrop)

    local clouds = Sprite("world/maps/_gildedgrove/cloud_big_dark", 0, 0)
    clouds:setWrap(true)
    clouds.physics.speed_x = 0.2
    clouds:setScale(2)
    clouds.physics.speed_y = 0.1
    clouds:addFX(ShaderFX(Mod.shaders["wave"], {
        ["wave_sine"] = function() return Kristal.getTime() * 100 end,
        ["wave_mag"] = 2,
        ["wave_height"] = 6,
        ["texsize"] = {SCREEN_WIDTH, SCREEN_HEIGHT}
    }))
    self:addChild(clouds)

    clouds.layer = 10
end

return GoldBG