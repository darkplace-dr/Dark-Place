return {
    cook_ralsei = function(cutscene)
        for _,battler in ipairs(Game.battle.party) do
            battler:heal(30)
        end
        cutscene:text("* Ralsei cooked up a cure.")
        cutscene:text("* If you're sick,\nshouldn't you have some\nsoup? Say \"aah\"~!", "blush_pleased", "ralsei")
        cutscene:text("* Sickness was cured! Everyone's\nHP up!")
    end,

    cook_susie = function(cutscene, battler, act_enemy)
        cutscene:text("* Susie cooked up a cure!")
        cutscene:text("* What, you want me to\ncook something!?", "smile", "susie")
        cutscene:text("* Susie put a hot dog in the\nmicrowave!")
        local susie = cutscene:getCharacter("susie")

        local explosion = Explosion(susie.x - 6, susie.y - 73) -- This is awful but accurate
        explosion:setScale(1)
        explosion.speed = 1
        Game.battle:addChild(explosion)

        for _, enemy in ipairs(Game.battle:getActiveEnemies()) do
            if enemy.health >= 10 then
                enemy:hurt(math.floor(enemy.health * 0.75), susie)
            end
        end

        cutscene:text("* She forgot to poke holes in it!\nThe hot dog exploded!")
    end
}