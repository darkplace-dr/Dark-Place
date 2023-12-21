local item, super = Class("light/glass", true)

function item:init()
    super.init(self)

    self.can_sell = false
    self.result_item = "light/glass"
end

return item