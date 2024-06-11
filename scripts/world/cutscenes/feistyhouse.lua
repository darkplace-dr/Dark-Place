return {
    tv = function(cutscene, event)
        cutscene:text("* (You turn the TV on.)")
        local static = Assets.playSound("tv_static")
        static:setLooping(true)
        cutscene:wait(1.5)
        cutscene:text("* (Only static.)")
        static:stop()
    end,
}
