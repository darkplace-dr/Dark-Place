return {
    begin = function(cutscene, dino)
        local player = cutscene:getCharacter("YOU")
        local dino = cutscene:spawnNPC("googledino", 1200, player.y)
        dino:setSprite("static")
        dino.sprite.flip_x = true

        cutscene:panTo(1000, nil)
        cutscene:wait(2)

        cutscene:detachCamera()
        cutscene:wait(2)

        dino.sprite.flip_x = false

        cutscene:wait(1)

        Assets.playSound("dino_jump")
        Game.world.timer:tween(0.2, dino, {y=player.y-100})
        cutscene:wait(0.2)
        Game.world.timer:tween(0.2, dino, {y=player.y})
        cutscene:wait(0.2)
        Assets.playSound("dino_jump")
        Game.world.timer:tween(0.2, dino, {y=player.y-100})
        cutscene:wait(0.2)
        Game.world.timer:tween(0.2, dino, {y=player.y})

        cutscene:wait(0.5)
		
        cutscene:startEncounter("googledino", nil, {dino})
    end,
}