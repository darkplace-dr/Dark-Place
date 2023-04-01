return {
    bb = function(cutscene, event)
        cutscene:playSound(Utils.pick({
            "bb_hi",
            "bb_hello",
            "bb_laugh"
        }))
        cutscene:text("[voice:nil]* HELLO FRIEND[wait:5]\n* WOULD YOU LIKE TO BUY SOME WARES", "90sbb/default")
        if cutscene:choicer({"Yes", "HELL NO"}) == 1 then
        else
            cutscene:playSound("bb_laugh")
            cutscene:text("[voice:nil]* FUCK YOU", "90sbb/default")
        end
    end,
}