local actor, super = Class(Actor, "balloondog")

function actor:init(x, y)
    super.init(self, x, y)

    -- Display name (optional)
    self.name = "Balloon Dog"

    -- Width and height for this actor, used to determine its center
    self.width = 23
    self.height = 69

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {0, 28, 23, 23}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 0, 0}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "world/npcs/balloondog"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "left"

    -- Sound to play when this actor speaks (optional)
    self.voice = nil
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
        ["left"] = {"left", 0.5, true},
        ["right"] = {"right", 0.5, true},
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {}
end
--the actor:onWorldUpdate(chara) function below is used to make an NPC react to the morshu_dance variable in room3.
function actor:onWorldUpdate(chara)
    chara.x = 520 + math.sin(Kristal.getTime()*1)*30
end

return actor
