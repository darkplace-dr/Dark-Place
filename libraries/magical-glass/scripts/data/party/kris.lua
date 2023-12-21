local character, super = Class("kris", true)

function character:init()
    super.init(self)
    
    self.weapon = "wood_blade"
    if Game.chapter >= 2 then
        self.armor[1] = "amber_card"
        self.armor[2] = "amber_card"
    end
end

return character