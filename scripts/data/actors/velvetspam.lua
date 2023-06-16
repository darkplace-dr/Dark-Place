---@class velvetspam : Actor
local actor, super = Class(Actor, "velvetspam")

function actor:init()
    super.init(self)

    self.name = "Velvet!Spamton"

    self.width = 27
    self.height = 46

    self.hitbox = {1, 30, 24, 16}

    self.color = {1, 0, 0}

    self.flip = nil

    self.path = "world/npcs/velvetspam"
    self.path_night = "world/npcs/velvetspam/candle"
    self.default = "idle"
    self.default_night = "idle"

    self.voice = "spamton"
    self.portrait_path = nil
    self.portrait_offset = {0, 0}

    self.animations = {
        ["idle"] = {"idle", 1, true},
        ["day_blankie"] = {"day_blankie", 1, true},
        ["box"] = {"box", 1, true},
        ["talk"] = {"talk", 0.2, true},
        ["candle_idle"] = {"candle/idle", 1, true},
        ["candle/blankie"] = {"candle/blankie", 1, true},
        ["candle/bundled"] = {"candle/bundled", 1, true},
        ["candle/pissed"] = {"candle/pissed", 1, true},
        ["candle/pipis"] = {"candle/pipis", 1, true},
    }

    self.talk_sprites = {}

    self.offsets = {
        ["day_blankie_hug"] = {-3, 0},
        ["bundled"] = {-1, 0},
        ["pipis"] = {-1, 0}
	}

    self.taunt_sprites = {"day_blankie", "day_blankie_hug", "box"}
    self.taunt_sprites_night = {"pissed", "bundled", "pipis"}

    self.night = Mod:isNight()
    self.blankie_returned = Game:getFlag("blankie_returned")
    self.default_night = self.blankie_returned and "blankie" or "idle"
end

function actor:preSpriteUpdate(sprite)
    local night_bak = self.night
    self.night = Mod:isNight()
    if self.night ~= night_bak then
        Mod:softResetSprite(self, sprite)
    end

    local retd_bak = self.blankie_returned
    self.blankie_returned = retd_bak
    if self.blankie_returned ~= retd_bak then
        local reset_sprite = self.night and sprite.sprite == self:getDefault()
        self.default_night = self.blankie_returned and "blankie" or "idle"
        if reset_sprite then
            sprite:resetSprite()
        end
    end
end

function actor:getSpritePath()
    return not self.night and self.path or self.path_night
end

function actor:getDefault()
    return not self.night and self.default or self.default_night
end

function actor:getTauntSprites()
    return not self.night and self.taunt_sprites or self.taunt_sprites_night
end

return actor