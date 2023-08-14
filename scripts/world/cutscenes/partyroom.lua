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
                if not Kristal.callEvent("earnedAch", "dirtyhacker") then
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

                    cutscene:text("* Next up is Bor.", "happy", "brandon")
                    cutscene:text("* He's,[wait:0.1s] um,[wait:0.1s] certainly someone interesting.", "happy_side", "brandon")
                    cutscene:text("* He runs a shop near the Banana Alley.[wait:0.1s] I help out there sometimes.", "happy_b", "brandon")
                    cutscene:text("* He's also helping out on Crystalseeker.[wait:0.1s] He made the OST cover, actually.", "happy_b", "brandon")
                    cutscene:text("* He's pretty cool,[wait:5] and he's actually working on his own fangame.", "happy", "brandon")
                    cutscene:text("* It's an AU where Susie wakes up as Kris is about to create the chapter 3 f-[wait:1s]", "grin", "brandon")
                    cutscene:text("* ...Yeah?", "nervous", "susie")
                    cutscene:text("* Nothing,[wait:5] haha.[wait:0.2s] Almost just broke the whole timeline just now.[wait:0.2s] Oops", "heyyy", "brandon")
                    cutscene:text("* Anyway, you can probably find him somewhere around here.", "happy", "brandon")
                    cutscene:text("* He might want to join your party aswell.", "happy", "brandon")

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
                    cutscene:text("* The first is Willow,[wait:5] my girlfriend.", "happy_blush", "brandon")
                    cutscene:text("* She's really nice and caring.", "happy_side_blush", "brandon")
                    cutscene:text("* And really cute.", "grin_blush", "brandon")
                    cutscene:text("* I really do love and care about her a lot.", "joy_blush", "brandon")
                    cutscene:text("* And the second is Sci,[wait:5] my other girlfriend.", "happy_blush", "brandon")
                    cutscene:text("* She's the cook for the diner.", "happy_side", "brandon")
                    cutscene:text("* And I gotta say,[wait:5] she's good at his job.", "happy_side_blush", "brandon")
                    cutscene:text("* All of her food tastes so good!", "grin_blush", "brandon")
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

    susie = function(cutscene, event)
        cutscene:showNametag("Susie")
        cutscene:text("* Oh,[wait:5] hey guys.", "smile", "susie")
        cutscene:text("* You need anything?", "small_smile", "susie")
        cutscene:hideNametag()
        local opinion = cutscene:choicer({"Delta\nWarriors", "This Place", "You", "No"})
        cutscene:showNametag("Susie")
        if opinion == 1 then
            cutscene:text("* Ah,[wait:5] yeah I'm a part of the Delta Warriors.", "smile", "susie")
            cutscene:text("* Which one of em do you wanna know more about?", "small_smile", "susie")
            cutscene:hideNametag()
            opinion = cutscene:choicer({"Kris", "Ralsei", "Noelle", "Berdly"})
            cutscene:showNametag("Susie")
            if opinion == 1 then
                cutscene:text("* Kris,[wait:5] huh?", "small_smile", "susie")
                cutscene:text("* Honestly they're a great friend!", "smile", "susie")
                cutscene:text("* And a great leader as well.", "small_smile", "susie")
                cutscene:text("* I sorta regret picking on them before now.", "shy_down", "susie")
                cutscene:text("* Well,[wait:5] at least I'm tryna make up for that.", "small_smile", "susie")
            elseif opinion == 2 then
                cutscene:text("* Ralsei?", "small_smile", "susie")
                cutscene:text("* Yeah,[wait:5] he's cool.", "smile", "susie")
                cutscene:text("* Even if he's a total weenie...", "nervous", "susie")
                cutscene:text("* Speaking of him...", "nervous_side", "susie")
                cutscene:text("* I haven't seen him in this Dark World at all.", "neutral", "susie")
                cutscene:text("* I wonder what happend to him.", "neutral_side", "susie")
                cutscene:text("* Hopefully he's okay...", "shy_down", "susie")
                if not Game:getFlag("ralseimissing_known") then
                    Kristal.callEvent("setDesc", "mainline",
                        "Well as it turns out Ralsei was wrong when he said that making Dark Fountains causes The Roaring, \z
                        they just get weirder the more you make. Susie has been making them left right and center, \z
                        and she is now on her 1000th fountain. Susie mentioned Ralsei being missing, \z
                        maybe try and find clues relating to him?"
                    )
                    Game:setFlag("ralseimissing_known", true)
                end
            elseif opinion == 3 then
                cutscene:text("* Oh,[wait:5] Noelle?", "surprise", "susie")
                cutscene:text("* Honestly she's really nice to me.", "sincere", "susie")
                cutscene:text("* Which is strange considering how much of a jerk I was...", "nervous_side", "susie")
                cutscene:text("* Wonder what's up with her?", "neutral", "susie")
            elseif opinion == 4 then
                cutscene:text("* Ah,[wait:5] Berdly.", "neutral", "susie")
                cutscene:text("* He's um...", "neutral_side", "susie")
                cutscene:text("* Okay he's not BAD,[wait:5] he's just...", "nervous", "susie")
                cutscene:text("* Really annoying.", "nervous_side", "susie")
                cutscene:text("* But uh,[wait:5] even with THAT...", "shy", "susie")
                cutscene:text("* I still consider him a friend.", "small_smile", "susie")
                cutscene:text("* Somewhat.", "shy_b", "susie")
            end
            if not Game:getFlag("drcastsplitup_known") then
                cutscene:text("* Y'know,[wait:5] speaking of those guys...", "neutral_side", "susie")
                cutscene:text("* I didn't see them at all when I first entered this Dark World.", "nervous", "susie")
                cutscene:text("* Which is strange because we were all together when we entered.", "nervous_side", "susie")
                cutscene:text("* Not gonna lie,[wait:5] I'm starting to worry for them...", "shy_down", "susie")
                Kristal.callEvent("createQuest", "Where's Kris", "krismissing", "Susie mentioned Kris not being with her when she entered the Dark World. Go search for clues on their wherabouts.")
                Kristal.callEvent("createQuest", "Lost Girl", "noellemissing", "Susie mentioned Noelle not being with her when she entered the Dark World. Go search for clues on her wherabouts.")
                Kristal.callEvent("createQuest", "Missing Berd", "berdlymissing", "Susie mentioned Berdly not being with her when she entered the Dark World. Go search for clues on his wherabouts.")
            end
        elseif opinion == 2 then
            cutscene:text("* What do I think of this place?", "neutral", "susie")
            cutscene:text("* Well for one it's weird as hell.", "neutral_side", "susie")
            if Game:getFlag("spamgolor_defeated") then
                cutscene:text("* Weird look-alikes of that Spamton guy...", "nervous", "susie")
            end
            if cutscene:getCharacter("dess") then
                cutscene:text("* The single worst person I have ever met...", "annoyed", "susie")
            end
            cutscene:text("* I guess that's what you get for uh...", "nervous_side", "susie")
            cutscene:text("* Making a thousand Dark Fountains I guess.", "nervous", "susie")
        elseif opinion == 3 then
            cutscene:text("* Oh you wanna know more about me?", "shy", "susie")
            cutscene:text("* Well,[wait:5] I'm Susie!", "smile", "susie")
            cutscene:text("* But uh,[wait:5] you already knew that.", "nervous_side", "susie")
            cutscene:text("* Honestly what else is there to say about me?", "nervous", "susie")
        elseif opinion == 4 then
            cutscene:text("* Ah,[wait:5] alright then.", "neutral", "susie")
            cutscene:text("* Well uh,[wait:5] I'm always here if you DO need me.", "small_smile", "susie")
            cutscene:text("* Man it's boring not being in the party...", "shy_down", "susie")
        end
        cutscene:hideNametag()
    end,

    dess = function(cutscene, event)
        cutscene:showNametag("Dess")
        cutscene:text("* Sup losers", "heckyeah", "dess")
        cutscene:text("* you wondering why I'm alone here?", "kind", "dess")
        cutscene:text("* It's because everyone here hates me lol", "wink", "dess")
        cutscene:text("* Honestly I don't see why they do.[wait:10] I'm such a lovely individual.", "condescending", "dess")
        cutscene:text("* Anyways you're probably expexcting me to say cool things", "neutral", "dess")
        cutscene:text("* Well I can comment on the current party leader", "kind", "dess")
        cutscene:text("* Wanna see me do that?", "condescending", "dess")
        cutscene:hideNametag()
        local opinion = cutscene:choicer({"yes", "NO NO NO\nNO NO NO\nNO NO NO"})
        cutscene:showNametag("Dess")
        if opinion == 1 then
            cutscene:text("* alr lol", "heckyeah", "dess")
            if Game.party[1].id == "YOU" then
                cutscene:text("* man I remember when you were blue", "kind", "dess")
                cutscene:text("* I'm an OG Dark Place fan", "condescending", "dess")
                cutscene:text("* Man, where did the years go by?", "kind", "dess")
            elseif Game.party[1].id == "susie" then
                cutscene:text("* Well if it isn't Sussy Deltarune", "condescending", "dess")
                cutscene:text("* I'm still up for that offer to smoke a ciggie outside a 7-11.", "kind", "dess")
                cutscene:showNametag("Susie")
                cutscene:text("* ...Fuck off.", "annoyed", "susie")
                cutscene:showNametag("Dess")
                cutscene:text("* Woah did you just say the fuck word?!", "wtf_b", "dess")
                cutscene:text("* Man I'm so cool to have made you do that.", "heckyeah", "dess")
            elseif Game.party[1].id == "brandon" then
                cutscene:text("* Oh wow it's Brandish", "condescending", "dess")
                cutscene:showNametag("Brandon")
                cutscene:text("* Are you going to do this every time?", "miffed", "brandon")
                cutscene:showNametag("Dess")
                cutscene:text("* Nah not every time my dawg", "kind", "dess")
                cutscene:text("* Just until it's no longer funny for me", "challenging", "dess")
                cutscene:text("* Which is never lol", "heckyeah", "dess")
            elseif Game.party[1].id == "dumbie" then
                cutscene:text("* ...", "neutral_b", "dess")
                cutscene:text("* Who tf are you lmao", "condescending", "dess")
            elseif Game.party[1].id == "kris" then
                cutscene:text("* Holy shit it's Kris Deltarune", "wtf", "dess")
                cutscene:text("* Man I remember when I beat the shit out of you with my bat when you were in 3rd grade", "kind", "dess")
                cutscene:text("* Wait wdym it was with a whiffle bat?", "neutral", "dess")
                cutscene:text("* Nah I'm pretty sure it was a regular bat", "condescending", "dess")
                cutscene:text("* Man that was some good times", "genuine_b", "dess")
                cutscene:text("* Asriel didn't talk to me that much anymore after that", "neutral_c", "dess")
                cutscene:text("* Gee I wonder why", "condescending", "dess")
            elseif Game.party[1].id == "dess" then
                cutscene:text("* Holy shit is that another Dess????", "wtf_b", "dess")
                cutscene:showNametag("Dess", {right = true})
                cutscene:text("* Ye", "heckyeah", "dess")
                cutscene:text("* How u doin?", "kind", "dess")
                cutscene:showNametag("Dess")
                cutscene:text("* Pretty poggers my dude", "condescending", "dess")
                cutscene:showNametag("Dess", {right = true})
                cutscene:text("* Wow same here", "kind", "dess")
                cutscene:text("[noskip]* We should totally", "wink", "dess", {auto = true})
                cutscene:showNametag("Dess")
                cutscene:text("* Hey,[wait:5] we gotta keep things PG-13", "neutral", "dess")
                cutscene:showNametag("Dess", {right = true})
                cutscene:text("* Ah my b", "neutral_b", "dess")
                cutscene:showNametag("Dess")
            else
                cutscene:text("* Alan please add dialogue", "neutral", "dess")
            end
            cutscene:text("* Alright that was my special thing", "condescending", "dess")
            cutscene:text("* May I please join the party again now?", "genuine", "dess")
        else
            cutscene:text("* Well uhhh fuck you too", "condescending", "dess")
        end
        cutscene:hideNametag()
    end,

    starwalker = function(cutscene, event)
        cutscene:showNametag("Starwalker?")
        cutscene:text("* This [color:yellow]room[color:reset] is [color:yellow]Pissing[color:reset] me\noff...")
        cutscene:text("* I was the original   [color:yellow]Starwalker[color:reset]")
        cutscene:hideNametag()
    end
}