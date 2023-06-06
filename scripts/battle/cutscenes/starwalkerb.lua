return {

	die = function(cutscene, battler, enemy)

		Game.battle.music:stop()
		cutscene:wait(2)
		local player = cutscene:getCharacter(Game.world.player.actor.id)
		cutscene:setAnimation(player, "battle/attack_ready" or "battle/right")
		cutscene:wait(0.2)
		if cutscene:getCharacter("susie") then
			cutscene:getCharacter("susie"):setSprite("shock_right")
		end
		Assets.playSound("sussurprise")
		cutscene:slideTo(player, enemy.x - 120, enemy.y + 5, 0.4)
		cutscene:wait(0.4)
		Assets.playSound("slash")
		cutscene:setAnimation(player, "battle/attack" or "battle/right")
		cutscene:wait(0.15)
		enemy:statusMessage("damage", 9999, color or (battler and {battler.chara:getDamageColor()}))
		enemy:hurt(999999999, battler, enemy.onDefeatFatal, color or (battler and {battler.chara:getDamageColor()}), false)
		cutscene:wait(1)
		player:setSprite("right_1")

		cutscene:wait(1.5)

		cutscene:fadeOut(1)

		cutscene:wait(1)

		Game.battle:setState("TRANSITIONOUT")
		Game.battle.encounter:onBattleEnd()

		cutscene:wait(0.5)

		cutscene:fadeIn(0.5)

		enemy.done_state = "KILLED"

	end

}
