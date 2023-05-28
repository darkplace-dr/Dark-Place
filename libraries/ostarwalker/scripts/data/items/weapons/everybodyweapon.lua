local item, super = Class("everybodyweapon", true)

function item:init()
    super:init(self)

    self.reactions["ostarwalker"] = "This                   could work"    
    
end

return item