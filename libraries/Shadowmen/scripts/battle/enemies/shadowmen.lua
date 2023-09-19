local MyEnemy, super = Class(EnemyBattler)

-- function MyEnemy:selectWave()
    -- local waves = self:getNextWaves()
	
    -- if waves and #waves > 0 then
        -- local wave = Utils.pick(waves)
		
		-- while wave == self.prev_wave do
			-- wave = Utils.pick(waves)
		-- end
		
        -- self.selected_wave = wave
		-- self.prev_wave = wave
        -- return wave
    -- end
-- end

function MyEnemy:onAct(battler, name)
    if name == Kristal.getLibConfig("shadowmen", "act_name") then
        self:addMercy(50)
        return Kristal.getLibConfig("shadowmen", "act_text"):gsub('<name>', battler.chara.name)
	end
	
	return super.onAct(self, battler, name)
end

function MyEnemy:getXAction(battler)
    return Kristal.getLibConfig("shadowmen", "act_name")
end

function MyEnemy:init()
    super.init(self)
	
    self.name = Kristal.getLibConfig("shadowmen", "name")
    self:setActor("shadowmen")

    -- if Game:getPartyMember("susie"):getFlag("auto_attack") then
        -- self:registerAct("Warning")
    -- end

    -- self.susie_warned = false

    -- self.asleep = false
    -- self.become_red = false

    -- self:registerAct("Tell Story", "", {"ralsei"})
    -- self:registerAct("Red", "", {"susie"})
    -- self:registerAct("", "", nil, nil, nil, {"ui/battle/msg/dumbass"})
    -- self:registerAct("Red Buster", "Red\nDamage", "susie", 60)
    -- self:registerAct("DualHeal", "Heals\neveryone", "ralsei", 50)
	
    self.waves = {
		"shadowmen/saxophone",
		"shadowmen/gunfight",
	}
	
	self.check = Kristal.getLibConfig("shadowmen", "check")
	
	self.prev_wave = nil
	
	self.spare_points = Kristal.getLibConfig("shadowmen", "spare_points")
	self.attack = Kristal.getLibConfig("shadowmen", "attack")
	self.health = Kristal.getLibConfig("shadowmen", "health") or Kristal.getLibConfig("shadowmen", "hp")
	self.max_health = self.health
	self.gold = Kristal.getLibConfig("shadowmen", "gold") or Kristal.getLibConfig("shadowmen", "money")
	
    self.text = Kristal.getLibConfig("shadowmen", "text")
	self.low_health_text = Kristal.getLibConfig("shadowmen", "low_health_text")
	
	self:registerAct(Kristal.getLibConfig("shadowmen", "act_name"))
	self:registerAct(Kristal.getLibConfig("shadowmen", "act_name") .. "X", "", "all")
	
	local socks = Sprite("npcs/shadowmen/socks", self.width * .5, self.height * .5)
	socks.visible = false
	socks:setOrigin(.5, .5)
	socks.hit = 0
	
	Utils.hook(socks, "update", function(orig, obj)
		orig(obj)
		obj:setFrame(self.sprite.frame)
	end)
	
	self.socks = socks
	self:addChild(socks)
end

function MyEnemy:onActStart(battler, name)
	if name ~= (Kristal.getLibConfig("shadowmen", "act_name") .. "X") then
		return super.onActStart(self, battler, name)
	else
		return Game.battle:startActCutscene("shadowmen", "point_hearts_x")
	end
end

function MyEnemy:getEnemyDialogue()
    local dialogue
	
    if self.mercy >= 100 then
        dialogue = Kristal.getLibConfig("shadowmen", "full_mercy") or Kristal.getLibConfig("shadowmen", "dialogue")
    else
        dialogue = Kristal.getLibConfig("shadowmen", "dialogue")
    end
	
    return dialogue[math.random(#dialogue)]
end

return MyEnemy