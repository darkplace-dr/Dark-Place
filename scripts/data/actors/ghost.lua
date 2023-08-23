local actor, super = Class(Actor, "ghost")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Cara"

    -- Width and height for this actor, used to determine its center
    self.width = 20
    self.height = 35

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {0, 28, 18, 18}

    self.solid = false

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {0.5, 0.5, 0.5}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "world/npcs/ghost"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "down"

    self.order = {"down", "right", "up", "left"}
    self.order_index = 1
    self.order_timer = nil

    self.spin = true

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

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {}
end

function actor:onWorldUpdate(chara)
    if self.order_timer == nil then
        chara.solid = false
        self.order_timer = Game.world.timer:every(0.5, function()
            if self.spin then
                self.order_index = self.order_index + 1
                if self.order_index > #self.order then
                    self.order_index = 1
                end
                chara:setSprite(self.order[self.order_index])
            end
        end)
    end
end

return actor
