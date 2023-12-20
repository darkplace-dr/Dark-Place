return {
    computer = function (cutscene, event)
        cutscene:text("* A computer.[wait:10] Turn it on?")
        local choice = cutscene:choicer({"Yes", "No"})
        if choice == 1 then
            Assets.playSound("item")
        else
            cutscene:text("* You computern't.")
        end
    end,

    plush = function (cutscene, event)
        cutscene:text("* It's a Lucy plush.") -- And it's also the only sprite I have of myself lmao
        
    end

}