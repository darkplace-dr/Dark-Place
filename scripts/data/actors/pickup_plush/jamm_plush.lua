local actor, super = Class("Actor", "jamm_plush")

function actor:init()
    super.init(self)

    self.width = 20
    self.height = 22
	
    self.hitbox = {0, 0, 20, 22}

    self.path = "world/events/pickup_plush"

    self.default = "jamm_plush"
	
    if Game:getFlag("dungeonkiller") and Game:getFlag("jamm_closure") then
        self.default = "jamm_plush_nowife"
    end

    self.animations = {}
end
return actor