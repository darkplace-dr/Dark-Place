---@class GMPath : Class
---@overload fun(...) : GMPath
local GMPath = Class()

-- Define constants for different path types.
GMPath.TYPE_LINEAR = 0
GMPath.TYPE_CURVED = 1

----------

--- Initialize a new GMPath instance with the given options.
---@param options table Optional parameters for path configuration.
function GMPath:init(options)
    options = options or {}

    -- Set path properties based on the provided options or use default values.
    self.type = options["type"] or GMPath.TYPE_LINEAR
    self.closed = options["closed"] or false
    self.precision = options["precision"] or 4
    -- Initialize points and internal points.
    self:clear()
end

--- Clear all points and internal points in the path.
function GMPath:clear()
    self.points = {}
    self.intpoints = {}
end

----------

--- Create a new path point with the given coordinates and speed.
---@param x number X-coordinate of the point.
---@param y number Y-coordinate of the point.
---@param speed number Speed associated with the point.
---@return table point new point table with x, y, and speed properties.
function GMPath:createPoint(x, y, speed)
    return
    {
        x = x or 0,
        y = y or 0,
        speed = speed or 0,
    }
end

--- Add an internal point to the path.
---@param x number X-coordinate of the internal point.
---@param y number Y-coordinate of the internal point.
---@param speed number Speed associated with the internal point.
function GMPath:addInternalPoint(x, y, speed)
    table.insert(self.intpoints, self:createPoint(x, y, speed))
end

--- Add a point to the path.
---@param x number X-coordinate of the new point.
---@param y number Y-coordinate of the new point.
---@param speed number Speed associated with the new point.
function GMPath:addPoint(x, y, speed)
    table.insert(self.points, self:createPoint(x, y, speed))
    self:processInternal()
end

--- Change the coordinates and speed of an existing point in the path.
---@param idx number Index of the point to be changed.
---@param x number New X-coordinate of the point.
---@param y number New Y-coordinate of the point.
---@param speed number New speed associated with the point.
function GMPath:changePoint(idx, x, y, speed)
    if idx < 1 or idx >= #self.points then return end

    self.points[idx].x = x
    self.points[idx].y = y
    self.points[idx].speed = speed

    self:processInternal()
end

--- Delete a point from the path.
---@param idx number Index of the point to be deleted.
function GMPath:deletePoint(idx)
    if idx < 1 or idx >= #self.points then return end

    table.remove(self.points, idx)

    self:processInternal()
end

--- Insert a new point at a specific index.
---@param idx number Index at which the new point should be inserted.
---@param x number X-coordinate of the new point.
---@param y number Y-coordinate of the new point.
---@param speed number Speed associated with the new point.
function GMPath:insertPoint(idx, x, y, speed)
    if idx < 1 or idx > #self.points then return end

    table.insert(self.points, idx, self:createPoint(x, y, speed))

    self:processInternal()
end

--- Append the points of another path to the current path.
---@param path GMPath The path to be appended.
function GMPath:append(path)
    if not path or #path.points == 0 then return end

    for i = 1, #path.points do
        table.insert(self.points, path.points[i])
    end

    self:processInternal()
end

----------

--- Process internal points based on the path type (linear or curved).
function GMPath:processInternal()
    if #self.points == 0 then return end
    self.intpoints = {}

    if self.type == GMPath.TYPE_CURVED then
        self:createCurved()
    else
        self:createLinear()
    end
end

--- Create internal points for a linear path.
function GMPath:createLinear()
    for i = 1, #self.points do
        local point = self.points[i]
        self:addInternalPoint(point.x, point.y, point.speed)
    end

    if self.closed then
        local point = self.points[1]
        self:addInternalPoint(point.x, point.y, point.speed)
    end
end

--- Recursively handle pieces for curved paths using subdivision.
---@param depth number Recursion depth.
---@param x1 number X-coordinate of the first control point.
---@param y1 number Y-coordinate of the first control point.
---@param s1 number Speed of the first control point.
---@param x2 number X-coordinate of the second control point.
---@param y2 number Y-coordinate of the second control point.
---@param s2 number Speed of the second control point.
---@param x3 number X-coordinate of the third control point.
---@param y3 number Y-coordinate of the third control point.
---@param s3 number Speed of the third control point.
function GMPath:handlePiece(depth, x1, y1, s1, x2, y2, s2, x3, y3, s3)
    if depth == 0 then return end

    local mx = (x1 + x2 + x2 + x3) / 4.0
    local my = (y1 + y2 + y2 + y3) / 4.0
    local ms = (s1 + s2 + s2 + s3) / 4.0

    if (x2 - x1)^2 + (y2 - y1)^2 > 16.0 then
        self:handlePiece(depth - 1, x1, y1, s1, (x2 + x1) / 2.0, (y2 + y1) / 2.0, (s2 + s1) / 2.0, mx, my, ms)
    end

    self:addInternalPoint(mx, my, ms)

    if (x2 - x3)^2 + (y2 - y3)^2 > 16.0 then
        self:handlePiece(depth - 1, mx, my, ms, (x3 + x2) / 2.0, (y3 + y2) / 2.0, (s3 + s2) / 2.0, x3, y3, s3)
    end
end

