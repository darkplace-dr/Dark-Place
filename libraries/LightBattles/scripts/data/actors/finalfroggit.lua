local actor, super = Class(Actor, "finalfroggit")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Final Froggit"
	
    self.width = 49
    self.height = 62

    -- Width and height for this actor, used to determine its center
    self.light_battle_width = 49
    self.light_battle_height = 62

    self.hitbox = {0, 0, 16, 16}

    self.use_light_battler_sprite = false

    self.path = "enemies/finalfroggit"
    self.default = nil

    self.animations = {
        ["lightbattle_hurt"] = {"lightbattle/hurt", 1, true},
        ["defeat"] = {"lightbattle/hurt", 1, true}
    }
end

function actor:createSprite()
	return FinalFroggitActor(self)
end

return actor