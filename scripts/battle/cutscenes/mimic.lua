return {
    dies = function(cutscene, battler, enemy)
        local susie = cutscene:getCharacter("susie")
        local dess = cutscene:getCharacter("dess")

        cutscene:wait(1)
        enemy:shake(5)
        Assets.playSound("wing")

        if susie then
            if Mod:isInRematchMode() then
                cutscene:text("* Heh,[wait:5] looks like we've won.", "smile", "susie")
            else
                cutscene:text("* Hey uh,[wait:5] something about this feels off...", "sad_frown", "susie")
            end
        end

        enemy:shake(5)
        Assets.playSound("wing")
        cutscene:wait(1)
        enemy:shake(5)
        Assets.playSound("wing")
        cutscene:wait(1)

        if dess then
            if Mod:isInRematchMode() then
                cutscene:text("* funny explosion incomming", "kind", "dess")
            else
                cutscene:text("* idk looks fine to me lol", "kind", "dess")
            end
        end

        enemy:shake(5)
        Assets.playSound("wing")
        cutscene:wait(2)

        enemy:explode(0, 0, false)
        cutscene:wait(2)

        if Mod:isInRematchMode() then
            if susie then
                cutscene:text("* That was too easy!", "smile", "susie")
            end
            if dess then
                cutscene:text("* gg ez", "condescending", "dess")
            end
        else
            cutscene:text("* ...", "shock", "susie")
            cutscene:text("* well erm... THAT just happened lol", "condescending", "dess")
        end
    end
}