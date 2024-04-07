BordersLib = {}
local lib = BordersLib

function lib:init()
    self.flower_positions = {
        {34, 679},
        {94, 939},
        {269, 489},
        {0, 319},
        {209, 34},
        {1734, 0},
        {1829, 359},
        {1789, 709},
        {1584, 1049}
    }
    self.idle_time = (RUNTIME * 1000)
    self.idle = false

    self.particles = {}
    self.particle_timer = 0
    self.star_tex = Assets.getTexture("effects/star")

end

function lib:preUpdate(dt)
    local to_remove = {}
    for _,particle in ipairs(self.particles) do
        particle.radius = particle.radius - DT
        particle.y = particle.y - particle.speed * (DTMULT * 2)

        if particle.radius <= 0 then
            table.insert(to_remove, particle)
        end
    end

    for _,particle in ipairs(to_remove) do
        Utils.removeFromTable(self.particles, particle)
    end

    self.particle_timer = self.particle_timer + DT
    if self.particle_timer >= 0.4 then
        self.particle_timer = 0
        local radius = Utils.random(12)
        -- Create a star on each side of the border
        table.insert(self.particles, {
            radius = radius, max_radius = radius,
            x = love.math.random(0, 200), y = SCREEN_HEIGHT+50 + radius,
            speed = Utils.random(0.5, 1)
        })
        table.insert(self.particles, {
            radius = radius, max_radius = radius,
            x = love.math.random(SCREEN_WIDTH+140, SCREEN_WIDTH+300), y = SCREEN_HEIGHT+50 + radius,
            speed = Utils.random(0.5, 1)
        })
    end
end

function lib:postUpdate(dt)
    if Input.down("left") or Input.down("right") or Input.down("up") or Input.down("down") or Input.down("confirm") or Input.down("cancel") or Input.down("menu") then
        self.idle_time = 0
        self.idle = false
    else
        if not self.idle then
            self.idle_time = RUNTIME * 1000
        end
        self.idle = true
    end
end

