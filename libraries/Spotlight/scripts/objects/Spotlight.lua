--[[
todo:
DONE    test custom shaders
DONE    rework hitboxes/selectboxes
DONE getter/setter
DONE reimplement DojoEncounter
DONE reimplement event spotlight
DONE reimplement battle example
DONE rewrite actor spotlight data

maybe get rid of examples/move them to own stuff
]]

local Spotlight, super = Class(Object, "Spotlight")

local TRIANGLE_MESH = love.graphics.newMesh(
    {
        {0,0, 0.5,0.0, 1,1,1,1},
        {0,1, 0.0,1.0, 1,1,1,1},
        {1,0, 1.0,1.0, 1,1,1,1},
    }, "triangles", "static")

local BASIC_SPOTLIGHT_SHADER = love.graphics.newShader([[
uniform vec4 top_color;
uniform vec4 bottom_color;

#ifdef VERTEX
vec4 position(mat4 transform, vec4 vertexPosition) {
    return transform * vertexPosition;
}
#endif

#ifdef PIXEL
vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords){
    // triangle width/height stored in texture_coords
    float h = texture_coords.y;
    return color * mix(top_color, bottom_color, h);
}
#endif 
]])

--spawns a spotlight underlay focusing at x,y with the optional properties `options`:
--[[
options = {
    width = 80, --beam width at bottom and base
    
    beam_height = 200, --height of beam,
    source_x = 0, --top of beam x, 
    source_y = 0, --top of beam y, 
    lock_source = false, --if true, keep top/apex position on move, otherwise move top/apex with spotlight

    offset_x = 0, --x offset of entire spotlight
    offset_y = 0, --y offset of entire spotlight

    top_color = {1,1,1, 0.0}, --color of top of beam
    bottom_color = {1,1,1, 0.25}, --color of bottom of beam
    base_color = {0.5,0.5,0.5, 1}, --color of circular base

    shader = "shader_code", --custom shader code to apply to beam
    shader_fields = {"top_color", "bottom_color"} --values of self[<field>] or self.shader_data[<field>] that are passed into shader
    shader_data = {<...>} --table that gets indexed into when shader_fields lookup fails on `self`. the data in the table is copied, not the refrence
}
]]
function Spotlight:init(x,y, options)


    if(options) then
        super.init(self, x + (options.offset_x or 0), y + (options.offset_y or 0))
    else
        super.init(self, x,y)
    end

    self.top_color = {1,1,1, 0.75}
    self.bottom_color = {1,1,1, 0.1}
    
    self.base_color = {0,0,0,0}
    self.base_thickness = 6

    self.width = 80
    self.height = 80
    self.source_x = nil
    self.source_y = nil

    self.lock_source = false

    self.transform = love.math.newTransform()

    self.shader = BASIC_SPOTLIGHT_SHADER
    self.shader_fields = {"top_color", "bottom_color"}
    self.shader_data = { time = 0 } --time is time elapsed, exists by default because it's a pain to implement functionally.
    self:setSource(self.x,80)
    if(options) then
        self.top_color = options.top_color or self.top_color
        self.bottom_color = options.bottom_color or self.bottom_color
        
        self.base_color = options.base_color or self.base_color
        self.base_thickness = options.base_thickness or self.base_thickness
        
        self.width = options.width or self.width

        if(options.source_y) then
            self:setSource(options.source_x or self.x, options.source_y)
        else
            self.source_x = options.source_x or self.x
            self:setHeight(options.beam_height or self.beam_height)
        end

        self.lock_source = options.lock_source or self.lock_source
        self:setShader(options.shader or self.shader, options.shader_fields or self.shader_fields)
        if(options.shader_data) then
            for k,v in pairs(options.shader_data) do
                self.shader_data[k] = v
            end
        end
    end
end

--set the top color of the beam to r,g,b,a, or, if r is a table, to that
function Spotlight:setTopColor(r,g,b,a)
    a = a or 1
    self.top_color = (type(r)=="table") and r or {r,g,b,a}
end

--returns the top color of the beam as a 4-tuple
function Spotlight:getTopColor()
    return self.top_color[1], self.top_color[2], self.top_color[3], self.top_color[4]
end

--set the bottom color of the beam to r,g,b,a, or, if r is a table, to that
function Spotlight:setBottomColor(r,g,b,a)
    a = a or 1
    self.bottom_color = (type(r)=="table") and r or {r,g,b,a}
end

--returns the bottom color of the beam as a 4-tuple
function Spotlight:getBottomColor()
    return self.bottom_color[1], self.bottom_color[2], self.bottom_color[3], self.bottom_color[4]
end

--set the base's color to r,g,b,a, or, if r is a table, to that
function Spotlight:setBaseColor(r,g,b,a)
    a = a or 1
    self.base_color = (type(r)=="table") and r or {r,g,b,a}
end

--returns the base's color as a 4-tuple
function Spotlight:getBaseColor()
    return self.base_color[1], self.base_color[2], self.base_color[3], self.base_color[4]
end

--sets the size of the base to be w units long and h units tall
function Spotlight:setBaseSize(w,h)
    self.width = w
    self.base_thickness = 2*h
    self:_recalculateGeometry()
end

--returns the size of the base as a 2-tuple
function Spotlight:getBaseSize()
    return self.width, self.base_thickness
