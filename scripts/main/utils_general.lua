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

-- Get the average LOVE for the whole party \
-- Note that the result absolutely can be a double. Round if necessary.
--- @return number love # The LOVE of the party
function Mod:getPartyLove()
    local sum_love = 0
    for _,char in ipairs(Game.party) do
        sum_love = sum_love + char:getLOVE()
    end
    return sum_love/#Game.party
end

---@param ... any # Extra parameters to cond()
function Mod:evaluateCond(data, ...)
    local result = true

    if data.cond then
        result = data.cond(...)
    elseif data.flagcheck then
        local inverted, flag = Utils.startsWith(data.flagcheck, "!")

        local flag_value = Game.flags[flag]
        local expected_value = data.flagvalue
        local is_true
        if expected_value ~= nil then
            is_true = flag_value == expected_value
        elseif type(result) == "number" then
            is_true = flag_value > 0
        else
            is_true = flag_value
        end

        if is_true then
            result = not inverted
        else
            result = inverted
        end
    end

    return result
end

function Mod:setPresenceState(details)
    self.rpc_state = details

    -- talk about some half-baked support :bangbang:
    local presence = Kristal.getPresence()
    if presence then
        presence.state = Kristal.callEvent("getPresenceState")
        Kristal.setPresence(presence)
    end
end

-- Gets the index of an item in a 2D table
---@return integer|nil i
---@return integer|nil j
function Mod:getIndex2D(t, value)
    for i,r in ipairs(t) do
        local j = Utils.getIndex(r, value)
        if j then
            return i, j
        end
    end
    return nil, nil
end

function Mod:setDesiredWindowTitleAndIcon()
    if Kristal.setDesiredWindowTitleAndIcon then
        Kristal.setDesiredWindowTitleAndIcon()
    else
        love.window.setIcon(Kristal.icon)
        love.window.setTitle(Kristal.getDesiredWindowTitle())
    end
end

-- "Linear interpolation" that snaps into place when there is little distance left.
-- This is meaningful in case m (typically named t) is constant.
--
-- Derived from GML snippet by cecil (@attic-stuff) on GameMaker Discord
--
---@param a number # Left edge
---@param b number # Right edge
---@param m number # Progress or increment amount
---@param snap_delta? number # Distance at which to snap to b
---@return number
function Mod:lerpSnap(a, b, m, snap_delta)
    if snap_delta == nil then snap_delta = 0.001 end
    local result = Utils.lerp(a, b, m)
    if b - result <= snap_delta then
        return b
    end
    return result
end