local actor, super = Class("Actor", "brenda_plush")

function actor:init()
    super.init(self)

    self.width = 20
    self.height = 22
	
    self.hitbox = {0, 0, 20, 22}

    self.path = "world/events/pickup_plush"
	
    self.default = "brenda_plush"

    self.animations = {}
end
return actor