--- Create internal points for a curved path.
function GMPath:createCurved()
    local n = 0
    local count = #self.points

    if count == 0 then return end

    if not self.closed then
        self:addInternalPoint(self.points[1].x, self.points[1].y, self.points[1].speed)
    end

    if self.closed then
        n = count - 1
    else
        n = count - 3
    end

    for i = 0, n do
        local point1 = self.points[(i % count) + 1]
        local point2 = self.points[((i + 1) % count) + 1]
        local point3 = self.points[((i + 2) % count) + 1]

        self:handlePiece(self.precision,
            (point1.x + point2.x) / 2.0, (point1.y + point2.y) / 2.0, (point1.speed + point2.speed) / 2.0,
            point2.x, point2.y, point2.speed,
            (point2.x + point3.x) / 2.0, (point2.y + point3.y) / 2.0, (point2.speed + point3.speed) / 2.0
        )
    end

    if not self.closed then
        self:addInternalPoint(self.points[count].x, self.points[count].y, self.points[count].speed)
    else
        self:addInternalPoint(self.intpoints[1].x, self.intpoints[1].y, self.intpoints[1].speed)
    end
end

----------

--- Get the position along the path based on a normalized parameter.
---@param pos number Normalized position along the path (0 to 1).
---@return table Point table representing the position on the path.
function GMPath:getPosition(pos)
    if #self.intpoints < 1 then return end
    pos = pos or 0

    if pos <= 0 or #self.intpoints < 2 then
        return self.intpoints[1]
    end
    if pos >= 1 then
        return self.intpoints[#self.intpoints]
    end

    local idx = math.floor(pos * (#self.intpoints - 1))
    pos = (pos * (#self.intpoints - 1)) % 1

    local point_a = self.intpoints[idx + 1]
    local point_b = self.intpoints[idx + 2]

    return self:createPoint(
        point_a.x + pos * (point_b.x - point_a.x),
        point_a.y + pos * (point_b.y - point_a.y),
        point_a.speed + pos * (point_b.speed - point_a.speed)
    )
end

--- Get the center point of the path.
---@return table Point table representing the center of the point.
function GMPath:getCenter()
	local xmin = 100000000
	local xmax = -100000000
	local ymin = 100000000
	local ymax = -100000000

    for i = 1, #self.points do
        if self.points[i].x < xmin then xmin = self.points[i].x end
        if self.points[i].x > xmax then xmax = self.points[i].x end
        if self.points[i].y < ymin then ymin = self.points[i].y end
        if self.points[i].y > ymax then ymax = self.points[i].y end
    end

    return self:createPoint((xmin + xmax) / 2, (ymin + ymax) / 2, 0)
end

--- Set the path type (linear or curved).
---@param type number The type of the path (GMPath.TYPE_LINEAR or GMPath.TYPE_CURVED).
function GMPath:setType(type)
    self.type = type and (type == GMPath.TYPE_LINEAR or type == GMPath.TYPE_CURVED) and type or GMPath.TYPE_LINEAR
    self:processInternal()
end

--- Set whether the path is closed or not.
---@param closed boolean Whether the path should be closed or not.
function GMPath:setClosed(closed)
    self.closed = closed or false
    self:processInternal()
end

--- Set the precision of the path.
---@param precision number The precision of the path (clamped between 0 and 8).
function GMPath:setPrecision(precision)
    self.precision = Utils.clamp(precision or 4, 0, 8)
    self:processInternal()
end

----------

--- Shift all points in the path by the specified offsets.
---@param xoff number X-offset to shift the points.
---@param yoff number Y-offset to shift the points.
function GMPath:shift(xoff, yoff)
    for i = 1, #self.points do
        self.points[i].x = self.points[i].x + xoff
        self.points[i].y = self.points[i].y + yoff
    end

    self:processInternal()
end

--- Reverse the order of points in the path.
function GMPath:reverse()
    if #self.points < 1 then return end

    self.points = Utils.reverse(self.points)
    self:processInternal()
end

--- Mirror the path horizontally relative to its center.
function GMPath:mirror()
    local center = self:getCenter()
    self:shift(-center.x, -center.y)

    for i = 1, #self.points do
        self.points[i].x = -self.points[i].x
    end

    self:shift(center.x, center.y)
    self:processInternal()
end

--- Flip the path vertically relative to its center.
function GMPath:flip()
    local center = self:getCenter()
    self:shift(-center.x, -center.y)

    for i = 1, #self.points do
        self.points[i].y = -self.points[i].y
    end

    self:shift(center.x, center.y)
    self:processInternal()
end

--- Rotate the path by a specified angle (in degrees) around its center.
---@param amount number The angle of rotation in degrees.
function GMPath:rotate(amount)
    if not amount then return end

    local center = self:getCenter()
    self:shift(-center.x, -center.y)

    for i = 1, #self.points do
        local x = self.points[i].x
        local y = self.points[i].y

        local th = math.rad(amount)

        self.points[i].x = (x * math.cos(th)) + (y * math.sin(th))
        self.points[i].y = (y * math.cos(th)) - (x * math.sin(th))
    end

    self:shift(center.x, center.y)
    self:processInternal()
end

--- Scale the path by specified factors along the X and Y axes.
---@param x number The scaling factor along the X-axis.
---@param y number The scaling factor along the Y-axis.
function GMPath:scale(x, y)
    local center = self:getCenter()
    self:shift(-center.x, -center.y)

    for i = 1, #self.points do
        self.points[i].x = self.points[i].x * (x or 1)
        self.points[i].y = self.points[i].y * (y or 1)
    end

    self:shift(center.x, center.y)
    self:processInternal()
end

----------

return GMPath