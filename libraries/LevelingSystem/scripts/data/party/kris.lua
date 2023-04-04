local character, super = Class("kris", true)

function character:init()
    super.init(self)

    self.love = 1
    if not Kristal.getLibConfig("leveling", "global_love") then
        self.level = self.love
    end

    self.max_stats = {}
end

return character