function Mod:registerShaders()
    self.shaders = {}
    for _,path,shader in Registry.iterScripts("shaders/") do
        assert(shader ~= nil, '"shaders/'..path..'.lua" does not return value')
        self.shaders[path] = shader
    end
end

--- Returns the current party leader's PartyMember, Actor, ActorSprite, Character or PartyBattler object
---@param kind? "partymember"|"party"|"character"|"chara"|"actor"|"sprite"|"actorsprite"|"battler"|"partybattler" The kind of object that will be gathered, "partymember" by default
---@return PartyMember|Actor|ActorSprite|Character|PartyBattler|nil obj A object related to the leader.
function Mod:getLeader(kind)
    kind = (kind or "partymember"):lower()

    local leader = Game.party[1]
    if not leader then return nil end

    if kind == "character" or kind == "chara" then
        if not Game.world then return nil end
        return Game.world:getCharacter(leader.id)
    elseif kind == "actor" then
        return leader.actor
    elseif kind == "sprite" or kind == "actorsprite" then
        local chara = self:getLeader("character")
        if not chara then return nil end
        return chara.sprite
    elseif kind == "battler" or kind == "partybattler" then
        if not Game.battle then return nil end
        return Game.battle:getPartyBattler(leader.id)
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

-- Resets the window, taking account of TileLayers - hack
function Mod:resetWindow()
    Kristal.resetWindow()

    if Game.world then
        for _,tilelayer in ipairs(Game.world.stage:getObjects(TileLayer)) do
            -- Force tilelayers to redraw, since resetWindow destroys their canvases
            tilelayer.drawn = false
        end
    end
end

--- Get the average LOVE for the whole party
--- @returns LOVE number The LOVE of the party
function Mod:getPartyLove()
    local sum_love = 0
    for _,char in ipairs(Game.party) do
        sum_love = sum_love + char:getLevel()
    end
    return sum_love/#Game.party
end