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
    self.path_night_blankie = "world/npcs/velvetspam/blankie"
    self.default = "idle"
    self.default_blankie = "blankie"


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
	
    self.talk_sprites = {
    }

    self.offsets = {
        ["day_blankie_hug"] = {-3, 0},
        ["bundled"] = {-1, 0},
        ["pipis"] = {-1, 0}
	}

    self.taunt_sprites = {"day_blankie", "day_blankie_hug", "box"}
    self.taunt_sprites_night = {"pissed", "bundled", "pipis"}
end

function actor:getSpritePath()
    return not self.night and self.path or self.path_night or self.path_night_blankie
end

function actor:getTauntSprites()
    return not self.night and self.taunt_sprites or self.taunt_sprites_night
end

function actor:onSpriteInit(sprite)
    self.night = false
    self.night_blankie = false
end

function actor:onSpriteUpdate(sprite)
    local night_bak = self.night
    local blankie_bak = self.night
    self.night = Mod:isNight()
    self.night_blankie = Game:getFlag("blankie_returned")


    if self.night ~= night_bak then
        Mod:attemptToApplySpritePathChanges(self, sprite)
    end

    if self.night_blankie~= blankie_bak and Game:getFlag("blankie_returned") == true then
        Mod:attemptToApplySpritePathChanges(self, sprite)
    end

end

return actor