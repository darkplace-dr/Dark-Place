return {
    begin = function(cutscene, dino)
        local player = cutscene:getCharacter(Game.party[1].id)
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

        local encounter = cutscene:startEncounter("googledino", nil, {dino})

        local defeated_enemies = encounter:getDefeatedEnemies()

        local done_state = defeated_enemies[1].done_state

        Game:setFlag("googledino_defeated", true)

        if done_state == "KILLED" then
            dino:remove()
            cutscene:wait(2)
        else
            cutscene:wait(0.5)

            Assets.playSound("dino_jump")
            Game.world.timer:tween(0.2, dino, {y=player.y-100})
            cutscene:wait(0.2)
            Game.world.timer:tween(0.2, dino, {y=player.y})
            cutscene:wait(0.2)
            Assets.playSound("dino_jump")
            Game.world.timer:tween(0.2, dino, {y=player.y-100})
            cutscene:wait(0.2)
            Game.world.timer:tween(0.2, dino, {y=player.y})
            cutscene:wait(0.2)
            Assets.playSound("dino_reached")
            Game.world.timer:tween(0.2, dino, {y=player.y-100})
            cutscene:wait(0.2)
            Game.world.timer:tween(0.2, dino, {y=player.y})

            cutscene:wait(1)

            dino.sprite.flip_x = true

            cutscene:wait(cutscene:slideTo(dino, 1400, dino.y))

            dino:remove()
        end
        cutscene:wait(cutscene:panTo(player, nil))

        cutscene:attachCameraImmediate()
    end,
}