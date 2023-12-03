local Rudinn, super = Class(Encounter)

function Rudinn:init()
    super.init(self)

    self.text = "* Rudinn drew near!"

    self.music = "battle"
    self.background = true

    self:addEnemy("rudinn")
	
	self.first_turn = true

    -- Enables the purple grid battle background
    self.background = false
	self.hide_world = true
end

function Rudinn:onBattleInit()
	self.bg = FrostBG({1, 1, 1})
	Game.battle:addChild(self.bg)
end

function Rudinn:onReturnToWorld(events)
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

function Rudinn:onTurnStart()
	if not self.first_turn then
		for _,battler in ipairs(Game.battle.party) do
			if not (battler.chara:checkArmor("heatarmor") or battler.chara.frost_resist) then
				if battler.chara.health > math.ceil(battler.chara:getStat("health") / 10) then
					battler:hurt(math.ceil(battler.chara:getStat("health") / 10), true, {167/255, 255/255, 255/255})
					battler.hit_count = battler.hit_count + 1
				else
					if battler.chara.health > 1 then
						battler:hurt(battler.chara.health - 1, true, {167/255, 255/255, 255/255})
						battler.hit_count = battler.hit_count + 1
					end
				end
			end
		end
	end
	self.first_turn = false
end

return Rudinn