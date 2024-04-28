local actor, super = Class(Actor, "spam_mosquito")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Spamosquito"

    -- Width and height for this actor, used to determine its center
    self.width = 33
    self.height = 39

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {16, 19, 1, 1}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 0, 0}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "world/npcs/spam_mosquito"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "idle"

    -- Sound to play when this actor speaks (optional)
    self.voice = "spamton"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = nil

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {}

    -- Table of sprite animations
    self.animations = {
        ["idle"] = {"idle", .01, true},
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {}
end

function actor:onWorldUpdate(chara)
    chara.y = 200 + math.sin(Kristal.getTime()*1)*15
    chara.sprite:setScale(0.5)
    chara.sprite:setOrigin(-0.5, 0)
end

return actor
