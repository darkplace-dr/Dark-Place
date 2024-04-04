local item, super = Class(Item, "blankie")

function item:init()
    super.init(self)

    self.name = "Fleece Blanket"
    self.type = "item"
    self.description = "A light blue fleece blanket with a sun and cloud pattern. What was this for again?"

    self.usable_in = "world"

    self.price = 50
end

function item:onWorldUse()
    Assets.playSound("mysterygo")
end

return item