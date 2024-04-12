local character, super = Class("noel", true)

function character:init()
    super.init(self)

    self.lw_portrait = "face/noel/neutral"
end

return character