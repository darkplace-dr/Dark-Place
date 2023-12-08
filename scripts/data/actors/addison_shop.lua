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
    self.voice_switch = "java"

    self.portrait_path = nil
    self.portrait_path_switch = "face/java"
    self.portrait_offset = {-22, -6}

    self.animations = {}

    self.talk_sprites = {}

    self.offsets = {}

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