local actor, super = Class(Actor, "ceroba_dw")

function actor:init()
    super.init(self)

    self.name = "Ceroba"

    self.width = 26
    self.height = 54

    self.hitbox = {3.5, 42, 20, 13}

    self.soul_offset = {13.5, 28}

    self.color = {1, 1, 0}

    self.path = "party/ceroba/dark"
    self.default = "walk"

    self.voice = "ceroba"
    self.portrait_path = "face/ceroba"
    self.portrait_offset = {-18, -10}

    self.can_blush = false

    self.animations = {
        ["battle/idle"]         = {"battle/idle", 0.2, true},

        ["battle/attack"]       = {"battle/attack", 1/15, false},
        ["battle/act"]          = {"battle/act", 1/15, false},
        ["battle/spell"]        = {"battle/spell", 1/15, false, next="battle/idle"},
        ["battle/item"]         = {"battle/item", 1/12, false, next="battle/idle"},
        ["battle/spare"]        = {"battle/act", 1/15, false, next="battle/idle"},

        ["battle/attack_ready"] = {"battle/attackready", 1/8, false},
        ["battle/act_ready"]    = {"battle/actready", 1/15, false},
        ["battle/spell_ready"]  = {"battle/spellready", 0.2, true},
        ["battle/item_ready"]   = {"battle/itemready", 0.2, true},
        ["battle/spare_ready"]  = {"battle/actready", 1/15, false},
        ["battle/defend_ready"] = {"battle/defend", 1/15, false},

        ["battle/attack_end"]   = {"battle/attackend", 1/15, false, next="battle/idle"},
        ["battle/act_end"]      = {"battle/actend", 1/15, false, next="battle/idle"},
        ["battle/defend_end"]   = {"battle/defendend", 1/15, false, next="battle/idle"},

        ["battle/hurt"]         = {"battle/hurt", 1/15, false, temp=true, duration=0.5},
        ["battle/defeat"]       = {"battle/defeat", 1/15, false},

        ["battle/transition"]   = {"battle/intro", 1/15, false},
        ["battle/victory"]      = {"battle/victory", 1/10, false},
    }

    self.offsets = {
        -- Movement offsets
        ["walk/down"] = {1, 2},
        ["walk/right"] = {-2, 0},
        ["walk/left"] = {3, 0},
        ["walk/up"] = {0, 2},

        ["run/down"] = {0, 2},
        ["run/right"] = {-13, -5},
        ["run/left"] = {-8, -5},
        ["run/up"] = {0, 2},

        -- Battle offsets
        ["battle/idle"] = {-6, -6},

        ["battle/attack"] = {-6, -12},
        ["battle/attackready"] = {-6, -12},
        ["battle/attackend"] = {-6, -6},
        ["battle/act"] = {6, -7},
        ["battle/actend"] = {-7, -7},
        ["battle/actready"] = {-7, -7},
        ["battle/spell"] = {-1, -13},
        ["battle/spellready"] = {-1, -13},
        ["battle/item"] = {-12, -6},
        ["battle/itemready"] = {-12, -6},
        ["battle/defend"] = {-6, -7},
        ["battle/defendend"] = {-6, -7},

        ["battle/defeat"] = {-6, -6},
        ["battle/hurt"] = {-6, -6},

        ["battle/intro"] = {-6, -6},
        ["battle/victory"] = {-6, -6},

        -- Cutscene offsets
        ["fall"] = {0, 0},
        ["super_move"] = {-24, 0},
        ["the_roba"] = {0, 0},
    }

    --self.taunt_sprites = {"super_move", "the_roba"}
end

return actor