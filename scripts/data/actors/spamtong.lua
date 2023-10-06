local actor, super = Class(Actor, "spamtong")

function actor:init()
    super:init(self)
    print("oh")

    -- Display name (optional)
    self.name = "Spamton"

    -- Width and height for this actor, used to determine its center
    self.width = 25
    self.height = 34

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {0, 25, 25, 14}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 0, 0}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "world/npcs/spamtong"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "idle"

    -- Sound to play when this actor speaks (optional)
    self.voice = "spamton"
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
        ["idle"]={"idle", 1, true},
        ["hurt"]={"hurt", 1, true},
        ["laugh_left"]={"laugh_left", 0.3, true},
        ["laugh_right"]={"laugh_right", 0.3, true},
        ["laugh_glitch"]={"laugh_glitch", 0.3, true},
        ["laugh_large"]={"laugh_left", 0.3, true},
        ["grow"]={"grow", 1/12, false},
        ["walk"]={"walk", 0.1, true}
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        ["dark"]={0, -2},
        ["landed"]={-3, -5},
        ["jump"]={-3, 0},
        ["hands_look_down"]={0, -4},
        ["hands_look_down_dark"]={0, -4},
        ["laugh_left"]={0, -2},
        ["laugh_right"]={-3, -2},
        ["grab_dark"]={0, -2},
        ["laugh_glitch"]={-7, -23},
        ["arms_up_laugh"]={0, 1},
        ["up_look_down"]={0, -19},
        ["up_punch"]={3, -19},
        ["laugh_large"]={0, -12},
        ["grow"]={-17, -35},

        ["thisisfuckinghorrible_1"] = {-21, -80},
        ["thisisfuckinghorrible_2"] = {-21, -80},
        ["thisisfuckinghorrible_3"] = {-21, -80}
    }

    self.taunt_sprites = {"grow_5", "jump", "laugh_glitch_16", "myfirstartdontsteal", "up_look_down"}
end

return actor