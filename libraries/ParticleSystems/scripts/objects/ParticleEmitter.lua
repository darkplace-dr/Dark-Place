-- ParticleEmitter object, used to spawn particles from a specific point
-- particles will move outwards from this point, and can be given many options on how they do so
local Emitter, super = Class("ParticleSystem")

-- arguments can be:
    -- data
    -- x, y, data
    -- x, y, width, height, data
-- if x and y are not specified, they will be set to 0, 0
-- if width and height are specified, particle positions will be randomly dispersed within the bounds specified
function Emitter:init(x, y, w, h, o)
    if type(w) == "table" then
        super:init(self, x, y, 0, 0, o)
        o = w
    elseif type(x) == "table" then
        o = x
        super:init(self, 0, 0, 0, 0, o)
    else
        super:init(self, x, y, w, h, o)
    end

    -- self.data is a table of default values for particles
    -- all fields defined in the data table will override the default values

    -- fields can be defined in several different ways,
    -- and there is an advanced parsing system in place to interpret different values
    -- each type of value can be defined in any of the following ways

    -- number:
        -- a single number value. eg: 1
        -- a table with two values, to define a random range of values. eg: {1, 2}, which will give a random value between 1 and 2
        -- a table of tables with two values each, to select between potential ranges. eg: {{1, 2}, {3, 4}}, which will give a random value between 1 and 2 or between 3 and 4
        -- a table of tables with one value each, to select between different numbers. eg: {{1}, {2}, {3}}, which will give either 1, 2, or 3
        -- a function that returns a number. eg: function(particle) return 1 end
        -- a table of functions that return numbers. eg: {function(particle) return 1 end, function(particle) return 2 end}
    
    -- string:
        -- a single string value. eg: "circle"
        -- a table of strings, to select between different strings. eg: {"circle", "square"}, which will give a random string from the list
        -- a function that returns a string. eg: function(particle) return "circle" end
        -- a table of functions that return strings. eg: {function(particle) return "circle" end, function(particle) return "square" end}

    -- boolean:
        -- a single boolean value. eg: true
        -- a function that returns a boolean. eg: function(particle) return true end

    -- color:
        -- a table of 3 or 4 values, representing RGB(A). eg: {1, 1, 1} or {1, 1, 1, 1}
        -- a table of tables with 3 or 4 values, to select between different colors. eg: {{1,1,1}, {0,0,0}}
        -- a function that returns a color. eg: function(particle) return {1, 1, 1} end

    -- function:
        -- a function that performs some action. eg: function(particle) particle.x = particle.x + DTMULT end

    -- when providing a function, the function will receive the current particle instance as an argument
    -- all values are defined for the particle in the order listed in the data table,
    -- meaning you can check previously defined values to help define new ones
    -- eg: "angle = function(particle) return particle.rotation end" will work because "rotation" is defined before "angle"
    
    -- for all number values, additional fields can be defined to further change the value
    -- these fields are defined by adding some suffix to the field name. eg: "alpha = 0.5" can have "alpha_var = 0.1"
    -- the possible additional fields are:
        -- var: specifies a random distance from the defined value. eg: "alpha = 0.5" and "alpha_var = 0.1" will give a random value between 0.4 and 0.6
        -- min_var, max_var: specifies a random distance from the defined value, but with a minimum and maximum range.
            -- eg: "alpha = 0.5" and "alpha_min_var = 0.1" and "alpha_max_var = 0.2" will give a random value between 0.3 and 0.4, or a random value between 0.6 and 0.7
        -- dist: specifies a distance from the defined value. eg: "alpha = 0.5" and "alpha_dist = 0.1" will give either 0.4 and 0.6
        -- round: specifies the nearest value to round the number to.
            -- eg: "alpha = {0.4, 0.6}" and "alpha_round = 0.1" will round a random value between 0.4 and 0.6 to the nearest 0.1
    self.data = {
        -- layer of particles emitted
        -- can be either a number or a string referring to a layer in the LAYERS table, or a table or function as specified above
        -- will also set the layer of the emitter itself if it is a number or string
        layer = "below_bullets",
        -- whether it spawns particles automatically
        -- if disabled, the emitter will only emit particles when Emitter:emit() is called
        auto = true,
        -- amount of particles to emit every time emit() is called
        amount = 1,
        -- how often to call emit() (<0 means only once)
        every = -1,
        -- how long the emitter will exist (<0 means forever)
        time = -1,

        -- texture used for the particle
        texture = "circle",
        -- path leading up to the texture
        -- can only be defined as a string, no tables or functions
        path = "particles",

        -- starting rotation of the particle (random by default)
        rotation = {0, 2*math.pi},
        -- radian amount the particle will spin per frame at 30fps
        spin = 0,

        -- color of the particle
        color = {1, 1, 1},
        -- alpha of the particle
        alpha = 1,
        -- blend mode for the particle
        blend = "alpha",

        -- scale of the particle
        scale = 1,
        scale_x = 1,
        scale_y = 1,
        -- size of the particle in pixels, overrides scale if defined
        size = nil,
        width = nil,
        height = nil,

        -- amount the particle's scale will approach its target scale upon spawning, per frame at 30fps
        -- if defined, the particle's scale will start as 0, 0
        grow = 0,
        grow_x = 0,
        grow_y = 0,
        -- amount the particle's scale will approach its end scale, per frame at 30fps
        shrink = 0,
        shrink_x = 0,
        shrink_y = 0,
        -- time to wait until the particle begins shrinking
        shrink_after = -1,
        -- scale to shrink to
        shrink_to = 0,
        shrink_to_x = 0,
        shrink_to_y = 0,

        -- amount the particle's alpha will approach its target alpha upon spawning, per frame at 30fps
        -- if defined, the particle's alpha will start as 0
        fade_in = 0,
        -- amount the particle's alpha will approach 0 per frame at 30fps
        fade = 0,
        -- time to wait until the particle begins fading
        fade_after = -1,
        -- alpha to fade to
        fade_to = 0,
        
        -- time to wait until removing the particle
        remove_after = -1,

        -- physics of the particle
        -- all physics fields can be defined directly, or they can define the table itself
        -- eg: "physics = {speed = 1}" or "speed = 1" work equally
        physics = {
            speed_x = 0,
            speed_y = 0,
            speed = 0,
            friction = 0,
            gravity = 0,
            gravity_direction = math.pi/2,
        },
        -- direction the particle will move if given speed (random by default)
        -- synonymous with "direction"
        angle = {0, math.pi*2},
        
        -- how far from the spawn position the particle should start
        dist = 0,

        -- functions to call for the particle
        -- called after all fields are defined for the particle
        init = nil, -- function(particle)
        -- called every frame, before the particle updates
        update = nil, --    ...(particle)
        -- called every frame, before the particle is drawn
        pre_draw = nil, --  ...(particle)
        -- called every frame, overriding the particle's draw function
        draw = nil, --      ...(particle, draw), passing in the original draw function. "draw" does not take any arguments
        -- called every frame, after the particle is drawn
        post_draw = nil, -- ...(particle)
        -- called when the particle is removed, overriding the particle's remove function
        remove = nil, --    ...(particle, remove), passing in a function to properly remove the particle. "remove" does not take any arguments
        
        -- whether particles should be parented to the emitter
        parent = false,
        -- whether particles should be masked to the arena
        -- alternatively, can be defined as an object that particles should be masked to
        mask = false,

        -- list of values that will be rounded to the nearest integer
        round = {
            size = true,
            width = true,
            height = true,
            amount = true,
        },
    }

    for _k,v in pairs(o) do
        -- list of names that are synonymous with others
        local convert = {
            colors = "color",
            alphas = "alpha",
            angles = "angle",
            direction = "angle",
        }
        -- list of valid suffixes that a value can have
        local suffixes = {
            "var",
            "min_var",
            "max_var",
            "dist",
            "round",
        }
        local k = _k
        local sub_i = string.find(_k, "_")
        local subj = sub_i and string.sub(_k, 1, sub_i-1)
        local suff = sub_i and string.sub(_k, sub_i+1)
        if subj and convert[subj] then
            k = convert[subj]..string.sub(_k, sub_i)
        elseif convert[k] then
            k = convert[k]
        end
        local valid_suff = Utils.containsValue(suffixes, suff)
        if self.data.physics[valid_suff and subj or k] then
            self.data.physics[k] = v
        elseif k == "round" then
            for k2,v2 in pairs(v) do
                self.data[k][k2] = v2
            end
        else
            self.data[k] = v
        end
    end
