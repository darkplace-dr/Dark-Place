local actor, super = Class(Actor, "addisonshop")

function actor:init()
    super.init(self)

    self.name = "Shop Addison/Java"

    self.width = 59
    self.height = 83

    self.hitbox = {0, 50, 59, 33}

    self.color = {0, 0, 0}

    self.flip = nil

    self.path = "world/npcs/addisons/original"
    self.path_switch = "world/npcs/addisons/velvet_style"
    self.default = "pink_stall"

    self.voice = nil
    self.voice_switch = "voice/java"

    self.portrait_path = nil
    self.portrait_path_switch = "face/java"
    self.portrait_offset = {-22, -6}

    self.animations = {
    }
	
    self.talk_sprites = {
    }

    self.offsets = {
	}
end

function actor:getSpritePath()
    return not Mod:addiSwitch() and self.path or self.path_switch
end

function actor:getPortraitPath()
    return not Mod:addiSwitch() and self.portrait_path or self.portrait_path_switch
end

function actor:getVoicePath()
    return not Mod:addiSwitch() and self.voice or self.voice_switch
end

function actor:onSpriteInit(sprite)
    self.switch = false
end

function actor:onSpriteUpdate(sprite)
    local switch_bak = self.switch
    self.switch = Mod:addiSwitch()

    if self.switch ~= switch_bak then
        Mod:softResetSprite(self, sprite)
    end
end

return actor