local self = {}

--

self.LINEAR = 0
self.CURVED = 1

--

function self:new(options)
    options = options or {}

    local path = {
        type = options["type"] or self.LINEAR,
        closed = options["closed"] or false,
        precision = options["precision"] or 4
    }
    self:reset(path)

    return path
end

function self:reset(path)
    if not path then return end

    path.usr_points = {}
    path.int_points = {}
end

--

function self:createPoint(x, y, speed)
    return
    {
        x = x or 0,
        y = y or 0,
        speed = speed or 0,
    }
end

function self:addInternalPoint(path, x, y, speed)
    if not path then return end
    table.insert(path.int_points, self:createPoint(x, y, speed))
end

function self:addPoint(path, x, y, speed)
    if not path then return end
    table.insert(path.usr_points, self:createPoint(x, y, speed))
    self:processInternal(path)
end

--

function self:createLinear(path)
    for i = 1, #path.usr_points do
        local point = path.usr_points[i]
        self:addInternalPoint(path, point.x, point.y, point.speed)
    end

    if path.closed then
        local point = path.usr_points[1]
        self:addInternalPoint(path, point.x, point.y, point.speed)
    end
end

local function handlePiece(path, _depth, _x1, _y1, _s1, _x2, _y2, _s2, _x3, _y3, _s3)
    if _depth == 0 then return end

    local mx = (_x1 + _x2 + _x2 + _x3) / 4.0
    local my = (_y1 + _y2 + _y2 + _y3) / 4.0
    local ms = (_s1 + _s2 + _s2 + _s3) / 4.0

    if (_x2 - _x1)^2 + (_y2 - _y1)^2 > 16.0 then
        handlePiece(path, _depth - 1, _x1, _y1, _s1, (_x2 + _x1) / 2.0, (_y2 + _y1) / 2.0, (_s2 + _s1) / 2.0, mx, my, ms)
    end

    self:addInternalPoint(path, mx, my, ms)

    if (_x2 - _x3)^2 + (_y2 - _y3)^2 > 16.0 then
        handlePiece(path, _depth - 1, mx, my, ms, (_x3 + _x2) / 2.0, (_y3 + _y2) / 2.0, (_s3 + _s2) / 2.0, _x3, _y3, _s3)
    end
end
function self:createCurved(path)
    local n = 0
    local count = #path.usr_points

    if count == 0 then return end

    if not path.closed then
        self:addInternalPoint(path, path.usr_points[1].x, path.usr_points[1].y, path.usr_points[1].speed)
    end

    if path.closed then
        n = count - 1
    else
        n = count - 3
    end

    for i = 0, n do
        local point1 = path.usr_points[(i % count) + 1]
        local point2 = path.usr_points[((i + 1) % count) + 1]
        local point3 = path.usr_points[((i + 2) % count) + 1]

        handlePiece(path,
            path.precision,
            (point1.x + point2.x) / 2.0, (point1.y + point2.y) / 2.0, (point1.speed + point2.speed) / 2.0,
            point2.x, point2.y, point2.speed,
            (point2.x + point3.x) / 2.0, (point2.y + point3.y) / 2.0, (point2.speed + point3.speed) / 2.0
        )
    end

    if not path.closed then
        self:addInternalPoint(path, path.usr_points[count].x, path.usr_points[count].y, path.usr_points[count].speed)
    else
        self:addInternalPoint(path, path.int_points[1].x, path.int_points[1].y, path.int_points[1].speed)
    end
end

function self:processInternal(path)
    if not path or #path.usr_points == 0 then return end
    path.int_points = {}

    if path.type == self.CURVED then
        self:createCurved(path)
    else
        self:createLinear(path)
    end
end

--

function self:getPosition(path, pos)
    if not path or #path.int_points < 1 then return end
    pos = pos or 0

    if pos <= 0 or #path.int_points < 2 then
        return path.int_points[1]
    end
    if pos >= 1 then
        return path.int_points[#path.int_points]
    end

    local idx = math.floor(pos * (#path.int_points - 1))
    pos = (pos * (#path.int_points - 1)) % 1

    local point_a = path.int_points[idx + 1]
    local point_b = path.int_points[idx + 2]

    return self:createPoint(
        point_a.x + pos * (point_b.x - point_a.x),
        point_a.y + pos * (point_b.y - point_a.y),
        point_a.speed + pos * (point_b.speed - point_a.speed)
    )
end

--

return self