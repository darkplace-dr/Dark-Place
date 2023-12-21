return {
    phase1to2 = function(cutscene, battler, enemy)
        local jamm = cutscene:getCharacter("jamm")
        local mario = cutscene:getCharacter("mario")

        cutscene:wait(1)
        enemy:shake(5)
        Assets.playSound("wing")
        enemy:shake(5)
        Assets.playSound("wing")
        cutscene:wait(1)
        enemy:shake(5)
        Assets.playSound("wing")
        cutscene:wait(1)

        enemy:shake(5)
        Assets.playSound("wing")
        cutscene:wait(2)
		
		cutscene:battlerText(enemy, "Oh no!", {})
		
		enemy:onDefeatRun(0, jamm)
		cutscene:wait(1)
		
		for _,battler in ipairs(Game.battle.party) do
            battler:setSleeping(false)
            battler.defending = false
            battler.action = nil

            battler.chara:resetBuffs()

            if battler.chara:getHealth() <= 0 then
                battler:revive()
                battler.chara:setHealth(battler.chara:autoHealAmount())
            end

            battler:setAnimation("battle/victory")

            local box = Game.battle.battle_ui.action_boxes[Game.battle:getPartyIndex(battler.chara.id)]
            box:resetHeadIcon()
        end
		
		cutscene:text("* You won!")
		
		Game.battle.music:fade(0,1)
		cutscene:wait(1)
		
		Game.battle.music:play("egg_2", 1, 1)
		
		Game.battle.encounter.big_arms = Game.battle.encounter:addEnemy("big_arms", 900, 200)
		
		cutscene:wait(1)
		
		cutscene:wait(cutscene:slideTo(Game.battle.encounter.big_arms, 550, 200, 2))
		
		for _,battler in ipairs(Game.battle.party) do
            battler:setSleeping(false)
            battler.defending = false
            battler.action = nil

            battler.chara:resetBuffs()

            if battler.chara:getHealth() <= 0 then
                battler:revive()
                battler.chara:setHealth(battler.chara:autoHealAmount())
            end

            battler:setAnimation("battle/intro")

            local box = Game.battle.battle_ui.action_boxes[Game.battle:getPartyIndex(battler.chara.id)]
            box:resetHeadIcon()
        end
		Assets.playSound("impact", 0.7)
        Assets.playSound("weaponpull_fast", 0.8)
		
		cutscene:wait(0.5)
		
		for _,battler in ipairs(Game.battle.party) do
			battler:setAnimation("battle/idle")
		end
    end,
	
    ending = function(cutscene, battler, enemy)
        local jamm = cutscene:getCharacter("jamm")
        local mario = cutscene:getCharacter("mario")

        cutscene:wait(1)
        enemy:shake(5)
        Assets.playSound("wing")
        enemy:shake(5)
        Assets.playSound("wing")
        cutscene:wait(1)
        enemy:shake(5)
        Assets.playSound("wing")
        cutscene:wait(1)

        enemy:shake(5)
        Assets.playSound("wing")
        cutscene:wait(2)
		
		cutscene:battlerText(enemy, "Not again!\nI hate you!", {})
		
		enemy:explode(0, 0, false)
	end,
}