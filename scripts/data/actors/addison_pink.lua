local actor, super = Class(Actor, "addisonpink")

function actor:init()
    super.init(self)

    self.name = "Pink Addison"

    self.width = 39
    self.height = 53

    self.hitbox = {8, 43, 24, 11}

    self.color = {0, 0, 0}

    self.flip = nil

    self.path = "world/npcs/addisons/pink"
    self.default = "stand"

    self.voice = nil

    self.portrait_path = nil
    self.portrait_offset = {-22, -6}

    self.animations = {
        ["idle"] = {"idle", 0.2, true},
    }
	
    self.talk_sprites = {
    }

    self.offsets = {
	}
end

return actor