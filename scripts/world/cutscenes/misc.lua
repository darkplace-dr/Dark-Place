return {
    prunsel = function(cutscene, event)
        Game.world.music:stop()
        cutscene:text("[facec:prunsel,-18,-15][noskip][voice:nil][image:world/cutscenes/prunsel_glow, 0, 43][wait:15s]", { auto = true })
        Game.world.music:play()
    end,
    test1 = function(cutscene, event)
        cutscene:text("* If you're kawaii and you know it clap your hands.")
    end,
    frisk = function(cutscene, event)
        cutscene:text("(* you unlocked frisk from undertale.)")
        Mod:unlockPartyMember("frisk")
        Game:setFlag("frisk_unlock", true)
        Game.world:getCharacter("frisk"):explode()
    end,
}