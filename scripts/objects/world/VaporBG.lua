local VaporBG, super = Class(Object)

function VaporBG:init(do_mountains)
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

    self.parallax_x = 0
    self.parallax_y = 0

    self.backdrop = Sprite("world/maps/vapor/background/backdrop", 0, 0)
    self.backdrop:setScale(2)
    self:addChild(self.backdrop)

    self.mask = Sprite("world/maps/vapor/background/sun_mask", 232, 74)
    self.mask:play(0.1, true)
    self.mask:setScale(2)
	self.mask.visible = false
	self.mask.layer = 10
    self:addChild(self.mask)

    self.sun = Sprite("world/maps/vapor/background/sun", 232, 74)
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

    self.sun_overlay = Sprite("world/maps/vapor/background/sun", 232, 74)
    self.sun_overlay:setScale(2)
	self.sun_overlay:addFX(MaskFX(self.mask))
    self:addChild(self.sun_overlay)

    if do_mountains or do_mountains == nil then
        self.mountains = Sprite("world/maps/vapor/background/mountains", 0, 75)
        self.mountains:setScale(1)
        self.mountains:setLayer(self.layer + 0.11)
        self.mountains.wrap_texture_x = true
        self.mountains:setParallax(0.1, 0.1)
        Game.world:addChild(self.mountains)
    end
	
    self.city_bg = Sprite("world/maps/vapor/background/city_bg", 0, 305)
    self.city_bg:setScale(2)
    self.city_bg:setLayer(self.layer + 0.12)
    self.city_bg.wrap_texture_x = true
    self.city_bg:setParallax(0.15, 0.15)
    Game.world:addChild(self.city_bg)
	
    self.city_fg = Sprite("world/maps/vapor/background/city_fg", 0, 389)
    self.city_fg:setScale(2)
    self.city_fg:setLayer(self.layer + 0.13)
    self.city_fg.wrap_texture_x = true
    self.city_fg:setParallax(0.25, 0.25)
    Game.world:addChild(self.city_fg)
	
    self.dark = Rectangle(-10, 520, SCREEN_WIDTH + 10, SCREEN_HEIGHT)
    self.dark:setColor(0, 0, 0)
    self.dark:setLayer(self.layer + 0.14)
    self.dark:setParallax(0, 0.25)
    Game.world:addChild(self.dark)
end

function VaporBG:onRemove(parent)
    if self.mountains then
        self.mountains:remove()
    end
end

return VaporBG