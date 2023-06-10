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

local function updateTexture(self, sprite)
    local path_prev = sprite.path
    sprite.path = self:getSpritePath()
    local tex_name = sprite.texture_path
    tex_name = Utils.sub(tex_name, utf8.len(path_prev) + 1)
    if utf8.len(tex_name) > 0 and Utils.sub(tex_name, 1, 1) == "/" then
        tex_name = Utils.sub(tex_name, 2)
    end
    for i = 3,1,-1 do
        local num = tonumber(tex_name:sub(-i))
        if num then
            tex_name = tex_name:sub(1, -i - 1)
            if tex_name:sub(-1, -1) == "_" then
                tex_name = tex_name:sub(1, -2)
            end
            break
        end
    end
    local new_path = sprite:getPath(tex_name)
    local new_frames = Assets.getFrames(new_path)
    if new_frames then
        sprite:setFrames(new_frames, true)
        if self.animations[sprite.path] then
            sprite:setAnimation(self.animations[sprite.path])
        end
    else
        sprite:setTexture(Assets.getTexture(new_path), true)
    end
    sprite:updateTexture()
end

function actor:onSpriteInit(sprite)
    self.switch = false
end

function actor:onSpriteUpdate(sprite)
    local switch_bak = self.switch
    self.switch = Mod:addiSwitch()

    if self.switch ~= switch_bak then
        updateTexture(self, sprite)
    end
end

return actor