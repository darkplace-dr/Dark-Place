local Ballfest, super = Class(Encounter)

function Ballfest:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* It's a spherical shindig."

    -- Battle music ("battle" is rude buster)
    self.music = "smtbattle"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
    self:addEnemy("bobberry")
	self:addEnemy("balldude")
	self:addEnemy("bobberry")
	
    --- Uncomment this line to add another!
    --self:addEnemy("dummy")
	
	self.flee = false
end

function Ballfest:onBattleEnd()
  --if Game.battle.used_violence then
  --  Game:setFlag("tooksusieadvice", true)
  --end
  Game:setFlag("tookberry", false)
end

function Ballfest:onTurnEnd()
--  if Game.battle.used_violence then
--    Game:setFlag("tooksusieadvice", true)
--  end
--  Game:setFlag("tookberry", false)
	Game:setFlag("racket1", false)
	Game:setFlag("racket2", false)
end

function Ballfest:onReturnToWorld(events)
  -- check whether the enemies were killed
  if Game.battle.killed then
      -- run this code for each event in the table
      for _,event in ipairs(events) do
          for _,event in ipairs(event:getGroupedEnemies(true)) do
              -- set a 'dont_load' flag to true for the event,
              -- which is a special flag that will prevent the event from loading
              event:setFlag("dont_load", true)
          end
      end
  end
end

return Ballfest
