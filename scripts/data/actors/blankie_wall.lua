local actor, super = Class(Actor, "blankie_wall")

function actor:init()
    super.init(self)

    self.name = "blankie_wall"

    self.width = 20
    self.height = 20

    self.hitbox = {0, 0, 20, 20}

    self.color = {1, 0, 0}

    self.flip = nil

    self.path = "world/cutscenes/blankie_wall"
    self.default = "blankie_wall_day"

    self.voice = nil
    self.portrait_path = nil
    self.portrait_offset = {0, 0}

    self.animations = {
        ["blankie_wall_day"] = {"blankie_wall_day", 1, true},
        ["blankie_wall_night"] = {"blankie_wall_night", 1, true},
    }
	
    self.talk_sprites = {
    }

    self.offsets = {
	}
end

return actor