local actor, super = Class(Actor, "velvet")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "velvet"

    -- Width and height for this actor, used to determine its center
    self.width = 32
    self.height = 52

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {4, 39, 24, 13}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 0, 0}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "world/npcs/velvet"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "phone_idle"

    -- Sound to play when this actor speaks (optional)
    self.voice = "velvet"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/velvet"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {-10, 0}

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {}

    -- Table of sprite animations
    self.animations = {
        ["idle_pissed_no_phone"] = {"idle_pissed_no_phone", 1, true},
        ["idle_smile_no_phone"] = {"idle_smile_no_phone", 1, true},
        ["phone_look_down"] = {"phone_look_down", 1, true},
        ["phone_look_up"] = {"phone_look_up", 1, true},
        ["smile_look_up"] = {"smile_look_up", 1, true},
        ["phone_idle"] = {"phone_idle", 0.4, true},
        ["pissed_talk"] = {"pissed_talk", 0.2, true},
        ["pissed_no_phone"] = {"pissed_no_phone", 0.2, true},
        ["smile_talk"] = {"smile_talk", 0.2, true},
        ["smile_no_phone"] = {"smile_no_phone", 0.2, true},
    }

    self.offsets = {}
end

return actor