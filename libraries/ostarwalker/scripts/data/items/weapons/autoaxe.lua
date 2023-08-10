local item, super = Class("autoaxe", true)

function item:init()
    super.init(self)

    self.reactions["ostarwalker"] = "*chainsaw noises*         No"

end

return item