function Mod:registerShaders()
    self.shaders = {}
    for _,path,shader in Registry.iterScripts("shaders/") do
        assert(shader ~= nil, '"shaders/'..path..'.lua" does not return value')
        self.shaders[path] = shader
    end
end

---@alias PrintHelperMsgLevels
---| "log"
---| "warn"
---| "error"

---@param msg any
---@param msg_level? PrintHelperMsgLevels
function Mod:print(msg, msg_level)
    msg = tostring(msg)
    msg_level = msg_level or "log"

    local prefixs = {
        warn = "[WARNING] ",
        error = "[ERROR] "
    }
    local prefixs_rich = {
        warn = "[color:yellow][WARNING] ",
        error = "[color:red][ERROR] "
    }

    local prefixed_msg = (prefixs[msg_level] or "")..msg
    print(prefixed_msg)

    if Kristal.Console then
        local prefixed_msg_rich = (prefixs_rich[msg_level] or "")..msg
        Kristal.Console:push(prefixed_msg_rich)
    end
end

---@param msg any
---@param msg_level? PrintHelperMsgLevels
---@param stack_level? integer|function
function Mod:trace(msg, msg_level, stack_level)
    msg_level = msg_level or "log"
    stack_level = stack_level or 2 -- the caller
    msg = tostring(msg)

    local stack_info = debug.getinfo(stack_level, "Snl")
    local func_name = stack_info.name
    local line = stack_info.currentline
    local src = stack_info.short_src
    if Utils.startsWith(stack_info.source, "@") then
        local ok, src_n = Utils.startsWith(src, Mod.info.path.."/")
        if ok then
            src = src_n
        else
            src = "[kristal]/" .. src
        end
    end

    local msg_prefix = (stack_info.what ~= "main" and func_name)
        and string.format("%s:%d (%s): ", src, line, func_name)
        or string.format("%s:%d: ", src, line)
    msg = msg_prefix .. msg

    Mod:print(msg, msg_level)
end

--- Returns the current party leader's PartyMember, Actor, ActorSprite or Character object
---@param kind? "partymember"|"party"|"character"|"chara"|"actor"|"sprite"|"actorsprite" The kind of object that will be gathered, "partymember" by default
---@return PartyMember|Actor|ActorSprite|Character obj A object related to the leader.
function Mod:getLeader(kind)
    kind = (kind or "partymember"):lower()

    local leader = Game.party[1]
    if kind == "character" or kind == "chara" then
        return Game.world:getCharacter(leader.id)
    elseif kind == "actor" then
        return leader.actor
    elseif kind == "sprite" or kind == "actorsprite" then
        return self:getLeader("character").sprite
    end
    return leader --[[ if kind == "partymember" or kind == "party" ]]
end

-- Tries to reload the texture of an ActorSprite.
-- Mainly for refreshing sprites after its actor's sprite path has changed.
---@param sprite ActorSprite
function Mod:softResetActorSprite(sprite)
    -- Due to engine limitations, this implementation
    -- will ONLY work with ActorSprites

    local anim = sprite.anim
    local anim_name
    local animations = sprite.actor.getAnimations
        and sprite.actor:getAnimations()
        or sprite.actor.animations
    for name, data in pairs(animations) do
        if data == anim then
            anim_name = name
            break
        end
    end

    sprite.path = sprite.actor:getSpritePath()

    if anim_name then
        sprite:setAnimation(anim_name)
        if not sprite.anim then -- failsafe
            sprite:resetSprite()
        end
    elseif anim then
        sprite:setAnimation(anim)
    else
        sprite:setSprite(sprite.sprite, true)
        if not sprite.texture then -- failsafe
            sprite:resetSprite()
        end
    end
end