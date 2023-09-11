local actor, super = Class("susie", "flipside/susie")

function actor:init()
    super.init(self)

    self.width = 57
    self.height = 83
	
    self.hitbox = {0, 0, 57, 83}

    self.path = "party/susie/flipside"
	
    self.default = "idle"

    self.animations = {
        -- Movement animations
        ["idle"] = {"idle", 0.3, true},
	}
end

function actor:onWorldUpdate(chara)
    chara:setScale(1.2)
end

return actor