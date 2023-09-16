local Zero, super = Class(Encounter)

function Zero:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* You're not supposed to be here yet!"
    --self.text = "* Testing start!"

    -- Battle music ("battle" is rude buster)
    self.music = "zero_boss"
    --self.music = nil
    -- Enables the purple grid battle background
    self.background = true

    -- Add the Zero enemy to the encounter
    self:addEnemy("zero", 550, 216)
    --self:addEnemy("Dummy")

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

function Zero:onStateChange(old, new)
    if new == "DEFENDING" then
        Game.battle:returnToWorld()
        Game.world:loadMap("misc/dogcheck")
    end
end

return Zero