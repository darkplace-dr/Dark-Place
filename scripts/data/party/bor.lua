local character, super = Class("bor", true)

function character:init()
    super.init(self)

    self.lw_portrait = "face/bor/confused"
end

return character