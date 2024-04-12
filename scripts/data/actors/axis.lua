local actor, super = Class(Actor, "axis")

function actor:init()
    super.init(self)

    self.name = "Axis"

    self.width = 35
    self.height = 45

    self.hitbox = {0, 25, 19, 14}

    self.color = {1, 0, 0}

    self.flip = nil

    self.path = "world/npcs/axis"
    self.default = "down"

    self.voice = "axis"
    self.portrait_path = "face/axis"
    self.portrait_offset = {-26, -18}

    self.can_blush = false

    self.talk_sprites = {}

    self.animations = {
        -- Movement animations
        ["right"]                 = {"idle/right", 1/15, true},
        ["left"]                  = {"idle/left", 1/15, true},
        ["up"]                    = {"idle/up", 1/15, true},
        ["down"]                  = {"idle/down", 1/15, true},

        ["damaged_right"]         = {"idle_damaged/right", 1/15, true},
        ["damaged_left"]          = {"idle_damaged/left", 1/15, true},
        ["damaged_up"]            = {"idle_damaged/up", 1/15, true},
        ["damaged_down"]          = {"idle_damaged/down", 1/15, true},

        -- Cutscene animations
        ["ballthrow"]             = {"ballthrow", 1/10, true},
        ["bonk"]                  = {"bonk", 1/10, false},
        ["bonk_restore"]          = {"bonk_restore", 1/10, false},
        ["damaged_grab_lid"]      = {"damaged_grab_lid", 1/10, false},
        ["falls_up"]              = {"falls_up", 1/10, false},
        ["grab_lid"]              = {"grab_lid", 1/10, false},
        ["LOVE"]                  = {"LOVE", 1/10, true},
        ["shadowy_down"]          = {"shadowy_down", 1/15, true},

        -- Cutscene animations for cutscene
        -- with acid from the neutral route
        ["acid_p1"]               = {"acid/p1", 1/15, true},
        ["acid_p2"]               = {"acid/p2", 1/12, true},
        ["acid_p3"]               = {"acid/p3", 1/12, true},
        ["acid_p4"]               = {"acid/p4", 1/12, true},
        ["acid_p5"]               = {"acid/p5", 1/12, false},

        -- Cutscene animations for cutscene
        -- where Clover shoots Axis
        ["redeyes_ball_loop"]     = {"redeyes/ball_loop", 1/12, false},
        ["redeyes_charge"]        = {"redeyes/charge", 1/12, false},
        ["redeyes_right"]         = {"redeyes/right", 1/15, false},
        ["redeyes_shot"]          = {"redeyes/shot", 1/12, false},
        ["redeyes_shot_end"]      = {"redeyes/shot_end", 1/12, false},
        ["redeyes_shot_slam"]     = {"redeyes/shot_slam", 1/10, false},

        -- Cutscene animations for cutscene
        -- where Axis corners Clover (and Ceroba)
        ["toc_ball_loop"]         = {"thatonecutscene/ball_loop", 1/12, true},
        ["toc_ballthrow"]         = {"thatonecutscene/ballthrow_left", 1/12, false},
        ["toc_charge"]            = {"thatonecutscene/charge", 1/15, false},
        ["toc_charge_again"]      = {"thatonecutscene/charge_again", 1/12, false},
        ["toc_charge_yet_again"]  = {"thatonecutscene/charge_yet_again", 1/12, false},
        ["toc_fall"]              = {"thatonecutscene/fall", 1/12, false},
        ["toc_flip"]              = {"thatonecutscene/flip", 1/12, false},
        ["toc_leave"]             = {"thatonecutscene/leave", 1/12, false},
        ["toc_uncharge"]          = {"thatonecutscene/uncharge", 1/15, false},
    }

    self.offsets = {
        -- Animations offsets
        ["idle/right"]            = {0, 0},
        ["idle/left"]             = {0, 0},
        ["idle/up"]               = {0, 0},
        ["idle/down"]             = {0, 0},

        ["idle_damaged/right"]    = {0, 0},
        ["idle_damaged/left"]     = {0, 0},
        ["idle_damaged/up"]       = {0, 0},
        ["idle_damaged/down"]     = {0, 0},

        ["ballthrow"]             = {0, 0},
        ["bonk"]                  = {0, 0},
        ["bonk_restore"]          = {0, 0},
        ["damaged_grab_lid"]      = {0, 0},
        ["falls_up"]              = {0, 0},
        ["grab_lid"]              = {0, 0},
        ["LOVE"]                  = {0, 0},
        ["shadowy_down"]          = {0, 0},

        ["acid/p1"]               = {0, 0},
        ["acid/p2"]               = {0, 0},
        ["acid/p3"]               = {0, 0},
        ["acid/p4"]               = {0, 0},
        ["acid/p5"]               = {0, 0},

        ["redeyes/ball_loop"]     = {0, 0},
        ["redeyes/charge"]        = {0, 0},
        ["redeyes/right"]         = {0, 0},
        ["redeyes/shot"]          = {0, 0},
        ["redeyes/shot_end"]      = {0, 0},
        ["redeyes/shot_slam"]     = {0, 0},

        ["thatonecutscene/ball_loop"]         = {0, 0},
        ["thatonecutscene/ballthrow_left"]    = {0, 0},
        ["thatonecutscene/charge"]            = {0, 0},
        ["thatonecutscene/charge_again"]      = {0, 0},
        ["thatonecutscene/charge_yet_again"]  = {0, 0},
        ["thatonecutscene/fall"]              = {0, 0},
        ["thatonecutscene/flip"]              = {0, 0},
        ["thatonecutscene/leave"]             = {0, 0},
        ["thatonecutscene/uncharge"]          = {0, 0},

        -- Sprite offsets
        ["damaged_trash_down"]    = {0, 0},
        ["damaged_trash_left"]    = {0, 0},
        ["dead"]                  = {0, 0},
        ["dead_regular"]          = {0, 0},
        ["trash_down"]            = {0, 0},
        ["trash_left"]            = {0, 0},
        ["trash_right"]           = {0, 0},

        ["acid/p6"]               = {0, 0},

        ["redeyes/flyback"]       = {0, -6},
    }
end

return actor