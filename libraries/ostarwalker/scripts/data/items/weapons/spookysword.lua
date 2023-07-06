local item, super = Class("spookysword", true)

function item:init()
    super.init(self)

    
    self.reactions["ostarwalker"] = "Too           spooky"

end

return item