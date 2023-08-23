local Darkness, super = Class(Object)

function Darkness:init(alpha)
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    -- above everything, including ui, by default
    -- if you want it to be below ui, set its layer
    self.layer = 1000

    -- parallax set to 0 so it's always aligned with the camera
    self:setParallax(0, 0)
    -- don't allow debug selecting
    self.debug_select = false

    self.alpha = alpha or 1
    self.overlap = Kristal.getLibConfig("darkness", "overlap")
end

function Darkness:draw()
    local canvas = Draw.pushCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)
    love.graphics.setColor(1-self.alpha, 1-self.alpha, 1-self.alpha)
    love.graphics.rectangle("fill",0,0,SCREEN_WIDTH,SCREEN_HEIGHT)
    if self.overlap then
        love.graphics.setBlendMode("add")
    else
        love.graphics.setBlendMode("lighten", "premultiplied")
    end
    for _,light in ipairs(Game.stage:getObjects(LightSource)) do
        if light:isFullyVisible() then
            local x, y = light:getRelativePos(0,0, self)
            local color = Utils.copy(light.color)
            local alpha = color[4] or light.alpha
            local radius = light:getRadius()

            if light.style == "solid" then
                love.graphics.setColor(Utils.lerp({0,0,0}, color, alpha))
                love.graphics.circle("fill", x, y, radius)
            elseif light.style == "soft" then
                love.graphics.setColor(Utils.lerp({0,0,0}, color, alpha))
                love.graphics.circle("fill", x, y, radius)
                love.graphics.setColor(Utils.lerp({0,0,0}, color, alpha/2))
                if light.extend then
                    love.graphics.circle("fill", x, y, radius + light.extend)
                else
                    love.graphics.circle("fill", x, y, radius*1.3)
                    love.graphics.setColor(Utils.lerp({0,0,0}, color, alpha/4))
                    love.graphics.circle("fill", x, y, radius*1.6)
                    love.graphics.setColor(Utils.lerp({0,0,0}, color, alpha/6))
                    love.graphics.circle("fill", x, y, radius*1.9)
                    love.graphics.setColor(Utils.lerp({0,0,0}, color, alpha/8))
                    love.graphics.circle("fill", x, y, radius*2.2)
                end
            end
        end
    end
    for _,light in ipairs(Game.stage:getObjects(RectangleLightSource)) do
        if light:isFullyVisible() then
            local x, y = light:getRelativePos(0,0, self)
            local color = Utils.copy(light.color)
            local alpha = color[4] or light.alpha
            local w, h = light:getSize()

            if light.style == "solid" then
                love.graphics.setColor(Utils.lerp({0,0,0}, color, alpha))
                love.graphics.rectangle("fill", x, y, w, h)
            elseif light.style == "soft" then
                local extend = light.extend
                if not extend then
                    extend = math.min(w/2, h/2)
                end
                love.graphics.setColor(Utils.lerp({0,0,0}, color, alpha))
                love.graphics.rectangle("fill", x, y, w, h)
                love.graphics.setColor(Utils.lerp({0,0,0}, color, alpha/2))
                love.graphics.rectangle("fill", x-extend, y-extend, w+extend*2, h+extend*2)
            end
        end
    end
    love.graphics.setBlendMode("alpha")
    Draw.popCanvas()

    love.graphics.setBlendMode("multiply", "premultiplied")
    love.graphics.setColor(1,1,1)
    love.graphics.draw(canvas)
    love.graphics.setBlendMode("alpha")
end

return Darkness