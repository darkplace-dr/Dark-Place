local ShadowMen, super = Class(Encounter)

function ShadowMen:init()
    super.init(self)

    self.text = "* The shawdowmen blends into the battle!"

    self.music = "battle"
    self.background = true

    self:addEnemy("shadowman")
    self:addEnemy("shadowman")
end

function ShadowMen:onStateChange(old, new)
    if old == "INTRO" then
        Game.battle.music:setPitch(0.7)
    end
end

return ShadowMen