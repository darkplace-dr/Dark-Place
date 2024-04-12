local character, super = Class("noelle", true)

function character:init()
    super.init(self)

    self.lw_portrait = "face/noelle/smile"
end

return character