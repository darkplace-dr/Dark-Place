local encounter, super = Class(LightEncounter)

function encounter:init()
    super:init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "[font:main_mono,15]* But nobody came."

    -- Is a "But Nobody Came"/"Genocide" Encounter
    self.nobody_came = true

    self.music = nil
end

function encounter:onBattleStart()
    Game.world.music:stop()
    Game.world.music:resume()
    Game.world.music:play("toomuch", 1)
end

return encounter