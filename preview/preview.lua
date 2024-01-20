local preview = {}

---@class DPPreview.MiniAudio : Class
---@field cond fun():boolean
local MiniAudio = Class()
function MiniAudio:init(file, cond)
    self.file = file
    self.started = false
    self.cond = cond
end
function MiniAudio:initStream()
    if self.stream then return end
    self.stream = love.audio.newSource(self.file, "stream")
end
function MiniAudio:play()
    self:initStream()
    self.stream:play()
    self.started = true
end
function MiniAudio:stop()
    if self.stream then
        self.stream:stop()
    end
    self.started = false
end
function MiniAudio:setCondition(cond)
    self.cond = cond
end
function MiniAudio:update()
    if not self.cond then return end
    local result = self:cond()
    if result and not self.started then self:play()
    elseif not result and self.started then self:stop() end
end

function preview:init(mod, button, menu)
    button:setColor(1, 1, 1)
    button:setFavoritedColor(0.9, 0.8, 1)

    self.mod_id = mod.id
    self.menu = menu or MainMenu
    self.base_path = mod.path.."/preview"

    self.particles = {}
    self.particle_timer = 0
    self.particle_timer_dess = Utils.random(1*2.2, 6.9*4*20*3, 0.25)
    self.particle_tex = love.graphics.newImage(self.base_path.."/star.png")
    self.particle_tex_dess = love.graphics.newImage(self.base_path.."/dess.png")

    self.swellow = nil
    self.swellow_timer = 0

    self.sounds = {}
    self.sounds.paul = MiniAudio(self.base_path.."/paul.ogg", function() return self:isNameChosen("PAUL") end)
    self.sounds.croak = MiniAudio(self.base_path.."/croakreverb.ogg", function() return self:isNameChosen("YOU") end)
end

function preview:update()
    local to_remove = {}
    for _,particle in ipairs(self.particles) do
        particle.radius = particle.radius - DT
        particle.y = particle.y - particle.speed * (DTMULT * (particle.type ~= "dess" and 2 or 6))

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
        table.insert(self.particles, {
            type = "star",
            radius = radius, max_radius = radius,
            x = Utils.random(SCREEN_WIDTH), y = SCREEN_HEIGHT + radius,
            speed = Utils.random(0.5, 1)
        })
    end

    self.particle_timer_dess = Utils.approach(self.particle_timer_dess, 0, DT)
    if self.particle_timer_dess <= 0 then
        self.particle_timer_dess = Utils.random(1*2.2, 6.9*4*20*3, 0.25)
        table.insert(self.particles, {
            type = "dess",
            radius = 12, max_radius = 12,
            x = Utils.random(SCREEN_WIDTH), y = SCREEN_HEIGHT + 12,
            speed = Utils.random(0.5, 1)
        })
    end

    if self:isNameChosen("SWELLOW", true) then
        if not self.swellow then
            self.swellow = love.graphics.newImage(self.base_path.."/swellow.png")
        end
        self.swellow_timer = self.swellow_timer + DT
    else
        self.swellow_timer = 0
    end

    for _,sound in pairs(self.sounds) do sound:update() end
end

function preview:draw()
    if self.fade <= 0 then return end

    for _,particle in ipairs(self.particles) do
        local alpha = (particle.radius / particle.max_radius) * self.fade

        love.graphics.setColor(1, 1, 1, alpha)
        love.graphics.draw(particle.type ~= "dess" and self.particle_tex or self.particle_tex_dess, particle.x, particle.y, particle.radius)
    end

    --[[love.graphics.setColor(1, 1, 1, 0.1)
    love.graphics.setFont(Assets.getFont("smallnumbers"))
    love.graphics.print(tostring(math.floor(self.particle_timer_dess/60*100)/100), 10, 10)]]
    love.graphics.setColor(1, 1, 1)

    if self:isNameChosen("SWELLOW", true) and self.swellow then
        local alpha = math.min((self.swellow_timer - 1.8) * 0.2, 0.8)
        local naming_screen = self:getNamingScreen()
        local xs_inc = math.max(0, (self.swellow_timer - 3) * 0.02 + naming_screen.whiten)
        love.graphics.setColor(1, 1, 1, alpha)
        love.graphics.draw(self.swellow,
            SCREEN_WIDTH/2, SCREEN_HEIGHT/2-30, 0,
            2 + xs_inc, 2,
            self.swellow:getWidth()/2, self.swellow:getHeight()/2
        )
    end
end

function preview:areWeSelected()
    return self.menu.selected_mod and self.menu.selected_mod.id == self.mod_id
end

---@return FileNamer?
function preview:getNamingScreen()
    if not self:areWeSelected() then return nil end
    return
        self.menu.naming_screen
        or (self.menu.file_name_screen and self.menu.file_name_screen.file_namer)
end

function preview:isNameChosen(name, include_fadeout)
    local naming_screen = self:getNamingScreen()
    return naming_screen
        and string.upper(naming_screen.name) == string.upper(name)
        and (
            naming_screen.state == "CONFIRM"
            or (include_fadeout and naming_screen.state == "FADEOUT")
        )
end

return preview