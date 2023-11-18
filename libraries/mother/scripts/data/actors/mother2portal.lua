local actor, super = Class(Actor, "mother2portal")

function actor:onSpriteInit(sprite)
    sprite:addFX(ShaderFX(Mod.wave_shader, {
        ["wave_sine"] = function () return Kristal.getTime() * 100 end,
        ["wave_mag"] = 4,
        ["wave_height"] = 4,
        ["texsize"] = { SCREEN_WIDTH, SCREEN_HEIGHT }
    }), "funky_mode")
end

function actor:init(chara)
    super.init(self)
    self.name = "mother2portal"
    self.width = 60
    self.height = 60
    self.color = {1, 1, 1}
    self.path = "portal"
    self.default = "mother_2_gate"
    self.voice = nil

    self.portrait_path = nil

    self.portrait_offset = nil

    self.can_blush = false

    self.animations = {
        ["mother_2_gate"] = {"mother_2_gate"},
    }

    self.offsets = {
    }



end


return actor