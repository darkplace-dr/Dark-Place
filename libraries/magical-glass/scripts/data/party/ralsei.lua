local character, super = Class("ralsei", true)

function character:init()
    super.init(self)
    
    self.lw_portrait = Game:getConfig("ralseiStyle") == 1 and "face/ralsei_hat/smile" or "face/ralsei/smile"
    
    -- Light world base stats (saved to the save file)
    self.lw_stats = {
        health = 20,
        attack = 10,
        defense = 10,
        magic = 1
    }
    
    self.weapon = "red_scarf"
    if Game.chapter >= 2 then
        self.armor[1] = "amber_card"
        self.armor[2] = "white_ribbon"
    end
end

function character:lightLVStats()
    self.lw_stats = {
        health = self:getLightLV() == 20 and 99 or 16 + self:getLightLV() * 4,
        attack = 9 + self:getLightLV() + math.floor(self:getLightLV() / 3),
        defense = 9 + math.ceil(self:getLightLV() / 4),
        magic = self:getLightLV()
    }
end

return character