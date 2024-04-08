local item, super = Class("light/wristwatch", true)

function item:init()
    super.init(self)

    -- Display name
    self.short_name = "Watch"

    self.price = 300
end

return item