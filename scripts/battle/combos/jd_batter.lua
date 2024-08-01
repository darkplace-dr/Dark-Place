local test, super = Class(Combo, "jd_batter")

function test:init()
    -- Display name
    self.name = "JD Batter"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = "Launch\nJamm"
    -- Menu description
    self.description = "With her bat, Dess launches Jamm at an enemy. Jamm hits the enemy, dealing huge damage."

    -- TP cost
    self.cost = 32
    -- Whether the combo can be used
    self.usable = true

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"

    -- Tags that apply to this combo
    self.tags = {}

    -- Other party members that are required to be in the party.
    self.party = {"jamm", "dess"}
end

function test:doCutscene(cutscene, target)
	cutscene:text("* Jamm and Dess use JD Batter!")
	local jamm = Game.battle:getPartyBattler("jamm")
	local dess = Game.battle:getPartyBattler("dess")
	local jamm_sx = jamm.x
	local jamm_sy = jamm.y
	local dess_sx = dess.x
	local dess_sy = dess.y
	local dess_layer = dess.layer
	local jamm_layer = jamm.layer
	local dess_input_1 = false
	local jamm_input_1 = false
	local dess_input_2 = false
	local jamm_input_2 = false
	local miss = false
	local dess_damage = ((Game:getPartyMember("dess"):getStat("attack") * 100) / 20) - (target.defense * 3)
	local jamm_damage = ((Game:getPartyMember("jamm"):getStat("attack") * 100) / 20) - (target.defense * 3)
	cutscene:slideTo(dess, 130, 200, 0.5)
	cutscene:wait(cutscene:slideTo(jamm, 210, 200, 0.5))
	cutscene:setSprite(jamm, "walk/right_1")
	cutscene:setAnimation(dess, "battle/attack_ready")
	dess:setLayer(jamm.layer + 0.1)
	cutscene:during(function()
		if Input.pressed("confirm") then
			dess_input_1 = true
		end
	end, true)
	local text = SimpleText(110, 120, Input.getText("confirm"))
	text:setColor({1, 0, 0, 1})
	Game.battle:addChild(text)
	cutscene:wait(0.25)
	if not dess_input_1 then
		cutscene:setAnimation(dess, {"battle/attack_ready_shake", 0.1, true})
		cutscene:wait(0.25)
		if not dess_input_1 then
			text:remove()
			local percent = DamageNumber("msg", "miss", dess.x, dess.y - 20, {1, 0, 0, 1})
			Game.battle:addChild(percent)
			dess:setLayer(jamm.layer - 0.1)
			cutscene:setAnimation(dess, "battle/defeat")
			cutscene:wait(0.5)
			cutscene:setAnimation(dess, "battle/idle")
			cutscene:setAnimation(jamm, "battle/idle")
			dess:setLayer(dess_layer)
			cutscene:slideTo(dess, dess_sx, dess_sy, 0.5)
			cutscene:wait(cutscene:slideTo(jamm, jamm_sx, jamm_sy, 0.5))
			return
		end
	end
	can_proceed = false
	cutscene:setAnimation(dess, "battle/attack")
	cutscene:wait(0.2)
	Game.battle.timer:tween(0.5, jamm, {scale_y = 1}, "in-bounce", function()
		cutscene:setSprite(jamm, "squish")
		jamm:setScale(2, 2)
		can_proceed = true
	end)
	cutscene:wait(function() return can_proceed end)
	text:remove()
	cutscene:during(function()
		if Input.pressed("cancel") then
			jamm_input_1 = true
		end
	end, true)
	text = SimpleText(250, 120, Input.getText("cancel"))
	text:setColor({1, 1, 0, 1})
	Game.battle:addChild(text)
	cutscene:wait(0.25)
	text:remove()
	if not jamm_input_1 then
		local percent = DamageNumber("msg", "miss", jamm.x, jamm.y - 20, {1, 1, 0, 1})
		Game.battle:addChild(percent)
		cutscene:setSprite(jamm, "walk/right_1")
		jamm:setScale(2, 1)
		can_proceed = false
		Game.battle.timer:tween(0.5, jamm, {scale_y = 2}, "out-elastic", function()
			cutscene:setAnimation(dess, "battle/idle")
			cutscene:setAnimation(jamm, "battle/idle")
			dess:setLayer(dess_layer)
			cutscene:slideTo(dess, dess_sx, dess_sy, 0.5)
			cutscene:wait(cutscene:slideTo(jamm, jamm_sx, jamm_sy, 0.5))
			can_proceed = true
		end)
		cutscene:wait(function() return can_proceed end)
		return
	end
	cutscene:during(function()
		if Input.pressed("confirm") then
			cutscene:setAnimation(dess, "battle/defeat")
			miss = true
		end
	end, true)
	cutscene:setAnimation(jamm, {"ball", 0.025, true})
	Game.battle.timer:tween(0.35, jamm, {y = jamm.y - 35}, "out-quart")
	cutscene:wait(0.35)
	can_proceed = false
	local t = Game.battle.timer:tween(0.35, jamm, {y = jamm.y + 35}, "in-quart", function()
		can_proceed = true
	end)
	if not miss then
		cutscene:setAnimation(dess, "battle/attack_ready")
		text = SimpleText(110, 120, Input.getText("confirm"))
		text:setColor({1, 0, 0, 1})
		Game.battle:addChild(text)
	end
	cutscene:during(function()
		if Input.pressed("confirm") and not miss then
			dess_input_2 = true
			Game.battle.timer:cancel(t)
			can_proceed = true
		end
	end, true)
	cutscene:wait(function() return can_proceed end)
	text:remove()
	if not dess_input_2 then
		local percent = DamageNumber("msg", "miss", dess.x, dess.y - 20, {1, 0, 0, 1})
		Game.battle:addChild(percent)
		local angle = Utils.angle(jamm.x,jamm.y,target.x,target.y)
		cutscene:wait(cutscene:moveTo(jamm, target.x, target.y, 32))
		Assets.playSound("damage")
		target:hurt(jamm_damage/1.5, nil, nil, {1, 1, 0, 1})
		cutscene:during(function()
			cutscene:moveTo(jamm, jamm.x + (6 * math.cos(angle)), jamm.y + (6 * math.sin(angle)), 32)
		end, true)
		cutscene:wait(function() return jamm.x > 680 end)
		cutscene:during(function() end, true)
		cutscene:setAnimation(dess, "battle/idle")
		cutscene:setAnimation(jamm, "battle/idle")
		jamm.x = -80
		jamm.y = jamm_sy
		cutscene:moveTo(dess, dess_sx, dess_sy, 8)
		cutscene:wait(cutscene:moveTo(jamm, jamm_sx, jamm_sy, 8))
		cutscene:wait(function() return dess.y == dess_sy end)
		return
	end
	cutscene:setAnimation(dess, "battle/attack")
	cutscene:wait(0.2)
	cutscene:during(function()
		if Input.pressed("cancel") then
			miss = true
		end
		if jamm.x > target.x - 100 then
			jamm:setLayer(target.layer + 0.5)
			text = SimpleText(target.x + 40, target.y - 80, Input.getText("cancel"))
			text:setColor({1, 1, 0, 1})
			Game.battle:addChild(text)
			cutscene:during(function()
				if Input.pressed("cancel") and not miss then
					jamm_input_2 = true
				end
			end, true)
		end
	end, true)
	cutscene:wait(cutscene:moveTo(jamm, target.x, target.y - 20, 32))
	Assets.playSound("damage")
	can_proceed = false
	text:remove()
	if jamm_input_2 then
		target:hurt((dess_damage + jamm_damage) * 1.2, nil, nil, {1, 1, 0, 1})
	else
		local percent = DamageNumber("msg", "miss", jamm.x, jamm.y - 20, {1, 1, 0, 1})
		Game.battle:addChild(percent)
		target:hurt(dess_damage, nil, nil, {1, 0, 0, 1})
		miss = true
	end
	Game.battle.timer:tween(0.7, jamm, {x = 230}, "linear")
	Game.battle.timer:tween(0.35, jamm, {y = jamm.y - 80}, "out-quad", function()
		Game.battle.timer:tween(0.35, jamm, {y = dess.y}, "in-quad", function()
			can_proceed = true
		end)
	end)
	cutscene:wait(function() return can_proceed end)
	jamm.scale_y = 1
	cutscene:setSprite(jamm, "walk/right_1")
	jamm:setLayer(jamm_layer)
	Game.battle.timer:tween(0.5, jamm, {scale_y = 2}, "out-elastic")
	cutscene:wait(0.5)
	if not miss then
		Assets.playSound("taunt", 0.5, Utils.random(0.9, 1.1))
		local dess_effect = Sprite("effects/taunt", dess:getRelativePos(dess.width/2, dess.height/2))
        dess_effect:setOrigin(0.5, 0.5)
        dess_effect:setScale(1)
        dess_effect.layer = dess.layer - 0.1
        Game.battle:addChild(dess_effect)
		local jamm_effect = Sprite("effects/taunt", jamm:getRelativePos(jamm.width/2, jamm.height/2))
        jamm_effect:setOrigin(0.5, 0.5)
        jamm_effect:setScale(1)
        jamm_effect.layer = jamm.layer - 0.1
        Game.battle:addChild(jamm_effect)
		cutscene:setSprite(dess, "sonic_adventure")
		cutscene:setSprite(jamm, "bs_win")
        dess_effect:play(1/30, false, function()
            dess_effect:remove()
        end)
        jamm_effect:play(1/30, false, function()
            jamm_effect:remove()
        end)
		cutscene:wait(0.6)
	end
	cutscene:setAnimation(dess, "battle/idle")
	cutscene:setAnimation(jamm, "battle/idle")
	dess:setLayer(dess_layer)
	cutscene:slideTo(dess, dess_sx, dess_sy, 0.5)
	cutscene:wait(cutscene:slideTo(jamm, jamm_sx, jamm_sy, 0.5))
	cutscene:wait(function() return dess.y == dess_sy end)
end

return test