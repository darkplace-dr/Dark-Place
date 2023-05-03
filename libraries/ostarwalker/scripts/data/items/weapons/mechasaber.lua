local item, super = Class("mechasaber", true)

function item:init()
    super:init(self)

    
    self.reactions["ostarwalker"] = "*aggressive clicking* Too         long"

end

return item