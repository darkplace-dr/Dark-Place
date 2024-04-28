return {
    sign = function(cutscene, event)
        cutscene:text("* There is a sign here,[wait:5] it reads:")
        cutscene:text("* Travelers,[wait:5] welcome to what remains of my world.")
        cutscene:text("* The complete destruction of reality is something only I and a few others have escaped.")
        cutscene:text("* I hope that whatever has befell on my reality doesn't befell yours.")
        cutscene:text("* Take what remains of my essence,[wait:5] and do your strongest.")
        if cutscene:getCharacter("susie") then
            cutscene:showNametag("susie")
            cutscene:text("* The complete destruction of reality?", "nervous_side", "susie")
            cutscene:text("* The hell does this person mean by that?", "nervous", "susie")
        end
        if cutscene:getCharacter("brenda") then
            cutscene:showNametag("Brenda")
            cutscene:text("* ...", "shaded_b", "brenda")
        end
        cutscene:hideNametag()
    end,

    placeholder = function(cutscene, event)
        cutscene:text("* A powerful essence shines here.")
        cutscene:text("* What boon shall you recieve from it?")
        local option = cutscene:choicer({"Offense", "Defense"})
        if option == 1 then
            local success = Game.inventory:tryGiveItem("aeonlance")
            if success then
                Game:setFlag("galacta_defeated", true)
                Assets.stopAndPlaySound("item")
                cutscene:text("* You recieved the AeonLance.")
                if not Game:getFlag("shadow_crystals") then
                    Game:setFlag("shadow_crystals", 1)
                else
                    Game:addFlag("shadow_crystals", 1)
                end
                cutscene:text("* You got a ShadowCrystal.")
            else
                cutscene:text("* Your inventory is too full.")
            end
        else
            local success = Game.inventory:tryGiveItem("originshield")
            if success then
                Game:setFlag("galacta_defeated", true)
                Assets.stopAndPlaySound("item")
                cutscene:text("* You recieved the OriginShield.")
                if not Game:getFlag("shadow_crystals") then
                    Game:setFlag("shadow_crystals", 1)
                else
                    Game:addFlag("shadow_crystals", 1)
                end
                cutscene:text("* You got a ShadowCrystal.")
            else
                cutscene:text("* Your inventory is too full.")
            end
        end
    end
}