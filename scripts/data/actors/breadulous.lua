local actor, super = Class(Actor, "breadulous")

function actor:init()
    super.init(self)

    self.name = "Breadulous"

    self.width = 32
    self.height = 32

    self.hitbox = {0, 15, 32, 16}

    self.color = {1, 0, 0}

    self.path = "world/npcs/breadulous"
    if Mod:isNight() then
        self.default = "sleeping"
    else
        self.default = "walk"
    end

    self.voice = nil
    self.portrait_path = nil
    self.portrait_offset = nil

    self.can_blush = false

    self.talk_sprites = {}

    self.animations = {
        ["sleeping"] = {"sleeping", 1, true},
    }

    self.offsets = {
        ["sleeping"] = {0, 0},
    }
end

return actor