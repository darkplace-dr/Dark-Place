local actor, super = Class(Actor, "noel")

function actor:onSpriteInit(sprite)
    sprite:addFX(OutlineFX())
    sprite:getFX(OutlineFX):setColor(1, 1, 1)
end

--Up and down didnt look nice enough
--[[
--print(Game.world.player.sprite.sprite_options[1])
function Actor:onWorldDraw(chara)
    if chara.running and chara.running == true and not chara.running == false then
        --print("woah")
        if chara.facing == "left" then
            chara.rotation = 0.2
            chara.scale_y = 2
        elseif chara.facing == "right" then
            chara.rotation = -0.2
            chara.scale_y = 2
        elseif chara.facing == "down" then
            chara.rotation = 0
            chara.scale_y = 2.1
        elseif chara.facing == "up" then
            chara.rotation = 0
            chara.scale_y = 1.9
        else
            chara.rotation = 0
            chara.scale_y = 2

        end
    elseif chara.rotation ~= 0 or chara.scale_y ~= 2 then
        chara.rotation = 0
        chara.scale_y = 2
    end
end
]]

function actor:init()
    super.init(self)
    self.name = "Noel"
    self.width = 33
    self.height = 40
    self.hitbox = {7, 28, 19, 14}
    self.color = {1, 1, 1}
    self.path = "party/noel"
    self.default = "walk"

    self.voice = "noel"

    self.portrait_path = "face/noel"

    self.portrait_offset = {-22, -30}

    self.can_blush = false

    self.animations = {
        ["stop"]         = {"stop/stop", 1/12, false},
        ["battle/a"]         = {"battle/a", 0.2, true},
        ["battle/idle"]         = {"battle/idle", 0.2, true},
        ["battle/boo_you_suck"]         = {"battle/idle", 0.2, true},
        ["battle/defeat"]         = {"battle/down", 0.2, false},
        ["you_gonna_hit_me"]         = {"battle/you_gonna_hit_me", 0.2, true},
        ["battle/attack_ready"] = {"battle/attack_ready", 1/60, false},
        ["battle/spell_ready"]  = {"battle/attack_ready", 1/8, false},
        ["battle/attack"]         = {"battle/attack", 1/35, false},

        ["battle/attack_repeat"] = {"battle/attack", 1/60, false, next="battle/attack_ready"},

        ["sitting"] = {"sitting"},
        ["brella"] = {"brella"},
        ["ashes_0"] = {"ashes_0"},
        ["ashes_1"] = {"ashes_1"},
    }

    self.offsets = {
        ["battle/a"] = {-28, -18},
        ["stop/stop"] = {-28, -18},
        ["battle/idle"] = {-28, -18},
        ["battle/down"] = {-28, -18},
        ["battle/you_gonna_hit_me"] = {-28, -18},
        ["battle/boo_you_suck"] = {-28, -18},
        ["battle/attack"] = {-28, -18},
        ["battle/attack_ready"] = {-28, -18},

        ["sitting"] = {0, 13},

        ["brella"] = {-6, -7},


        ["walk/down"] = {0, 1},
        ["walk/up"] = {0, 1},
        ["walk/left"] = {0, 1},
        ["walk/right"] = {0, 1},

    }

    self.mirror_sprites = {
        ["walk/down"] = "walk/up",
        ["walk/up"] = "walk/down",
        ["walk/left"] = "walk/left",
        ["walk/right"] = "walk/right",
    }

end

return actor