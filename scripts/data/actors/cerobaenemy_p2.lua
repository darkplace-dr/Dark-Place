local actor, super = Class(Actor, "cerobaenemy_p2")

function actor:init()
    super.init(self)

    self.name = "Ceroba"

    self.light_battle_width = 113
    self.light_battle_height = 114

    self.hitbox = {0, 0, 16, 16}

    self.use_light_battler_sprite = true

    self.path = "party/ceroba"
    self.default = "idle"

    self.voice = "ceroba"

    self.animations = {
        ["lightbattle_hurt"] = {"lightbattle/hurt_phase_2", 1, true},
        ["intro"] = {"lightbattle/animations/intro", 1/11, false},
        ["phase_switch"] = {"lightbattle/animations/phase_switch", 1/11, false},
        ["staff_spin"] = {"lightbattle/animations/staff_spin", 1/11, false},
        ["death"] = {"lightbattle/animations/death", 1/6, false},
    }

    self.offsets = {
        ["lightbattle/hurt_phase_2"] = {-9, 5},
        ["lightbattle/animations/intro"] = {-21, -20},
        ["lightbattle/animations/phase_switch"] = {-23, -28},
        ["lightbattle/animations/staff_spin"] = {-23, -28},
        ["lightbattle/animations/death"] = {-9, 5},
    }

    self:addLightBattlerPart("body", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/lightbattle/body", 55, 112)
            sprite:setOrigin(0.5, 1)
            sprite.layer = 480
            return sprite
        end,
        ["init"] = function(part)
            part.timer = 0
        end,
        ["update"] = function(part)
            part.timer = part.timer + DTMULT

            part.sprite.scale_y = (30+(math.sin(part.timer /20)))/30
        end
    })
    
    self:addLightBattlerPart("head", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/lightbattle/head", 57.5, 55)
            sprite:setOrigin(0.5, 1)
            sprite.layer = 500
            return sprite
        end,
        ["init"] = function(part)
            part.timer = 0
        end,
        ["update"] = function(part)
            part.timer = part.timer + DTMULT

            part.sprite.y = (-math.sin(part.timer/20) * 3) + 55
        end
    })

    self:addLightBattlerPart("ponytail", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/lightbattle/ponytail", 45, 62)
            sprite:setOrigin(0.5, 1)
            sprite.layer = 460
            return sprite
        end,
        ["init"] = function(part)
            part.timer = 0
        end,
        ["update"] = function(part)
            part.timer = part.timer + DTMULT

            part.sprite.y = (-math.sin(part.timer/20) * 3) + 62
        end
    })

    self:addLightBattlerPart("hand_right", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/lightbattle/hand_right", 71, 79)
            sprite:setOrigin(0.5, 1)
            sprite.layer = 490
            return sprite
        end,
        ["init"] = function(part)
            part.timer = 0
        end,
        ["update"] = function(part)
            part.timer = part.timer + DTMULT

            part.sprite.y = (-math.sin(part.timer/20) * 3) + 79
        end
    })

    self:addLightBattlerPart("hand_left", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/lightbattle/hand_left", 33.5, 80)
            sprite:setOrigin(0.5, 1)
            sprite.layer = 470
            return sprite
        end,
        ["init"] = function(part)
            part.timer = 0
        end,
        ["update"] = function(part)
            part.timer = part.timer + DTMULT

            part.sprite.y = (-math.sin(part.timer/20) * 3) + 80
        end
    })

    self:addLightBattlerPart("staff", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/lightbattle/staff_red", 48, 112)
            sprite:setOrigin(0.5, 1)
            sprite.layer = 450
            return sprite
        end,
        ["init"] = function(part)
            part.timer = 0
        end,
        ["update"] = function(part)
            part.timer = part.timer + DTMULT

            part.sprite.y = (-math.sin(part.timer/20) * 3) + 112
        end
    })

end

return actor