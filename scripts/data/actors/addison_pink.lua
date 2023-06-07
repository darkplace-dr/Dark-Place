---@class velvetspam : Actor
local actor, super = Class(Actor, "addisonpink")

function actor:init()
    super.init(self)

    self.name = "Pink_Ad"

    self.width = 39
    self.height = 53

    self.hitbox = {8, 43, 24, 11}

    self.color = {0, 0, 0}

    self.flip = nil

    self.path = "world/npcs/addisons/original/pink"
    self.path_switch = "world/npcs/addisons/velvet_style/java"
    self.default = "stand"

    self.voice = nil
    self.portrait_path = nil
    self.portrait_offset = {0, 0}

    self.animations = {
        ["idle"] = {"idle", 0.2, true},
    }
	
    self.talk_sprites = {
    }

    self.offsets = {
	}
end

function actor:getSpritePath()
    return not Mod:SwitchOn() and self.path or self.path_switch
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
    self.switch = Mod:SwitchOn()

    if self.cwitch ~= switch_bak then
        updateTexture(self, sprite)
    end
end

return actor