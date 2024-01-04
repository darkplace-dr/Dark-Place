local lines, super = Class(Object)

function lines:init(x, y)
    super.init(self, x, y)

    self:setParallax(0.05, 0)

    self.line_color = COLORS[Kristal.getLibConfig("background_cyber_lines", "line_color")] or COLORS.lime
    self.background_color = COLORS[Kristal.getLibConfig("background_cyber_lines", "background_color")] or COLORS.navy

    self.line_speed = Kristal.getLibConfig("background_cyber_lines", "line_speed") or 1
    self.glow_speed = Kristal.getLibConfig("background_cyber_lines", "glow_speed") or 1

    self.line_siner = 0

    self.line_y = {}
    for i = 1, 20 do
        self.line_y[i] = 200 + (40 * ((i-1) * (i-1)))
    end

    self.path_a = {}
    self.path_b = {}

    for i = 1, 8 do
        table.insert(self.path_a, {})
        table.insert(self.path_b, {})

        for j = 1, 6 do
            local x = ((i-1) * 20) + ((((i-1) * (j-1)) * (j-1)) * 8)
            local y = -70 * (j-1)

            table.insert(self.path_a[i], x)
            table.insert(self.path_b[i], -x)
            table.insert(self.path_a[i], y)
            table.insert(self.path_b[i], y)
        end
    end
end

local function draw_path(path, x, y)
    love.graphics.translate(x, y)
    love.graphics.line(path)
    love.graphics.translate(-x, -y)
end

function lines:draw()
    self.line_siner = self.line_siner + DTMULT * self.glow_speed

    Draw.setColor(1, 1, 1, 0.1)

    for i = 1, 19 do
        local x1 = -100
        local y1 = -50
        local x2 = Game.world.width + 100
        local y2 = y1 + ((i-1) * 15)

        Draw.setColor(Utils.mergeColor(self.background_color, COLORS.black, (i-1) * 0.05), 0.1)
        love.graphics.rectangle("fill", x1, y1, x2 - x1, y2 - y1)
    end

    Draw.setColor(self.line_color, 0.5 + (math.sin(self.line_siner / 12) * 0.1))

    love.graphics.setLineStyle("rough")
    love.graphics.setLineWidth(1)
    for i = 1, 8 do
        draw_path(self.path_a[i], 320, 320)
        draw_path(self.path_a[i], 319, 320)
        draw_path(self.path_b[i], 320, 320)
        draw_path(self.path_b[i], 321, 320)
    end

    for i = 1, 19 do
        self.line_y[i] = Utils.lerp(self.line_y[i], -400, 0.005 * DTMULT * self.line_speed)
        if self.line_y[i] <= -100 then
            self.line_y[i] = self.line_y[i] + self.line_y[20]
        end

        local x1 = -100 + self.line_y[i] / 2
        local y1 = self.line_y[i]
        local x2 = 640 + 100 - self.line_y[i] / 2
        local y2 = 600
        local radiusx = (x2 - x1) / 2
        local radiusy = (y2 - y1) / 2
        local segments = 24

        love.graphics.ellipse("line", (x1 + x2) / 2, (y1 + y2) / 2, radiusx, radiusy, segments)
    end

    local x1 = -100
    local x2 = Game.world.width + 100

    Draw.setColor(COLORS.black)
    love.graphics.rectangle("fill", x1, 240+80, x2 - x1, 240)

    super.draw(self)
end

return lines