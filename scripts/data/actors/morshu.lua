local actor, super = Class(Actor, "morshu")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Morshu"

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
    self.path = "world/npcs/morshu"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = ""

    -- Sound to play when this actor speaks (optional)
    self.voice = nil
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = nil

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {
        [""] = 0.2
    }

    -- Table of sprite animations
    self.animations = {}

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {}
end

function actor:onWorldUpdate(chara)
	if chara.dance then
        if chara.dance_anim_timer == nil then
            chara.dance_anim_timer = 0
        end
        -- Animate
        chara.sprite.x = math.sin(chara.dance_anim_timer * 12) * 4
        chara.dance_anim_timer = chara.dance_anim_timer + DT
    elseif chara.dance_anim_timer ~= nil then
	    chara.sprite.x = 0
        chara.dance_anim_timer = nil
	end
end

return actor
