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
            elseif id == "dumbie" then
                cutscene:text("* Honestly I don't really know what to think about you.", "neutral_side", "brandon")
                cutscene:text("* Like,[wait:5] you're just a living training dummy.", "neutral", "brandon")
                cutscene:text("* Well,[wait:5] I don't know what else to say really.", "neutral_side", "brandon")
            elseif id == "kris" then
                cutscene:text("* Ah,[wait:5] Kris.", "happy", "brandon")
                cutscene:text("* Ever the mysterious one,[wait:5] you.", "happy_side", "brandon")
                cutscene:text("* What's up with the soul you have.", "neutral_side", "brandon")
                cutscene:text("* What's happening regarding your brother.", "neutral_side", "brandon")
                cutscene:text("* Why the hell would you make a Dark Fountain.", "dissapointed", "brandon")
                cutscene:text("* All very interesting things.", "happy", "brandon")
                cutscene:text("* Oh yeah there's also that other thing people are wondering about.", "neutral_side", "brandon")
                cutscene:text("* Uh,[wait:5] I'd rather not get into that.", "suspicious", "brandon")
                cutscene:text("* People can get uh,[wait:5] a bit too crazy about that.", "dissapointed", "brandon")
            elseif id == "noelle" then
                cutscene:text("* Oh hey,[wait:5] it's Noelle!", "happy", "brandon")
                cutscene:text("* Honestly,[wait:5] you remind me a lot of someone.", "happy_side", "brandon")
                cutscene:text("* Someone I really,[wait:5] really like.", "happy_side_blush", "brandon")
                cutscene:text("* Oh![wait:10] I swear I'm not flirting with you.", "blush", "brandon")
                cutscene:text("* Anyways...", "neutral_side", "brandon")
                cutscene:text("* I really hope you haven't been doing you-know-what.", "neutral", "brandon")
                cutscene:text("* I'm sure you know what I'm talking about.", "dissapointed", "brandon")
            elseif id == "ralsei" then
                Game.world.music:fade(0, 0.5)
                cutscene:text("[speed:0.3]* ...", "shock", "brandon")
                cutscene:text("* How...", "shock", "brandon")
                cutscene:text("* How are YOU here?", "shock", "brandon")
                cutscene:text("* I'm...[wait:5] asuming some debug shenanigans happened?", "suspicious", "brandon")
                cutscene:text("* Whatever.", "dissapointed", "brandon")
                Game.world.music:fade(1, 0.5)
            elseif id == "brandon" then
                if not Kristal.libCall("achievements", "hasAch", "dirtyhacker") then
                    cutscene:text("[speed:0.3]* ...", "dissapointed", "brandon")
                    cutscene:text("* Oh you think you're REAL funny,[wait:5] now don't you?", "smug", "brandon")
                    cutscene:text("* Yeah,[wait:5] I know you used the console,[wait:5] "..Game.save_name..".", "frown", "brandon")
                    cutscene:text("* You ain't slick.", "dissapointed", "brandon")
                    cutscene:text("* Here,[wait:5] how about I give you a \"reward\".", "smug", "brandon")
                    cutscene:hideNametag()
                    Kristal.callEvent("completeAchievement", "dirtyhacker")
                    cutscene:wait(3)
                    cutscene:showNametag("Brandon")
                    cutscene:text("* Now everyone knows how much of a dirty hacker you are.", "smug", "brandon")
                    cutscene:text("* I mean I guess you can just NOT show everyone you got this.", "suspicious", "brandon")
                    cutscene:text("* But uh,[wait:5] yeah,[wait:5] hopefully you learned your leason.", "smug", "brandon")
                else
                    cutscene:text("[speed:0.3]* ...", "miffed", "brandon")
                    cutscene:text("* I already gave you your \"reward\".", "dissapointed", "brandon")
                end
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
            opinion = cutscene:choicer({"Party", "This Mod", "Relationships"})
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
            elseif opinion == 2 then
                cutscene:text("* Ah,[wait:5] you want to know more about this mod?", "happy", "brandon")
                cutscene:text("* Well,[wait:5] it started out as an idea by Racc.", "happy_side", "brandon")
                cutscene:text("* An open source Kristal mod that anyone could contribute to.", "happy", "brandon")
                cutscene:text("* Sorta like r/place.", "happy_side", "brandon")
                cutscene:text("* Anyways I helped by making the GitHub page for it.", "happy", "brandon")
                cutscene:text("* If you're wondering about the name,[wait:5] thank Jamm for that.", "happy_side", "brandon")
                cutscene:text("* Anyways I hope you guys enjoy this mod!", "happy_b", "brandon")
                cutscene:text("* A lot of people helped out with it.", "happy", "brandon")
            elseif opinion == 3 then
                cutscene:text("* Relationships?", "neutral_side", "brandon")
                cutscene:text("* You talking about platonic ones,[wait:5] or romantic ones?", "neutral", "brandon")
                opinion = cutscene:choicer({"Platonic", "Romantic"})
                if opinion == 1 then
                    cutscene:text("* Alright well first off there's Velvet.", "neutral", "brandon")
                    cutscene:text("* She's pretty cool,[wait:5] and her art is really cute.", "happy", "brandon")
                    cutscene:text("* They're even helping me out with one of my AUs!", "happy_b", "brandon")
                    cutscene:text("* Hm?[wait:10] What's my AU about?", "neutral", "brandon")
                    cutscene:text("* Well it's my take on a Deltaswap AU.", "happy", "brandon")
                    cutscene:text("* It's mainly about swapping party members with secret bosses.", "happy_side", "brandon")
                    cutscene:text("* The swaps are based on the weapons they give.", "neutral", "brandon")
                    cutscene:text("* So for example Ralsei swaps with Spamton.", "happy", "brandon")
                    cutscene:text("* The name of the AU is Crystalseeker!", "happy_b", "brandon")
                    cutscene:text("* Anyways next up is JARU.", "happy", "brandon")
                    cutscene:text("* Before you ask,[wait:5] he's not THAT Jaru.", "neutral", "brandon")
                    cutscene:text("* He runs this diner.", "happy_side", "brandon")
                    cutscene:text("* He's also working on some stuff of his own.", "happy", "brandon")
                    cutscene:text("* Mainly a Kristal mod called NEO+.", "happy_side", "brandon")
                    cutscene:text("* And also a fangame called Deltarune: New Connections.", "happy", "brandon")
                    cutscene:text("* Overall I'd say he's pretty cool.", "happy_b", "brandon")
                    cutscene:text("* I've got some other friends too,[wait:5] but uh...", "neutral", "brandon")
                    cutscene:text("* They're not here at the moment.", "neutral_side", "brandon")
                    cutscene:text("* I'll tell you about them when they arrive though!", "happy_b", "brandon")
                elseif opinion == 2 then
                    cutscene:text("* Ah,[wait:5] alright then.", "happy", "brandon")
                    cutscene:text("* I'm in a relationship with two people.", "happy_side", "brandon")
                    cutscene:text("* The first is Hazel,[wait:5] my girlfriend.", "happy_blush", "brandon")
                    cutscene:text("* She's really nice and caring.", "happy_side_blush", "brandon")
                    cutscene:text("* And really cute.", "grin_blush", "brandon")
                    cutscene:text("* I really do love and care about her a lot.", "joy_blush", "brandon")
                    cutscene:text("* And the second is Sci,[wait:5] my boyfriend.", "happy_blush", "brandon")
                    cutscene:text("* He's the cook for the diner.", "happy_side", "brandon")
                    cutscene:text("* And I gotta say,[wait:5] he's good at his job.", "happy_side_blush", "brandon")
                    cutscene:text("* All of his food tastes so good!", "grin_blush", "brandon")
                    cutscene:text("* I love the both of them so much.", "happy_blush", "brandon")
                    cutscene:text("* They're always there for me when I'm down.", "happy_side_blush", "brandon")
                    cutscene:text("* And they're really nice to spend time with.", "grin_blush", "brandon")
                    cutscene:text("* Sadly neither of them are here right now.", "frown_side", "brandon")
                    cutscene:text("* But I'd love for you guys to meet them someday!", "grin", "brandon")
                end
            end
        else
            cutscene:text("* Ah,[wait:5] alright then.", "neutral", "brandon")
            cutscene:text("* I'm always here if you wanna talk.", "happy", "brandon")
        end
        cutscene:hideNametag()
    end,
}