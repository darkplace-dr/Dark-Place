local Fader, super = Class("Fader", true)

function Fader:init(...)
    super.init(self, ...)
    self.blend = "alpha"
end

function Fader:parseOptions(options, reset_values)
    super.parseOptions(self, options, reset_values)
    self.blend = options["blend"] or (reset_values and "alpha" or self.blend)
    return options
end

function Fader:draw()
    love.graphics.setBlendMode(self.blend)
    super.draw(self)
    love.graphics.setBlendMode("alpha")
end

return Fader