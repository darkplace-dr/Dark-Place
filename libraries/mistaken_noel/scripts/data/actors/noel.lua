local actor, super = Class(Actor, "noel")

function actor:onSpriteInit(sprite)
    sprite:addFX(BattleOutlineFX)
end


function actor:init()
    super.init(self)
    self.name = "Noel"
    self.width = 29
    self.height = 40
    self.hitbox = {1.5, 24, 26, 16}
    self.color = {1, 1, 1}
    self.path = "party/noel"
    self.default = "walk"

    self.voice = "noel"

    self.portrait_path = "face/noel"

    self.portrait_offset = {-22, -8}

    self.can_blush = false

    self.animations = {}

    --reverse
    --basic convo reverb

    --these have nothing to do with kristal btw.

    self.animations = {
        ["battle/idle"]         = {"battle/idle", 0.2, true},
        ["battle/attack"]       = {"battle/attack", 1/20, false, next="battle/attack1"},
        ["battle/attack1"]       = {"battle/attack", 1/25, false, next="battle/attack2"},
        ["battle/attack2"]       = {"battle/attack", 1/30, false, next="battle/attack3"},
        ["battle/attack3"]       = {"battle/attack", 1/35, false, next="battle/attack4"},
        ["battle/attack4"]       = {"battle/attack", 1/40, false, next="battle/attack5"},
        ["battle/attack5"]       = {"battle/attack", 1/45, false, next="battle/attack6"},
        ["battle/attack6"]       = {"battle/attack", 1/50, false, next="battle/attack7"},
        ["battle/attack7"]       = {"battle/attack", 1/55, false, next="battle/attack8"},
        ["battle/attack8"]       = {"battle/attack", 1/60, false, next="battle/attack9"},
        ["battle/attack9"]       = {"battle/attack", 1/65, false},

        ["battle/attack_ready"]       = {"battle/attack_1", 1/15, false},
        ["battle/defend_ready"] = {"battle/defend", 1/26, false},
        ["sitting"] = {"sitting"},
        ["ashes_0"] = {"ashes_0"},
        ["ashes_1"] = {"ashes_1"},
    }

    self.offsets = {
        ["sitting"] = {0, 13},

        ["battle/idle"] = {-35, -23},

        ["battle/attack"] = {-35, -23},
        ["battle/attack1"] = {-35, -23},
        ["battle/attack2"] = {-35, -23},
        ["battle/attack3"] = {-35, -23},
        ["battle/attack4"] = {-35, -23},
        ["battle/attack5"] = {-35, -23},
        ["battle/attack6"] = {-35, -23},
        ["battle/attack7"] = {-35, -23},
        ["battle/attack8"] = {-35, -23},
        ["battle/attack9"] = {-35, -23},

        ["battle/attackready"] = {-35, -23},
        ["battle/act"] = {-35, -23},
        ["battle/actend"] = {-35, -23},
        ["battle/actready"] = {-35, -23},
        ["battle/item"] = {-6, -6},
        ["battle/itemready"] = {-6, -6},
        ["battle/defend"] = {-35, -23},
    }

    self.mirror_sprites = {
        ["walk/down"] = "walk/up",
        ["walk/up"] = "walk/down",
        ["walk/left"] = "walk/left",
        ["walk/right"] = "walk/right",
    }

end

return actor