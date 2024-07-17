local actor, super = Class(Actor, "tellyvisenemy")

function actor:init()
    super.init(self)

    self.name = "Telly-Vis"

    self.width = 120
    self.height = 109

    self.use_light_battler_sprite = true

    self.hitbox = {0, 25, 19, 14}

    self.color = {1, 0, 0}

    self.flip = nil

    self.path = "battle/lightenemies/tellyvis"
    self.default = ""

    self.voice = nil
    self.portrait_path = nil
    self.portrait_offset = nil

    self.can_blush = false

    self.talk_sprites = {}

    self.animations = {
        ["lightbattle_hurt"] = {"hurt", 1/8, false},
        ["lightbattle_spared"] = {"body", 1/8, false},
    }

    self.offsets = {
        ["hurt"]  = {0, 0},
        ["spared"]  = {0, 0},
    }

    self:addLightBattlerPart("body", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/body", 60, 109)
            sprite:setOrigin(0.5, 1)
            sprite.layer = 400
            return sprite
        end
    })

    self:addLightBattlerPart("face", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/faces/normal", 60, 109)
            sprite:setOrigin(0.5, 1)
            sprite.layer = 410
            sprite:play(1/5)
            return sprite
        end
    })

end

return actor