function lib:onBorderDraw(border_sprite)
    if border_sprite == "undertale/sepia" then

        local idle_min = 300000
        local idle_time = 0
        local current_time = RUNTIME * 1000
        if (self.idle and current_time >= (self.idle_time + idle_min)) then
            idle_time = (current_time - (self.idle_time + idle_min))
        end

        local idle_frame = (math.floor((idle_time / 100)) % 3)

        if idle_frame > 0 then
            for index, pos in pairs(self.flower_positions) do
                local x, y = (pos[1] * BORDER_SCALE), (pos[2] * BORDER_SCALE) - 1
                local round = Utils.round
                love.graphics.setBlendMode("replace")
                local flower = Assets.getTexture("borders/undertale/sepia/" .. tostring(index) .. ((idle_frame == 1) and "a" or "b"))
                love.graphics.setColor(1, 1, 1, BORDER_ALPHA)
                love.graphics.draw(flower, round(x), round(y), 0, BORDER_SCALE, BORDER_SCALE)
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.setBlendMode("alpha")
            end
        end
    end
    if border_sprite == "battle" then

        love.graphics.setColor(0, 0, 0, BORDER_ALPHA)
        love.graphics.rectangle("fill", -8, -8, SCREEN_WIDTH+16, SCREEN_HEIGHT+16)

        love.graphics.setLineStyle("rough")
        love.graphics.setLineWidth(2)

        local offset = (Kristal.getTime() * 30) % 100

        for i = 2, 22 do
            love.graphics.setColor(66 / 255, 0, 66 / 255, BORDER_ALPHA / 2)
            love.graphics.line(0, -210 + (i * 50) + math.floor(offset / 2), BORDER_WIDTH * BORDER_SCALE, -210 + (i * 50) + math.floor(offset / 2))
            love.graphics.line(-200 + (i * 50) + math.floor(offset / 2), 0, -200 + (i * 50) + math.floor(offset / 2), BORDER_HEIGHT * BORDER_SCALE)
        end

        for i = 3, 23 do
            love.graphics.setColor(66 / 255, 0, 66 / 255, BORDER_ALPHA)
            love.graphics.line(0, -100 + (i * 50) - math.floor(offset), BORDER_WIDTH * BORDER_SCALE, -100 + (i * 50) - math.floor(offset))
            love.graphics.line(-100 + (i * 50) - math.floor(offset), 0, -100 + (i * 50) - math.floor(offset), BORDER_HEIGHT * BORDER_SCALE)
        end

        love.graphics.setColor(0, 1, 0, BORDER_ALPHA)

        local width = 5

        love.graphics.setLineWidth(width)

        local left = 160 - width / 2
        local top = 30 - width / 2

        love.graphics.rectangle("line", left, top, 640 + width, 480 + width)
    end

    if border_sprite == "glow" then
        love.graphics.setColor(0, 0, 0, BORDER_ALPHA)
        love.graphics.rectangle("fill", -8, -8, SCREEN_WIDTH+16, SCREEN_HEIGHT+16)

        local offset = (Kristal.getTime() * 30)
        for i = 1, 8 do
            local width = (1 + math.sin(offset / 30)) * i * 8

            love.graphics.setLineWidth(width)
            love.graphics.setColor(0.5, 0.5, 0.5, 0.1 * BORDER_ALPHA)

            local left = 160 - width / 2
            local top = 30 - width / 2

            love.graphics.rectangle("line", left, top, 640 + width, 480 + width)
        end
    end
    if border_sprite == "stars" then
        love.graphics.setColor(0, 0, 0, BORDER_ALPHA)
        love.graphics.rectangle("fill", -8, -8, SCREEN_WIDTH+16, SCREEN_HEIGHT+16)

        for _,particle in ipairs(self.particles) do
            local alpha = (particle.radius / particle.max_radius) * BORDER_ALPHA
    
            love.graphics.setColor(1, 1, 1, alpha)
            love.graphics.draw(self.star_tex, particle.x, particle.y, particle.radius)
        end

        love.graphics.setColor(1, 1, 1, BORDER_ALPHA)
        local width = 1

        love.graphics.setLineWidth(width)

        local left = 160 - width / 2
        local top = 30 - width / 2

        love.graphics.rectangle("line", left, top, 640 + width, 480 + width)




        love.graphics.setColor(1, 1, 1)
    end
end

function lib:registerDebugOptions(debug)
    debug:registerOption("main", "Borders", "Enter the border test menu.", function() debug:enterMenu("border_menu", 1) end)

    debug:registerMenu("border_menu", "Borders")

    local borders = {
        "battle",
        "castle",
		"city",
		"cyber",
        "glow",
		"leaves",
		"mansion",
		"simple",

        "undertale/anime",
        "undertale/casino",
        "undertale/castle",
        "undertale/dog",
        "undertale/fire",
        "undertale/rad",
        "undertale/ruins",
        "undertale/sepia",
        "undertale/truelab",
        "undertale/tundra",
        "undertale/water",

        "omori/aubrey",
        "omori/basil",
        "omori/blackspace",
        "omori/default",
        "omori/defaultnomemory",
        "omori/farawayafternoon",
        "omori/farawayday",
        "omori/farawaynight",
        "omori/fear",
        "omori/hero",
        "omori/kel",
        "omori/mari",
        "omori/omori",
        "omori/omori_redhand",
        "omori/redspace",
        "omori/solidblack",
        "omori/whitespace",

        "ai_upscaled_concepts/city_a",
        "ai_upscaled_concepts/city_b",
        "ai_upscaled_concepts/city_c",
        "ai_upscaled_concepts/field",
        "ai_upscaled_concepts/world_a",
        "ai_upscaled_concepts/world_b",
        "ai_upscaled_concepts/world_c",

        "deoxynn/deep_forest",
        "deoxynn/forest",
        
        "minigames/angrybirds",

        "cloudwebs",
        "dev",
        "everhall_end",
        "everhall",
        "gildedgrove",
        "monotonecastle",
        "stars",
        "starwalkervalley",
        "vaporwave",
    }

    for _,border in ipairs(borders) do
        debug:registerOption("border_menu", border, "Switch to the border \"" .. border .. "\".", function() Game:setBorder(border) end)
    end
end


return lib