local actor, super = Class("kris", "flipside/kris")

function actor:init()
    super.init(self)

    self.width = 50
    self.height = 73
	
    self.hitbox = {0, 0, 50, 73}

    self.path = "party/kris/flipside"
	
    self.default = "idle"

    self.animations = {
        -- Movement animations
        ["idle"] = {"idle", 0.3, true},
	}
end

function actor:onWorldUpdate(chara)
    super.super.onWorldUpdate(self)
	
    chara:setScale(1.2)
end

function actor:onSetSprite(sprite, texture, callback)
    super.super.onSetSprite(self, sprite, texture, callback)
end

return actor