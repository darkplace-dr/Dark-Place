local character, super = Class("noelle", true)

function character:init()
    super.init(self)

    self.lw_health = 20

    self.lw_stats = {
        health = 20,
        attack = 8,
        defense = 0,
        magic = 5
    }
end 

return character