end

function Emitter:emit()
    local particles = {}
    for _=1,self:getValue("amount") do
        local x, y = self.parent:getRelativePos(self.x, self.y, self:getParent())
        if self.data.parent then x = 0; y = 0 end
        if self.width > 0 then
            x = x + love.math.random(0,self.width)
        end
        if self.height > 0 then
            y = y + love.math.random(0,self.height)
        end
        local p = Particle(self.data.path.."/"..self:getValue("texture"), x, y)
        p.rotation = self:getValue(p, "rotation")
        p.graphics.spin = self:getValue(p, "spin")
        local r,g,b,a = self:getColorValue(p)
        p.color = {r,g,b}
        p.alpha = a
        p.blend = self:getValue(p, "blend")
        local sx, sy = self:getValue(p, "scale_x"), self:getValue(p, "scale_y")
        if sx ~= 1 or sy ~= 1 then
            p:setScale(sx, sy)
        else
            p:setScale(self:getValue(p, "scale"))
        end
        local size = self:getValue(p, "size")
        if size then
            p.size = size
            p:setScale(size/math.max(p.width,p.height))
        else
            local w, h = self:getValue(p, "width"), self:getValue(p, "height")
            if w and h then
                p:setScale(w/p.width, h/p.height)
            end
        end
        local grow, grow_x, grow_y = self:getValue(p, "grow"), self:getValue(p, "grow_x"), self:getValue(p, "grow_y")
        if grow > 0 or grow_x > 0 or grow_y > 0 then
            local sx, sy = p:getScale()
            if grow > 0 then
                p:setScale(0)
            end
            if grow_x > 0 then
                p.scale_x = 0
            end
            if grow_y > 0 then
                p.scale_y = 0
            end
            self:getParent().timer:script(function(wait)
                local change = (grow_x > 0) and grow_x or grow
                if change > 0 then
                    while p.scale_x ~= sx do
                        p.scale_x = Utils.approach(p.scale_x, sx, change*DTMULT)
                        wait()
                    end
                end
            end)
            self:getParent().timer:script(function(wait)
                local change = (grow_y > 0) and grow_y or grow
                if change > 0 then
                    while p.scale_y ~= sy do
                        p.scale_y = Utils.approach(p.scale_y, sy, change*DTMULT)
                        wait()
                    end
                end
            end)
        end
        local shrink, shrink_x, shrink_y = self:getValue(p, "shrink"), self:getValue(p, "shrink_x"), self:getValue(p, "shrink_y")
        if shrink > 0 or shrink_x > 0 or shrink_y > 0 then
            self:getParent().timer:script(function(wait)
                wait(math.max(self:getValue(p, "shrink_after"), 0))
                local shrink_to = self:getValue(p, "shrink_to")
                local shrink_to_x = self:getValue(p, "shrink_to_x")
                local shrink_to_y = self:getValue(p, "shrink_to_y")
                local change_x = (shrink_x > 0) and shrink_x or shrink
                local change_y = (shrink_y > 0) and shrink_y or shrink
                if shrink_to_x == 0 then
                    shrink_to_x = shrink_to
                end
                if shrink_to_y == 0 then
                    shrink_to_y = shrink_to
                end
                while p.scale_x ~= shrink_to_x and p.scale_y ~= shrink_to_y do
                    p.scale_x = Utils.approach(p.scale_x, shrink_to_x, change_x*DTMULT)
                    p.scale_y = Utils.approach(p.scale_y, shrink_to_y, change_y*DTMULT)
                    wait()
                end
                if shrink_to_x == 0 or shrink_to_y == 0 then
                    p:remove()
                end
            end)
        end
        local fade_in = self:getValue(p, "fade_in")
        if fade_in > 0 then
            p.alpha = 0
            p.graphics.fade_to = a
            p.graphics.fade = fade_in
        end
        local fade = self:getValue(p, "fade")
        if fade > 0 then
            self:getParent().timer:after(math.max(self:getValue(p, "fade_after"), 0), function()
                local fade_to = self:getValue(p, "fade_to")
                p.graphics.fade_to = fade_to
                p.graphics.fade = fade
                if fade_to == 0 then
                    p.graphics.fade_callback = p.remove
                end
            end)
        end
        local remove = self:getValue(p, "remove_after")
        if remove > 0 then
            self:getParent().timer:after(remove, function()
                p:remove()
            end)
        end
        local angle = self:getValue(p, "angle")
        local ph = {}
        p.physics = ph
        ph.speed_x = self:getValue(p, "speed_x", self.data.physics)
        ph.speed_y = self:getValue(p, "speed_y", self.data.physics)
        ph.speed = self:getValue(p, "speed", self.data.physics)
        ph.friction = self:getValue(p, "friction", self.data.physics)
        ph.gravity = self:getValue(p, "gravity", self.data.physics)
        ph.gravity_direction = self:getValue(p, "gravity_direction", self.data.physics)
        ph.direction = angle
        local dist = self:getValue(p, "dist")
        if dist ~= 0 then
            p:setPosition(x + dist*math.cos(angle), y + dist*math.sin(angle))
        end
        p.update_func = self.data.update
        p.pre_draw_func = self.data.pre_draw
        p.draw_func = self.data.draw
        p.post_draw_func = self.data.post_draw
        p.remove_func = self.data.remove
        p.layer = self:getLayerValue(self.data.layer)
        if type(p.layer) == "string" then
            p.layer = self:getLayerValue(p.layer)
        end
        if self.data.init then
            self.data.init(p)
        end
        if self.data.parent then
            self:addChild(p)
        elseif self.data.mask then
            if isClass(self.data.mask) then
                p:addFX(MaskFX(self.data.mask))
                self:getParent():addChild(p)
            elseif Game.battle and Game.battle.mask then
                Game.battle.mask:addChild(p)
            else
                print("cannot add particle to mask")
                self:getParent():addChild(p)
            end
        else
            self:getParent():addChild(p)
        end
        table.insert(particles, p)
        table.insert(self.particles, p)
    end
    return particles
end

return Emitter