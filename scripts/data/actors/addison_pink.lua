local actor, super = Class(Actor, "addisonpink")

function actor:init()
    super.init(self)

    self.name = "Pink Addison/Java"

    self.width = 39
    self.height = 53

    self.hitbox = {8, 43, 24, 11}

    self.color = {0, 0, 0}

    self.flip = nil

    self.path = "world/npcs/addisons/original/pink"
    self.path_switch = "world/npcs/addisons/velvet_style/java"
    self.default = "stand"

    self.voice = nil
    self.voice_switch = "voice/java"

    self.portrait_path = nil
    self.portrait_path_switch = "face/java"
    self.portrait_offset = {-22, -6}

    self.animations = {
        ["idle"] = {"idle", 0.2, true},
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
        Mod:softResetActorSprite(sprite)
    end
end

return actor