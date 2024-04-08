local wave, super = Class(Wave)

function wave:init()
    super.init(self)
    self.time = 1/60
end

return wave