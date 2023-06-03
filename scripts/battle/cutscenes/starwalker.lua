return {

	die = function(cutscene, battler, enemy)

		Game.battle.music:stop()
		cutscene:wait(2)
		if cutscene:getCharacter("susie") then
			cutscene:getCharacter("susie"):setSprite("shock_right")
		end
		Assets.playSound("sussurprise")
		--cutscene:setAnimation(Game.world.player, "battle/attack_ready" or "battle/right")
		--cutscene:slideTo(Game.world.player, enemy.x - 20, enemy.y, 0.2)
		cutscene:wait(0.2)
		Assets.playSound("slash")
		--cutscene:setAnimation(Game.world.player, "battle/attack" or "battle/right")
		enemy:statusMessage("damage", 999, color or (battler and {battler.chara:getDamageColor()}))
		--enemy:hurt(999999999, battler, enemy.onDefeatFatal)
		enemy:hurt(999999999, battler)
		cutscene:wait(0.5)
		Game.world.player:setSprite("right_1")

		cutscene:fadeOut(1)

		cutscene:wait(1)

		Game.battle:setState("TRANSITIONOUT")
		Game.battle.encounter:onBattleEnd()

		cutscene:wait(0.5)

		cutscene:fadeIn(0.5)

		enemy.done_state = "KILLED"

        local done_state = enemy.done_state
        
        if done_state == "VIOLENCED" or done_state == "KILLED" or done_state == "FROZEN" then
            cutscene:wait(1)
            cutscene:text("* Hey,[wait:5] uh.", "neutral", "susie")
            cutscene:text("* I know they were in our way,[wait:5] but...", "annoyed_down", "susie")
            susie:setFacing("up")
            cutscene:text("* What happened to the ACTing thing?", "neutral", "susie")
            cutscene:text("* ...", "annoyed_down", "susie")
            Assets.playSound("ominous")
            cutscene:wait(1.5)
            Game:setFlag("weird", true)
            Game.world.music:play("cybercity_alt")
            Game.world.player:setFacing("down")
        end

        event.sprite:resetSprite()

        cutscene:interpolateFollowers()
        cutscene:attachFollowers()

        event.interacted = false

	end

}
