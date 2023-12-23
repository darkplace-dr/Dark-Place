---@class GMPath
local GMPath, super = Class()

---@class GMPath.Point
---@field x number
---@field y number
---@field speed number

--

GMPath.LINEAR = 0
GMPath.CURVED = 1

--

function GMPath:init(options)
    super.init(self)

    options = options or {}

    self.type = options["type"] or GMPath.LINEAR
    self.closed = options["closed"] or false
    self.precision = options["precision"] or 4
    self:reset()
end

function GMPath:reset()
    ---@type GMPath.Point[]
    self.points = {}
    ---@type GMPath.Point[]
    self._points_int = {}
end

--

---@param x? number
---@param y? number
---@param speed? number
---@return GMPath.Point
function GMPath:createPoint(x, y, speed)
    return {
        x = x or 0,
        y = y or 0,
        speed = speed or 0,
    }
end

---@param x? number
---@param y? number
---@param speed? number
function GMPath:addInternalPoint(x, y, speed)
    table.insert(self._points_int, self:createPoint(x, y, speed))
end

---@param x? number
---@param y? number
---@param speed? number
function GMPath:addPoint(x, y, speed)
    table.insert(self.points, self:createPoint(x, y, speed))
    self:processInternal()
end

--

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

    local function handlePiece(depth, x1, y1, s1, x2, y2, s2, x3, y3, s3)
        if depth == 0 then return end

        local mx = (x1 + x2 + x2 + x3) / 4.0
        local my = (y1 + y2 + y2 + y3) / 4.0
        local ms = (s1 + s2 + s2 + s3) / 4.0

        if (x2 - x1)^2 + (y2 - y1)^2 > 16.0 then
            handlePiece(depth - 1, x1, y1, s1, (x2 + x1) / 2.0, (y2 + y1) / 2.0, (s2 + s1) / 2.0, mx, my, ms)
        end

        self:addInternalPoint(mx, my, ms)

        if (x2 - x3)^2 + (y2 - y3)^2 > 16.0 then
            handlePiece(depth - 1, mx, my, ms, (x3 + x2) / 2.0, (y3 + y2) / 2.0, (s3 + s2) / 2.0, x3, y3, s3)
        end
    end

    for i = 0, n do
        local point1 = self.points[(i % count) + 1]
        local point2 = self.points[((i + 1) % count) + 1]
        local point3 = self.points[((i + 2) % count) + 1]

        handlePiece(
            self.precision,
            (point1.x + point2.x) / 2.0, (point1.y + point2.y) / 2.0, (point1.speed + point2.speed) / 2.0,
            point2.x, point2.y, point2.speed,
            (point2.x + point3.x) / 2.0, (point2.y + point3.y) / 2.0, (point2.speed + point3.speed) / 2.0
        )
    end

    if not self.closed then
        self:addInternalPoint(self.points[count].x, self.points[count].y, self.points[count].speed)
    else
        self:addInternalPoint(self._points_int[1].x, self._points_int[1].y, self._points_int[1].speed)
    end
end

function GMPath:processInternal()
    if #self.points == 0 then return end
    self._points_int = {}

    if self.type == GMPath.CURVED then
        self:createCurved()
    else
        self:createLinear()
    end
end

--

function GMPath:getPosition(pos)
    if #self._points_int < 1 then return end
    pos = pos or 0

    if pos <= 0 or #self._points_int < 2 then
        return self._points_int[1]
    end
    if pos >= 1 then
        return self._points_int[#self._points_int]
    end

    local idx = math.floor(pos * (#self._points_int - 1))
    pos = (pos * (#self._points_int - 1)) % 1

    local point_a = self._points_int[idx + 1]
    local point_b = self._points_int[idx + 2]

    return self:createPoint(
        point_a.x + pos * (point_b.x - point_a.x),
        point_a.y + pos * (point_b.y - point_a.y),
        point_a.speed + pos * (point_b.speed - point_a.speed)
    )
end

--

return GMPath