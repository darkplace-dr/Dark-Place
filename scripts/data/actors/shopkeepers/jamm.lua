local actor, super = Class(Actor, "shopkeepers/jamm")

function actor:init()
    super.init(self)

    self.name = "Jamm"

    self.width = 96
    self.height = 114

    self.path = "shopkeepers/jamm"
    self.default = "smug"

    self.offsets = {
        ["smug"] = {0, 0},
    }
end

return actor