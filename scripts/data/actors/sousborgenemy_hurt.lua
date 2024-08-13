local actor, super = Class(Actor, "sousborgenemy_hurt")

function actor:init()
    super.init(self)

    self.name = "Sousborg"

    self.width = 157
    self.height = 125

    self.use_light_battler_sprite = true

    self.hitbox = {0, 25, 19, 14}

    self.color = {1, 0, 0}

    self.flip = nil

    self.path = "battle/lightenemies/sousborg"
    self.default = ""

    self.voice = nil
    self.portrait_path = nil
    self.portrait_offset = nil

    self.can_blush = false

    self.talk_sprites = {}

    self.animations = {
        ["lightbattle_hurt"] = {"hurt", 1/8, false},
        ["lightbattle_spared"] = {"spared", 1/8, false},
    }

    self.offsets = {
        ["hurt"]  = {0, 0},
        ["spared"]  = {0, 0},
    }

    self:addLightBattlerPart("body", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/body_hurt", 73, 131)
            sprite:setOrigin(0.5, 1)
            sprite.layer = 400
            return sprite
        end
    })

    self:addLightBattlerPart("head", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/head_hurt", 72.5, 72)
            sprite:setOrigin(0.5, 1)
            sprite.layer = 410
            return sprite
        end
    })

    self:addLightBattlerPart("right_arm_1", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/right_arm_1_hurt", 113, 102)
            sprite:setOrigin(0.5, 1)
            sprite.layer = 390
            return sprite
        end
    })

    self:addLightBattlerPart("right_arm_2", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/right_arm_2_hurt", 125.5, 94)
            sprite:setOrigin(0.5, 1)
            sprite.layer = 400
            return sprite
        end
    })

    self:addLightBattlerPart("right_hand", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/right_hand_hurt", 125, 67)
            sprite:setOrigin(0.5, 1)
            sprite.layer = 410
            sprite:play(1/10)
            return sprite
        end
    })

    self:addLightBattlerPart("left_arm_1", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/left_arm_1_hurt", 33, 97)
            sprite:setOrigin(0.5, 1)
            sprite.layer = 390
            return sprite
        end
    })

    self:addLightBattlerPart("left_arm_2", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/left_arm_2_hurt", 21, 95)
            sprite:setOrigin(0.5, 1)
            sprite.layer = 400
            return sprite
        end
    })

    self:addLightBattlerPart("left_hand", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/left_hand_hurt", 15, 79)
            sprite:setOrigin(0.5, 1)
            sprite.layer = 410
            return sprite
        end
    })
end

return actor