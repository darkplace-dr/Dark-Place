local actor, super = Class(Actor, "werewire")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Werewire"

    -- Width and height for this actor, used to determine its center
    self.width = 39
    self.height = 63

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {6, 28, 27, 35}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 0, 0}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = "right"

    -- Path to this actor's sprites (defaults to "")
    self.path = "enemies/werewire"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "idle"

    -- Sound to play when this actor speaks (optional)
    self.voice = nil
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = nil

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {}
    -- Table of sprites that have a unique flip value, if self.flip is not set
    self.flip_sprites = {}

    -- Table of sprite animations
    self.animations = {
        ["idle"] = {"idle", self.doAnimTimer},
        ["hang"] = {"hang", 0.416667, true},
        ["hurt"] = {"hurt", 0, false},
        ["spare"] = {"spare", 2.5/30, false},
        ["overworld"] = {"overworld", 5/30, true}
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        ["idle"]          = {  0,   -5},
        ["overworld"]     = {  3, -207},
        ["attack_throw"]  = {-29,  -15},
        ["attack_shoot"]  = {-63,   -5},
        ["hang"]          = {  3,  -13},
        ["hurt"]          = { -8,   -9},
        ["spare"]         = { -1,   -3},
        ["spare_plugboy"] = {-27,  -14}
    }

    self.wires = {
        ["idle"]         = {x = -10, y = 9, curve = true,  amount = 1/4, add = 1, update = true },
        ["attack_throw"] = {x = -10, y = 9, curve = true,  amount = 1/4, add = 1, update = false},
        ["attack_shoot"] = {x = -10, y = 9, curve = true,  amount = 1/4, add = 1, update = false},
        ["hang"]         = {x =  10, y = 0, curve = false, amount = 1/8, add = 0, update = true },
    }
end

function actor:onSpriteInit(sprite)
    sprite.werewire_siner = 0
    sprite.werewire_siner_timer = 0
    sprite.werewire_anim_timer = 0
end

function actor:onSpriteUpdate(sprite)
    local wire = sprite:getValueForSprite(self.wires)

    if wire and wire.update then
        sprite.werewire_siner_timer = sprite.werewire_siner_timer + (0.16 * DTMULT)
        if sprite.werewire_siner_timer >= 1 then
            sprite.werewire_siner_timer = sprite.werewire_siner_timer - 1
            sprite.werewire_siner = sprite.werewire_siner + 8
        end
        sprite.werewire_anim_timer = sprite.werewire_anim_timer + (math.sin(sprite.werewire_siner / 17) / 2) * DTMULT
    end
end

function actor:onSpriteDraw(sprite)
    local wire = sprite:getValueForSprite(self.wires)

    if wire then
        local offset = sprite:getOffset()

        local wire_curve = Assets.getTexture("enemies/werewire/wire_curve")
        local wire_base = Assets.getTexture("enemies/werewire/wire_base")

        local wire_x, wire_y = -offset[1] + wire.x, -offset[2] + wire.y

        if wire.curve then
            Draw.draw(wire_curve, wire_x, wire_y)
        end

        for i = 1, 32 do
            local x_offset = ((math.sin((i - 1) / 4 + sprite.werewire_siner / 16) * (i - 1)) * (wire.amount / 2)) + ((i - 1) * wire.add)
            local y_offset = -(i * wire_base:getHeight())

            Draw.draw(wire_base, wire_x + x_offset, wire_y + y_offset)
        end
    end
end

function actor.doAnimTimer(sprite, wait)
    while true do
        sprite:setFrame(Utils.clamp(Utils.round(sprite.werewire_anim_timer) + 1, 1, 14))
        wait()
    end
end

return actor