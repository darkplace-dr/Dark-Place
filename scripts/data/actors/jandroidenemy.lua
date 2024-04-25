local actor, super = Class(Actor, "jandroidenemy")

function actor:init()
    super.init(self)

    self.name = "Jandroid"

    self.width = 104
    self.height = 106

    self.use_light_battler_sprite = true

    self.hitbox = {0, 25, 19, 14}

    self.color = {1, 0, 0}

    self.flip = nil

    self.path = "battle/lightenemies/jandroid"
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

    self:addLightBattlerPart("body_bottom", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/body_bottom", 30, 96)
            sprite:setOrigin(0.5, 1)
            --sprite.layer = 400
            return sprite
        end
    })

    self:addLightBattlerPart("body_middle", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/body_middle", 30, 78)
            sprite:setOrigin(0.5, 1)
            --sprite.layer = 400
            return sprite
        end
    })

    self:addLightBattlerPart("body_top", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/body_top", 30, 68)
            sprite:setOrigin(0.5, 1)
            --sprite.layer = 400
            return sprite
        end
    })

    self:addLightBattlerPart("head", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/head", 30, 56)
            sprite:setOrigin(0.5, 1)
            --sprite.layer = 400
            sprite:play(1/4)
            return sprite
        end
    })

    self:addLightBattlerPart("broom", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/broom", 65, 100)
            sprite:setOrigin(0.5, 1)
            --sprite.layer = 400
            return sprite
        end
    })
end

return actor