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
    self.zero = self:addEnemy("zero", 550, 216)

    --- Uncomment this line to add another!
    --self:addEnemy("Dummy")


    self.zero_downed = false

    self.endfight = false
	
	self.flee = false


    self.boss_rush = false
	
    if Game:getFlag("zero_defeated") == true then
        self.boss_rush = true
    end

end


function Zero:onBattleInit()
    super.onBattleInit(self)
    if self.boss_rush then
        Game.battle.dojo_bg = DojoBG({1, 1, 1})
        Game.battle:addChild(Game.battle.dojo_bg)
    end
end

function Zero:createSoul(x, y)
    local soul = Soul(x, y)
    soul.force_timeslow = true
    return soul
end

function Zero:beforeStateChange(old, new)
    if old == "INTRO" and new == "ACTIONSELECT" then
        Game.battle:startCutscene("zero", "start")
    end

    if new == "DEFENDINGBEGIN" and self.zero.downed == true then
        self.zero_downed = true
        if self.endfight == true then
            Game.battle:setState("VICTORY")
        elseif Game.battle:hasCutscene() then
            Game.battle:setState("CUTSCENE")
        else
            Game.battle:setState("ACTIONSELECT")
        end
    end
end
--[[
function Zero:onStateChange(old, new)
    if new == "DEFENDING" then
        Game.battle:returnToWorld()
        Game.world:loadMap("misc/dogcheck")
    end
end
--]]

return Zero
