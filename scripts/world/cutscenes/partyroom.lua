return {
    brandon = function(cutscene, event)
        local function brandonPartyOpinion(id)
            cutscene:showNametag("Brandon")
            if id == "YOU" then
                cutscene:text("* YOU the frog,[wait:5] eh?", "happy", "brandon")
                cutscene:text("* Honestly the place you come from is VERY strange.", "neutral", "brandon")
                cutscene:text("* I mean,[wait:5] it's like if Deltarune was a fever dream.", "neutral", "brandon")
                cutscene:text("* Wait,[wait:5] bad example.", "shock", "brandon")
                cutscene:text("* Well,[wait:5] you know what I mean.", "happy", "brandon")
            elseif id == "susie" then
                cutscene:text("* Susie,[wait:5] huh?", "neutral", "brandon")
                cutscene:text("* Honestly you're really cool.", "happy", "brandon")
                cutscene:text("* Like,[wait:5] you were kinda mid in Chapter 1.", "neutral", "brandon")
                cutscene:text("* But in Chapter 2,[wait:5] you're like the single greatest character.", "happy", "brandon")
                cutscene:showNametag("Susie")
                cutscene:text("* I...", "nervous_side", "susie")
                cutscene:text("* Don't know what any of that means.", "nervous", "susie")
                cutscene:text("* What the hell are you talking about?", "annoyed", "susie")
            elseif id == "dess" then
                Game.world.music:fade(0, 0.5)
                cutscene:text("* ...", "miffed", "brandon")
                cutscene:text("* You are one of the worst people I have ever met.", "miffed", "brandon")
                cutscene:text("* That's all I have to say about you.", "miffed", "brandon")
                Game.world.music:fade(1, 0.5)
            end
        end
        local function checkMember(number, id)
            id = Game.party[number].id
            brandonPartyOpinion(id)
        end
        cutscene:showNametag("Brandon")
        cutscene:text("* Oh hey guys,[wait:5] welcome back to the Dev Diner!", "happy", "brandon")
        cutscene:text("* Did you wanna talk about something?", "happy", "brandon")
        cutscene:hideNametag()
        local opinion = cutscene:choicer({"Yes", "No"})
        cutscene:showNametag("Brandon")
        if opinion == 1 then
            cutscene:text("* Great,[wait:5] what do you want to talk about?", "happy", "brandon")
            cutscene:hideNametag()
            local opinion = cutscene:choicer({"Party"})
            cutscene:showNametag("Brandon")
            if opinion == 1 then
                cutscene:text("* Who do you want me to talk about?", "happy", "brandon")
                local partyOptions = {}
                for _, party in ipairs(Game.party) do
                    table.insert(partyOptions, party.name)
                end
                cutscene:hideNametag()
                local number = cutscene:choicer(partyOptions)
                checkMember(number)
            end
        else
            cutscene:text("* Ah,[wait:5] alright then.", "neutral", "brandon")
            cutscene:text("* I'm always here if you wanna talk.", "happy", "brandon")
        end
        cutscene:hideNametag()
    end,
}