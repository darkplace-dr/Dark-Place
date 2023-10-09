local actor, super = Class(Actor, "neo_ponman")

function actor:init()
    super.init(self)

    self.name = "NEO Ponman"

    self.width = 29
    self.height = 44

    self.hitbox = {0, 26, 29, 13}

    self.color = {1, 0, 0}

    self.path = "battle/enemies/neo_ponman"
    self.default = "idle"

    self.animations = {
        ["idle"] = {"idle", 0, false},
    }

    self.offsets = {
        ["idle"] = {0, 0},
    }
end

function actor:createSprite()
	return NEOPonmanActor(self)
end

return actor