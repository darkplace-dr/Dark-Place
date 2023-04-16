local VaporBG, super = Class(Object)

function VaporBG:init()
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

    self.parallax_x = 0
    self.parallax_y = 0

    local backdrop = Sprite("objects/vaporbg/backdrop", 0, 0)
    backdrop:setScale(2)
    self:addChild(backdrop)

    local mask = Sprite("objects/vaporbg/sun_mask", 0, 0)
    mask:setScale(2)
	mask.visible = false
    self:addChild(mask)
	mask.layer = 10

    local sun = Sprite("objects/vaporbg/sun", 0, 0)
    sun:setScale(2)
	sun.alpha = 0.8
    sun:addFX(ShaderFX(Mod.shaders["wave"], {
        ["wave_sine"] = function() return Kristal.getTime() * 100 end,
        ["wave_mag"] = 4,
        ["wave_height"] = 16,
        ["texsize"] = {SCREEN_WIDTH, SCREEN_HEIGHT}
    }))
	sun:addFX(MaskFX(mask))
    self:addChild(sun)

    local sun_overlay = Sprite("objects/vaporbg/sun", 0, 0)
    sun_overlay:setScale(2)
	sun_overlay:addFX(MaskFX(mask))
    self:addChild(sun_overlay)
end

return VaporBG