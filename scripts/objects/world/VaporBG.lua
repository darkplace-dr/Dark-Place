local VaporBG, super = Class(Object)

function VaporBG:init(do_mountains)
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

    self.parallax_x = 0
    self.parallax_y = 0

    self.backdrop = Sprite("world/maps/vapor/background/backdrop", 0, 0)
    self.backdrop:setScale(2)
    self:addChild(self.backdrop)

    self.mask = Sprite("world/maps/vapor/background/sun_mask", 0, 0)
    self.mask:setScale(2)
	self.mask.visible = false
	self.mask.layer = 10
    self:addChild(self.mask)

    self.sun = Sprite("world/maps/vapor/background/sun", 0, 0)
    self.sun:setScale(2)
	self.sun.alpha = 0.8
    self.sun:addFX(ShaderFX(Mod.shaders["wave"], {
        ["wave_sine"] = function() return Kristal.getTime() * 100 end,
        ["wave_mag"] = 4,
        ["wave_height"] = 16,
        ["texsize"] = {SCREEN_WIDTH, SCREEN_HEIGHT}
    }))
	self.sun:addFX(MaskFX(self.mask))
    self:addChild(self.sun)

    self.sun_overlay = Sprite("world/maps/vapor/background/sun", 0, 0)
    self.sun_overlay:setScale(2)
	self.sun_overlay:addFX(MaskFX(self.mask))
    self:addChild(self.sun_overlay)

    if do_mountains or do_mountains == nil then
        self.mountains = Sprite("world/maps/vapor/background/mountains", 0, 105)
        self.mountains:setScale(1)
        self.mountains:setLayer(self.layer + 0.2)
        self.mountains.wrap_texture_x = true
        self.mountains.parallax_x = 0.1
        self.mountains.parallax_y = 0.1
        Game.world:addChild(self.mountains)
    end
end

function VaporBG:onRemove(parent)
    if self.mountains then
        self.mountains:remove()
    end
end

return VaporBG