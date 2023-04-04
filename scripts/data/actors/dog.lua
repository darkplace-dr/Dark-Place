local actor, super = Class(Actor, "dog")

function actor:init()
    super.init(self)
	
    self.name = "Dog"

    self.width = 16
    self.height = 16

    self.hitbox = {2, 2, 13, 15}

    self.flip = nil

    self.path = "world/npcs/dog"
    self.default = "idle"

    self.animations = {
        ["idle"] = {"idle", 0, true},
		["holdphone"] = {"holdphone", 0, true},
		["talkphone"] = {"talkphone", 0, true}
    }

    self.offsets = {
        ["idle"] = {0, 0},
		["holdphone"] = {0, 0},
		["talkphone"] = {0, 0},
    }
end

return actor