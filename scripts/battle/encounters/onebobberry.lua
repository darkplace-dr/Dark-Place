local OneBobberry, super = Class(Encounter)

function OneBobberry:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Bobberry is your first encounter."

    -- Battle music ("battle" is rude buster)
    self.music = "smtbattle"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the dummy enemy to the encounter
    self:addEnemy("bobberry")
	
    --- Uncomment this line to add another!
    --self:addEnemy("dummy")
end

function OneBobberry:onBattleEnd()
  Game:setFlag("tookberry", false)
  Game:setFlag("first_bobberry", true)
end

function OneBobberry:onReturnToWorld(events)
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

return OneBobberry