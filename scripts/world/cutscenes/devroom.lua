return {
    brandon = function(cutscene, event)
        cutscene:showNametag("Brandon")
        if not Game:getFlag("brandon_talkedto") then
            if not cutscene:getCharacter("kris") then
                cutscene:text("* Well,[wait:5] if it isn't Kris Deltarune themself.", "happy", "brandon")
                cutscene:showNametag("Susie")
                cutscene:text("* Okay,[wait:5] first of all,[wait:5] that isn't their last name.", "annoyed", "susie")
                cutscene:text("* Second of all,[wait:5] how the hell do you know their name?", "sus_nervous", "susie")
                cutscene:showNametag("Brandon")
                cutscene:text("* Eh,[wait:5] that isn't really important.", "happy", "brandon")
                cutscene:text("* Anyways...", "neutral", "brandon")
            end
            cutscene:text("* It's so cool that you guys showed up here.", "happy", "brandon")
            if cutscene:getCharacter("dess") then
                cutscene:text("* ... Minus one of you...", "miffed", "brandon")
                cutscene:showNametag("Dess")
                cutscene:text("* Gee I wonder who that could be lol", "condescending", "dess")
                cutscene:showNametag("Brandon")
            end
            cutscene:text("* Hey,[wait:5] could I join the party?", "happy", "brandon")
        else
            cutscene:text("* So,[wait:5] did you change your mind?", "happy", "brandon")
        end
        cutscene:hideNametag()
        local opinion = cutscene:choicer({"Yes", "No"})
        if opinion == 1 then
            cutscene:showNametag("Brandon")
            cutscene:text("* Nice,[wait:5] thanks!", "happy", "brandon")
            Game:addPartyMember("brandon")
            if cutscene:getCharacter("dess") then
                event:convertToFollower(3)
            else
                event:convertToFollower(2)
            end
            cutscene:hideNametag()
            cutscene:attachFollowers()
            cutscene:text("* Brandon joined the party.")
            cutscene:wait(0.5)
            Game:setFlag("brandon_inparty", true)
        else
            cutscene:showNametag("Brandon")
            cutscene:text("* Ah,[wait:5] okay then.", "frown", "brandon")
            cutscene:text("* Well,[wait:5] I'm always here if you change your mind.", "happy", "brandon")
            Game:setFlag("brandon_talkedto", true)
        end
        cutscene:hideNametag()
    end,
}