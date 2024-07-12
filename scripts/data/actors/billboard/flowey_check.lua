local actor, super = Class(Actor)

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Flowey (Floweycheck)"

    -- Width and height for this actor, used to determine its center
    self.width = 42
    self.height = 44

    -- Path to this actor's sprites (defaults to "")
    self.path = "world/cutscenes/flowey_check/flowey"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "nice"

    -- Sound to play when this actor speaks (optional)
    self.voice = "flowey1"

    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {0, 0}

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of sprite animations
    self.animations = {
        ["laugh"] = {"laugh", 0.05, true},
        ["rise"] = {"rise", 0.05, next="nice"},
        ["rise_plain"] = {"rise_plain", 0.05, next="plain"},
        ["rise_reverse"] = {"rise_reverse", 0.05, false}
    }

    -- Tables of sprites to change into in mirrors
    self.talk_sprites = {
        ["plain"] = 0.15,
        ["nice"] = 0.15,
        ["niceside"] = 0.15,
        ["nicesideum"] = 0.15,
        ["evil"] = 0.15,
        ["grin"] = 0.15,
        ["sassy"] = 0.15,
        ["pissed"] = 0.15,
        ["cut"] = 0.15,
	}

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        ["rise"] = {0, -4},
        ["rise_plain"] = {0, -4},
        ["rise_reverse"] = {0, -4},
    }
end

return actor