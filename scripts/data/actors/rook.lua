local actor, super = Class(Actor, "rook")

function actor:init()
    super:init(self)

    self.name = "Rook"

    self.width = 42
    self.height = 64

    self.path = "world/npcs/rook"
    self.default = "idle"
	
    self.portrait_path = "face/rook"
    self.portrait_offset = {-22, -17}

	self.voice = "rook"
	
    self.animations = {
        ["idle"] = {"idle", 1, true},
        ["laugh"] = {"laugh", 0.15, true},
    }
	self.offsets = {
        ["laugh"] = {0, -1},
    }
end

return actor