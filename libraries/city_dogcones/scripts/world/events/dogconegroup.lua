local DogConeGroup, super = Class(Event)

function DogConeGroup:init(data)
    super.init(self, data)

    self:setOrigin(0, 0)
    self:setHitbox(0, self.height / 2, self.width, self.height / 2)

    self.solid = false

    self.scissor_fx = ScissorFX(0, 0, self.width, self.height)
    self:addFX(self.scissor_fx)

    self.cones = { }

    local pr = data["properties"]

    -- The number of frames spent transitioning between states (At 30 FPS)
    self.transition_frames      = pr["transition_speed"]        or 20
    -- The side from which the dogcones originate (i.e. where they will transition in from/out to), must be `"left"` or `"right"`
    self.cone_origin            = pr["cone_origin"]             or "left"
    -- The name of a flag checked on room load that determines the state of the cones. Takes priority over the internal `mystate` flag.
    self.flag                   = pr["flag"]                    or nil
    -- The state that the dogcones will start in.
    self.default_state          = pr["default_state"]           or false

    self:assertOrigin(self.cone_origin)

    self:createCones()
end

function DogConeGroup:onLoad()
    local options = {
        instant = true
    }

    local flag
    if self.flag then
        flag = Game:getFlag(self.flag, false)

    else
        flag = self:getFlag("mystate", nil)
        -- Use the default state if the object has never been loaded before
        if flag == nil then
            flag = self.default_state
            self:setFlag("mystate", flag)

        end

    end

    self:setConesState(flag, options)
end

function DogConeGroup:createCones()
    local j = math.floor(self.width / 40)

    for i=1,j do
        local cone = Sprite("world/events/dogcone")
        cone.x     = self:getInactiveConePosition(self.cone_origin)
        self:addChild(cone)
        cone:setScale(2)
        table.insert(self.cones, cone)
    end
end

function DogConeGroup:getActiveConePosition(index)
    return ((index - 1) * 40) + 6
end

function DogConeGroup:getInactiveConePosition(origin)
    return origin == "left" and -34 or self.width + 6
end

---Changes the state that the dogcones are in, or does nothing if they are already in that state.
---@param state boolean|string  The state to change the dogcones to. Certain string values i.e. `active/inactive` and `on/off` are accepted as well as booleans.
---@param options table         A table of values that affect the state change. Valid options are: `instant`, `frames`, and `origin`.   
function DogConeGroup:setConesState(state, options)
    local old = self.solid
    local new

    local statedict = {
        inactive    = false ,
        active      = true  ,
        on          = true  ,
        off         = false ,
    }

    if type(state) == "string" then
        new = statedict[state]
    elseif type(state) == "boolean" then
        new = state
    end

    assert(type(new) == "boolean", "Attempt to set state to unexpected value '" .. tostring(new) .. "'")

    if old == new then return end

    options = options or {}

    local frames = options["frames"] or self.transition_frames

    local origin = options["origin"] or self.cone_origin
    self:assertOrigin(origin)

    local instant = options["instant"] or false


    for i, cone in ipairs(self.cones) do
        local target_x = not new and self:getInactiveConePosition(origin) or self:getActiveConePosition(i)
        if instant then
            cone.x = target_x

        else
            cone:slideTo(target_x, cone.y, frames/30)

        end
    end

    self.solid = new
    self:setFlag("mystate", new)
end

function DogConeGroup:onInteract(player, dir)
    if not self.solid then
        return true
    end

    local interact = self:getFlag("interact", 0)

    if interact > 3 then
        Assets.playSound("snd_pombark", 1, Utils.pick({1, 1, 1, 1, 1, 1, 1, Utils.random(0.6, 1.6)}))

    else
        Assets.playSound("snd_pombark")

    end

    self:setFlag("interact", interact + 1)

    return true
end

---It's technically not necessary to check the origin format,
---and anything that isn't `"left"` would be treated as right,
---but this thought just horrifies me so I had to make sure
---that the code WILL get angry if you don't specify `"right"`.
---@param origin any
function DogConeGroup:assertOrigin(origin)
    assert(type(origin) == "string" and (origin == "left" or origin == "right"), "Cone group origin must be 'left' or 'right', but was '" .. origin .. "' instead.")
end

return DogConeGroup