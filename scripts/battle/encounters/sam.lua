local Dummy, super = Class(Encounter)

function Dummy:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Sam sits there."

    -- Battle music ("battle" is rude buster)
    self.music = "sam"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
    self:addEnemy("sam")

    --- Uncomment this line to add another!
    --self:addEnemy("dummy")
	
	self.flee = false
end

function Dummy:onBattleEnd()
    Game:setFlag("sam_defeated", true)
end

function Dummy:update()
    super.update(self)

    for _,enemy in pairs(Game.battle.enemy_world_characters) do
        enemy:remove()
    end
end

return Dummy
