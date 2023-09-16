local Zero, super = Class(Encounter)

function Zero:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "[wait:20]* \"The Dragon\" begins planning."
    --self.text = "* Testing start!"

    -- Battle music ("battle" is rude buster)
    self.music = "zero_boss"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the Zero enemy to the encounter
    self:addEnemy("zero", 550, 216)

    --- Uncomment this line to add another!
    --self:addEnemy("Dummy")


    self.timebulletmult = 1

    --leader = Game.battle.party[1]
    -- Only reason this should happen is if someone debugs into the fight.

end

function Zero:createSoul(x, y)
    local soul = ChronosSoul(x, y)
    return soul
    
end

function Zero:update()
    --[[
    --]]
    super:update(self)
end

--
function Zero:beforeStateChange(old, new)
    if old == "INTRO" and new == "ACTIONSELECT" then
        Game.battle:startCutscene("zero", "start")
    end
end
--]]

--[[
function Zero:onBattleStart()
    Game.battle:startCutscene("zero", "start")
end
--]]

--[[
function Zero:onStateChange(old, new)
    if new == "DEFENDING" then
        Game.battle:returnToWorld()
        Game.world:loadMap("misc/dogcheck")
    end
end
--]]

return Zero