local character, super = Class("susie", true)

function character:init()
    super.init(self)

    self.lw_health = 30

    self.lw_stats = {
        health = 30,
        attack = 12,
        defense = 2,
        magic = 1
    }
end 

return character