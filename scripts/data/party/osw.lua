local character, super = Class("ostarwalker", true)

function character:init()
    super.init(self)

    self.lw_portrait = "face/starwalker/neutral"
end

function character:getStarmanTheme() return "starwalker" end

return character