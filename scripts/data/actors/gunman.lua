local actor, super = Class(Actor, "gunman")

function actor:init()
    super.init(self)
    self.name = "gunman"
    self.width = 27
    self.height = 45
    self.hitbox = {0, 25, 19, 14}
    self.color = {1, 0, 0}
    self.flip = nil
    self.path = "battle/enemies/gunman"
    self.default = "idle"
    self.voice = nil
    self.portrait_path = nil
    self.portrait_offset = nil
    self.can_blush = false
    self.background = false
    self.talk_sprites = {}
    self.animations = {
        ["idle"] = {"idle", 0.25, true},
    }
    self.offsets = {
        ["idle"] = {0, 0},
    }
end

return actor