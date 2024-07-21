local character, super = Class("noelle", true)

function character:init()
    super.init(self)

    self.lw_portrait = "face/noelle/smile"
end

function character:onLevelUpLVLib()
    self:increaseStat("health", 10)
    self:increaseStat("attack", 1)
    self:increaseStat("magic", 1)
end

return character