end

--sets the height of the beam to be h units tall from the base. does not effect the x position of the beam
function Spotlight:setHeight(h)
    self.source_y = self.y - h
    self.beam_height = h
    self:_recalculateGeometry()
end

--returns the height of the beam
function Spotlight:getHeight()
    return self.beam_height
end

--returns dimmensions of the bounding rectangle of the whole spotlight
function Spotlight:getSpan()
    return self.x + self.width/2 - self.source_x, self.height
end

--sets the beams's apex to the point x,y
function Spotlight:setSource(x,y)
    self.source_x = x
    self.source_y = y
    self:_recalculateGeometry()
end

--(internal, not intended for use) corrects geometry & values to be based on the base's position and the apex's position
function Spotlight:_recalculateGeometry()
    self.beam_height = self.y - self.source_y
    self.height = self.beam_height
    if(self.height < 0) then
        self.height = math.abs(self.height)
        self:setOriginExact(self.width/2,self.base_thickness/2)
        self:setHitbox(0, 0, self.width, self.base_thickness)
    else
        self:setOriginExact(self.width/2, self.height - self.base_thickness/2)
        self:setHitbox(0, self.height - self.base_thickness, self.width, self.base_thickness)
    end

    self:_setTriangle(
        self.source_x - self.x + self.width/2, -self.beam_height,
        0, 0,
        self.width, 0
    )
end

--returns the beam's apex as an x,y tuple
function Spotlight:getSource()
    return self.source_x, self.source_y
end

--sets the position of the base. if self.lock_source is true, then the beam's apex will stay in place as well.
function Spotlight:setPosition(x,y)
    if(self.lock_source) then
        self:setSource(self.source_x, self.source_y)
    else
        self.source_x, self.source_y = self.source_x + (x - self.x), self.source_y + (y - self.y)
    end
    super.setPosition(self, x,y)
    self:_recalculateGeometry()
end

--(internal, not intended for use) sets the transform matrix that describes the triangle's geometry
function Spotlight:_setTriangle(x1,y1, x2,y2, x3,y3)
    local ox, oy = self:getOriginExact()
    self.transform:setMatrix( "row",
        x3-x1, x2-x1, 0, x1 + ox - self.width/2,
        y3-y1, y2-y1, 0, y1 + oy,
        0, 0, 1, 0,
        0, 0, 0, 1
    )
end

--returns a 6-tuple of the coordinates of the beam's triangle that should be made by the GPU
function Spotlight:_getRawTriangle()
    local x1,y1 = self.transform:transformPoint(0,0)
    local x2,y2 = self.transform:transformPoint(0,1)
    local x3,y3 = self.transform:transformPoint(1,0)
    return x1,y1, x2,y2, x3,y3
end

--returns a 6-tuple of the coordinates of the beam (1st pair is the top, 2nd is bottom left, 3rd is bottom right)
function Spotlight:getTriangle()
    local ox, oy = self:getOriginExact()
    ox, oy = self.x - ox, self.y - oy 
    local x1,y1, x2,y2, x3,y3 = self:_getRawTriangle()
    return x1+ox,y1+oy, x2+ox,y2+oy, x3+ox,y3+oy
end

--set the shader used by the beam (either string of code or love shader), vargs is the field indecies from `self` that are passed into the shader
function Spotlight:setShader(shader, ...)
    if(type(shader) == "string") then
        local ok, msg = love.graphics.validateShader(true, shader)
        if(not ok) then
            error(msg,2)
        end
        self.shader = love.graphics.newShader(shader)
    else
        self.shader = shader
    end
    
    local args = {...}
    if type(args[1]) == "table" then
        args = args[1]
    end

    self.shader_fields = {}
    for i, field in ipairs(args) do
        self.shader_fields[i] = field
    end
end

--returns the love shader asociated with the beam
function Spotlight:getShader()
    return self.shader
end

function Spotlight:update()
    super.update(self)

    if(type(self.shader_data.time)=="number")  then
        self.shader_data.time = self.shader_data.time + DT
    end
end

function Spotlight:draw()
    local old_shader = love.graphics.getShader()
 
    --since shaders can be reused, it's important that these values are sent *right* before the object is drawn
    --might be worth cacheing the `shader_data` so we dont evaluate and send at the same time?
    for _, field in ipairs(self.shader_fields) do
        local data = self[field] or 
            ( (type(self.shader_data[field]) == "function") and self.shader_data[field](self) or self.shader_data[field] )
        self.shader:send(field, data)
    end
    love.graphics.setShader(self.shader)
    love.graphics.push("transform")
    love.graphics.applyTransform(self.transform)
    
    love.graphics.draw(TRIANGLE_MESH)

    love.graphics.pop()
    love.graphics.setShader(old_shader)

    if(self.base_color[4] > 0) then
        local ox, oy = self:getOriginExact()
        love.graphics.setColor(self.base_color[1], self.base_color[2], self.base_color[3], self.base_color[4])
        love.graphics.ellipse("fill", ox, oy, self.width/2, self.base_thickness/2)
    end

    if(DEBUG_RENDER) then
        love.graphics.setColor(1,0,1,1)
        local x,y = self:getOriginExact()
        love.graphics.circle("fill", x,y, 2)
        love.graphics.rectangle("line", self:getHitbox())
    end
end

return Spotlight