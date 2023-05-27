return {
    brandon = function(cutscene, event)
        local function brandonPartyOpinion(id)
            cutscene:showNametag("Brandon")
            if id == "YOU" then
                cutscene:text("* YOU the frog,[wait:5] eh?", "", "brandon")
                cutscene:text("* Honestly the place you come from is VERY strange.", "", "brandon")
                cutscene:text("* I mean,[wait:5] it's like if Deltarune was a fever dream.", "", "brandon")
                cutscene:text("* Wait,[wait:5] bad example.", "", "brandon")
                cutscene:text("* Well,[wait:5] you know what I mean.", "", "brandon")
            elseif id == "susie" then
                cutscene:text("* Susie,[wait:5] huh?", "", "brandon")
                cutscene:text("* Honestly you're really cool.", "", "brandon")
                cutscene:text("* Like,[wait:5] you were kinda mid in Chapter 1.", "", "brandon")
                cutscene:text("* But in Chapter 2,[wait:5] you're like the single greatest character.", "", "brandon")
                cutscene:showNametag("Susie")
                cutscene:text("* I...", "", "susie")
                cutscene:text("* Don't know what any of that means.", "", "susie")
                cutscene:text("* What the hell are you talking about?", "", "susie")
            elseif id == "dess" then
                Game.world.music:fade(0, 0.5)
                cutscene:text("* ...", "", "brandon")
                cutscene:text("* You are one of the worst people I have ever met.", "", "brandon")
                cutscene:text("* That's all I have to say about you.", "", "brandon")
                Game.world.music:fade(1, 0.5)
            end
        end
        local function checkMember(number, id)
            id = Game.party[number].id
            brandonPartyOpinion(id)
        end
        cutscene:showNametag("Brandon")
        cutscene:text("* Oh hey guys,[wait:5] welcome back to the Dev Diner!", "", "brandon")
        cutscene:text("* Did you wanna talk about something?", "", "brandon")
        cutscene:hideNametag()
        local opinion = cutscene:choicer({"Yes", "No"})
        cutscene:showNametag("Brandon")
        if opinion == 1 then
            cutscene:text("* Great,[wait:5] what do you want to talk about?", "", "brandon")
            cutscene:hideNametag()
            local opinion = cutscene:choicer({"Party"})
            cutscene:showNametag("Brandon")
            if opinion == 1 then
                cutscene:text("* Who do you want me to talk about?", "", "brandon")
                local partyOptions = {}
                for _, party in ipairs(Game.party) do
                    table.insert(partyOptions, party.name)
                end
                cutscene:hideNametag()
                local number = cutscene:choicer(partyOptions)
                checkMember(number)
            end
        else
            cutscene:text("* Ah,[wait:5] alright then.", "", "brandon")
            cutscene:text("* I'm always here if you wanna talk.", "", "brandon")
        end
        cutscene:hideNametag()
    end,
}