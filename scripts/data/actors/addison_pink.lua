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
    self.voice_switch = "java"

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

    self.switch = Mod:shouldUseVelvetAddisons()
end

function actor:getSpritePath()
    if not self.switch then return self.path
    else return self.path_switch end
end

function actor:getPortraitPath()
    if not self.switch then return self.portrait_path
    else return self.portrait_path_switch end
end

function actor:getVoice()
    if not self.switch then return self.voice
    else return self.voice_switch end
end

function actor:onSpriteUpdate(sprite)
    local switch_bak = self.switch
    self.switch = Mod:shouldUseVelvetAddisons()

    if self.switch ~= switch_bak then
        Mod:softResetActorSprite(sprite)
    end
end

return actor