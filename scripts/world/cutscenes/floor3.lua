return {
    forgetmenot = function(cutscene, event)
        local flaurel = cutscene:getCharacter("flaurel")
        local player = Game.world.player
        local susie = cutscene:getCharacter("susie")
	
        cutscene:showNametag("???????")
        cutscene:text("* FORGET ME NOT.")
        cutscene:hideNametag()
        susie:setSprite("shock_right")
        player:explode(0, 0, true)
        flaurel:explode()
        cutscene:wait(0.25)
		
        Assets.stopSound("badexplosion")
        Game.world:remove()

        Game.state = "GAMEOVER"
        Kristal.hideBorder(0)
        Game.stage:addChild(GameOver(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, "what the fuck"))
        Mod:rollFun()
    end
}