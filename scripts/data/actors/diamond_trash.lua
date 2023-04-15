local actor, super = Class(Actor, "diamond_trash")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Trash Rudinn"

    -- Width and height for this actor, used to determine its center
    self.width = 45
    self.height = 48

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {5, 35, 20, 15}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 0, 0}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "world/npcs/diamond_trash"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "idle"

    -- Sound to play when this actor speaks (optional)
    self.voice = nil
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {0, 0}

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {
        ["talk"] = 0.15,
    }

    -- Table of sprite animations
    self.animations = {
        ["idle"] = {"idle", 1, true},
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {}
end

function actor:onTalkStart(text, sprite)
    if sprite.sprite == "idle" then
        sprite:setSprite("talk")
    end
end

function actor:onTalkEnd(text, sprite)
    if sprite.sprite == "talk" then
        sprite:setAnimation("idle")
    end
end

return actor