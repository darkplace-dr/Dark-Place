local actor, super = Class(Actor, "goosicenemy")

function actor:init()
    super.init(self)

    self.name = "Goosic"

    self.width = 91
    self.height = 102

    self.use_light_battler_sprite = true

    self.hitbox = {0, 25, 19, 14}

    self.color = {1, 0, 0}

    self.flip = nil

    self.path = "battle/lightenemies/goosic"
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
        ["hurt"]  = {-10, -14},
        ["spared"]  = {-10, -14},
    }

    self:addLightBattlerPart("leg_right_bot", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/leg_right_bot", 52.5, 81.5)
            sprite:setOrigin(0.5, 1)
            sprite.layer = 400
            return sprite
        end
    })

    self:addLightBattlerPart("leg_right_top", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/leg_right_top", 50.5, 70.5)
            sprite:setOrigin(0.5, 1)
            sprite.layer = 390
            return sprite
        end
    })

    self:addLightBattlerPart("leg_left_bot", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/leg_left_bot", 25.5, 79.5)
            sprite:setOrigin(0.5, 1)
            sprite.layer = 400
            return sprite
        end
    })

    self:addLightBattlerPart("leg_left_top", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/leg_left_top", 27.5, 70.5)
            sprite:setOrigin(0.5, 1)
            sprite.layer = 390
            return sprite
        end
    })

    self:addLightBattlerPart("body", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/body", 43.5, 66.5)
            sprite:setOrigin(0.5, 1)
            sprite.layer = 400
            return sprite
        end
    })

    self:addLightBattlerPart("head", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/head", 54, 34.5)
            sprite:setOrigin(0.5, 1)
            sprite.layer = 400
            sprite:play(1/4)
            return sprite
        end
    })

    self:addLightBattlerPart("neck_piece_one", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/neck_piece", 23, 58)
            sprite:setOrigin(0.5, 1)
            sprite.layer = 400
            return sprite
        end
    })

    self:addLightBattlerPart("neck_piece_two", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/neck_piece", 20.5, 50)
            sprite:setOrigin(0.5, 1)
            --sprite.layer = 400
            return sprite
        end
    })

    self:addLightBattlerPart("neck_piece_three", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/neck_piece", 21.5, 41.5)
            sprite:setOrigin(0.5, 1)
            --sprite.layer = 400
            return sprite
        end
    })

    self:addLightBattlerPart("neck_piece_four", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/neck_piece", 26, 35.5)
            sprite:setOrigin(0.5, 1)
            --sprite.layer = 400
            return sprite
        end
    })

    self:addLightBattlerPart("neck_piece_five", {
        ["create_sprite"] = function()
            local sprite = Sprite(self.path.."/neck_piece", 31, 29.5)
            sprite:setOrigin(0.5, 1)
            --sprite.layer = 400
            return sprite
        end
    })
end

return actor