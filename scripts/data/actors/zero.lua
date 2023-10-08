local actor, super = Class(Actor, "zero")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Zero"

    -- Width and height for this actor, used to determine its center
    self.width = 39
    self.height = 37

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {9, 25, 24, 11}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {0, 1, 1}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "battle/enemies/zero"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "idle"

    -- Sound to play when this actor speaks (optional)
    self.voice = nil
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = nil

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {}

    -- Table of sprite animations
    self.animations = {
        -- Looping animation with 0.25 seconds between each frame
        -- (even though there's only 1 idle frame)
        ["idle"] = {"idle", 0.1, true},
        ["run"] = {"run", 1/15, true},
        ["attack"] = {"attack", 1/15, false, next="idle"},
        ["headphones_in"] = {"headphones_in", 0.1, false, next="headphones_still"},
        ["headphones_still"] = {"headphones_still", 0, false},
        ["headphones_end"] = {"headphones_end", 0.1, false, next="idle"},
        ["struggle"] = {"struggle", 1/15, true},
        ["hurt_fly"] = {"hurt_fly", 1/15, false, next="hurt_fly_loop"},
        ["hurt_fly_loop"] = {"hurt_fly_loop", 1/15, true},
        ["hurt_ground"] = {"hurt_ground", 1/15, false},
        ["hurt_recover"] = {"hurt_recover", 1/15, false, next="idle"},

        -- I know, this kinda sucks. I don't really care, though.
        ["hurtlong"] = {"hurt_ground", 1/15, false, next="hurt_recover"},


        ["KO"] = {"hurt_ground", 1/5, false, next="downed"},
        ["downed"] = {"downed", 1/10, true},
        ["getup"] = {"getup", 1/10, false},

        ["threaten"] = {"threaten", 1/15, false},

        ["drawsword/normal"] = {"drawsword/normal", 1/30, false},
        ["drawsword/blue"] = {"drawsword/blue", 1/30, false},
        ["drawsword/orange"] = {"drawsword/orange", 1/30, false},
        ["drawsword/finish"] = {"drawsword/finish", 1/30, false},
        ["drawsword/sheath"] = {"drawsword/sheath", 1/15, false, next="idle"},
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        -- Since the width and height is the idle sprite size, the offset is 0,0
        ["idle"] = {0, 0},
        ["attack"] = {-15, 0},
        ["headphones_in"] = {0, -4},
        ["headphones_still"] = {0, -4},
        ["headphones_end"] = {0, -4},
        ["struggle"] = {-25, 0},
        ["hurt_recover"] = {-10, -10},
        ["downed"] = {0, 15},
        ["getup"] = {0, 5},
        ["threaten"] = {-30, -5},

        ["drawsword/normal"] = {-40, -11},
        ["drawsword/blue"] = {-40, -11},
        ["drawsword/orange"] = {-40, -11},
        ["drawsword/finish"] = {-40, -11},
        ["drawsword/sheath"] = {-40, -11},
    }
end

return actor