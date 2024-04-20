local actor, super = Class(Actor, "smb_goomba")

function actor:init()
    super.init(self)
    
    -- Display name (optional)
    self.name = "Goomba"

    -- Width and height for this actor, used to determine its center
    self.width = 16
    self.height = 16

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {2, 6, 12, 9}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {0, 0, 0}

    -- Path to this actor's sprites (defaults to "")
    self.path = "world/npcs/smb_goomba"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "idle"

    self.palette = "castle"

    -- Sound to play when this actor speaks (optional)
    self.voice = nil
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = nil

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of sprite animations
    self.animations = {}

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {}
    print("Goomba yeah")
end

function actor:getSpritePath()
    print(self.path.."/"..self.palette)
    return self.path.."/"..self.palette
end


return actor