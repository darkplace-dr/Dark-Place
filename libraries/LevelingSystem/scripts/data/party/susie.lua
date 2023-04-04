local character, super = Class("susie", true)

function character:init()
    super.init(self)

    self.love = 1
    if not Kristal.getLibConfig("leveling", "global_love") then
        self.level = self.love
    end

    self.max_stats = {}
end

function character:levelUp()
    self:increaseStat("health", 15)
    self:increaseStat("attack", 2)
    self:increaseStat("magic", 1)
    self:increaseStat("defense", 1)
    self.love = self.love + 1
    self.req_exp = self.exp_needed[self.love + 1] or 0
end

return character