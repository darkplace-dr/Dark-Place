local actor, super = Class(Actor, "magolor")

function actor:init(x, y)
    super.init(self, x, y)

    -- Display name (optional)
    self.name = "Magolor"

    -- Width and height for this actor, used to determine its center
    self.width = 59
    self.height = 83

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {0, 50, 59, 33}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 0, 0}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "world/npcs/magolor"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "shop"

    -- Sound to play when this actor speaks (optional)
    self.voice = "magolor"
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = "face/magolor"
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = {- 10, 0}

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = nil

    -- Table of sprite animations
    self.animations = {
        ["speen"] = {"speen", 0.01, true},
        ["speen_svfx"] = {"speen", 0.05, true},
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        ["speen"] = {0, 0}
    }
end

function actor:onWorldUpdate(chara)
	if chara.dance then
        if chara.dance_anim_timer == nil then
            chara.dance_anim_timer = 0
        end
        -- Animate
        chara.sprite.x = math.sin(chara.dance_anim_timer * (Kristal.Config["simplifyVFX"] and 12 or 5)) * 4
        chara.dance_anim_timer = chara.dance_anim_timer + DTMULT
    elseif chara.dance_anim_timer ~= nil and chara.dance_anim_timer ~= 0 then
	    chara.sprite.x = 0
        chara.dance_anim_timer = 0
	end
end

return actor
