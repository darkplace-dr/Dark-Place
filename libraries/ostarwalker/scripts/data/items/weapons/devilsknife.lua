local item, super = Class("devilsknife", true)

function item:init()
    super.init(self)

    self.reactions["ostarwalker"] = "This scythe is Pissing me off..."
    
end

return item