local character, super = Class("susie", true)

function character:init()
    super.init(self)
    
    -- Light world portrait in the menu (saved to the save file)
    self.lw_portrait = Game:getConfig("susieStyle") == 1 and "face/susie/bangs_smile" or "face/susie/smile"

    self.lw_health = 30
    -- Light world base stats (saved to the save file)
    self.lw_stats = {
        health = 30,
        attack = 12,
        defense = 10,
        magic = 1
    }

    -- Default light world equipment item IDs (saves current equipment)
    self.lw_weapon_default = "light/toothbrush"
    self.lw_armor_default = "light/bandage"

end

function character:lightLVStats()
    self.lw_stats = {
        health = self:getLightLV() <= 20 and math.min(25 + self:getLightLV() * 5,99) or 25 + self:getLightLV() * 5,
        attack = 10 + self:getLightLV() * 2 + math.floor(self:getLightLV() / 4),
        defense = 9 + math.ceil(self:getLightLV() / 4),
        magic = math.ceil(self:getLightLV() / 4)
    }
end

return character