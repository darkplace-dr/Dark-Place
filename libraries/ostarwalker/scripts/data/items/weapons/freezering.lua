local item, super = Class("freezering", true)

function item:init()
    super.init(self)

    self.reactions["ostarwalker"] = "I don't             have fingers"    
    
end

return item