return {
    fun_fax = function(cutscene, event)
        local fun_fax = Game.world:spawnNPC("fun_fax", -210, 660)

        Game.world.music:fade(0, 0.25)

        Assets.playSound("mac_start")
        cutscene:slideTo(fun_fax, 310, 660, 0.8, "in-out-quint")

        if not Game:getFlag("met_fun_fax") then
            Game:setFlag("met_fun_fax", true)

            cutscene:wait(5)

            cutscene:text("* [speed:0.2]Mmmmm,[wait:20][speed:0.2]\nyes[speed:0.1]..........")

            fun_fax:setSprite("watching")
            cutscene:wait(3)
            fun_fax:setSprite("searching")
            cutscene:wait(2)
            fun_fax:setSprite("watching")
            cutscene:wait(1)
            fun_fax:setSprite("searching")
            cutscene:wait(0.5)
            fun_fax:setSprite("watching")
            cutscene:wait(0.5)
            fun_fax:setSprite("searching")
            cutscene:wait(0.5)
            fun_fax:setSprite("watching")
            cutscene:wait(0.5)
            fun_fax:setSprite("searching")
            cutscene:wait(0.25)
            fun_fax:setSprite("searching")
            cutscene:wait(0.12)
            fun_fax:setSprite("watching")
            cutscene:wait(0.05)
            fun_fax:setSprite("searching")
            cutscene:wait(0.05)
            fun_fax:setSprite("watching")
            cutscene:wait(0.05)
            fun_fax:setSprite("searching")
            cutscene:wait(0.05)
            fun_fax:setSprite("watching")
            cutscene:wait(0.05)
            fun_fax:setSprite("searching")
            cutscene:wait(0.005)
            fun_fax:setSprite("watching")
            cutscene:wait(0.0005)
            fun_fax:setSprite("searching")
            cutscene:wait(0.00005)
            fun_fax:setSprite("watching")
            cutscene:wait(0.000005)
            fun_fax:setSprite("searching")
            cutscene:wait(0.0000005)
            for _ = 1, 8 do
                fun_fax:setSprite("watching")
                cutscene:wait(0.0000005)
                fun_fax:setSprite("searching")
                cutscene:wait(0.0000005)
            end
            fun_fax:setSprite("searching")
            cutscene:wait(3)
            fun_fax:setSprite("watching")
            cutscene:wait(5)

            cutscene:text("* Alola...")
            cutscene:text("* [speed:0.5]That's a pokemon yaknow...[wait:25]\n...[wait:25]\n...")
            cutscene:text("* [speed:0.25]...[wait:25]\n...[wait:25]\n...")
            cutscene:text("* [speed:0.25]...[wait:25]\n...[wait:25]\n...")

            cutscene:wait(3)
        else
            cutscene:wait(4)
            fun_fax:setSprite("watching")
            cutscene:wait(1)
            fun_fax:setSprite("searching")
            cutscene:wait(0.5)
            fun_fax:setSprite("watching")
            cutscene:wait(0.25)
        end

        fun_fax:setSprite("searching")
        cutscene:wait(0.5)
        Assets.playSound("ui_select")
        cutscene:wait(0.1)

        local random_theme = Music(Utils.pick{
            "deltarune/castletown_empty", "deltarune/field_of_hopes", "deltarune/lancer", "battle",
            "deltarune/forest", "deltarune/THE_HOLY", "deltarune/town", "deltarune/castletown",
            "deltarune/berdly_theme", "deltarune/cybercity", "deltarune/cybercity_alt", "deltarune/queen_car_radio",
            "deltarune/dogcheck", "castle_funk", "greenroom", "keygen_credits",
            "results", "baci_perugina2", "spamton_battle_eb", "battleut",
            "battle2ut", "dance_of_dog", "sigh_of_dog", "options_fall",
            "options_summer", "options_winter", "mus_star", "dogcheck_anniversary",
            "Hugs_for_Ralsei", "Lullaby_for_Lancer", "spamgolor", "spamgolor_battle",
            "spamgolor_shop", "spamgolor_neo", "exception", "warphub",
            "checkpoint", "gildedgrove", "ruins_beta", "cursedcathedral_cover",
            "tickroom", "gimmieyourwalletmiss", "batterup", "threestrikesyoureout",
            "beasts", "room_003", "battle_repainted", "morpho_boss",
            "mirati_bk70cover", "mari_neo",
        }, 0.8, 1)
        cutscene:wait(0.4)
        fun_fax:setSprite("watching")
        cutscene:wait(2)

        local dialogue_pairs = {
            {"* I wrote a book recently...", "* It had a few quotes..."},
            {"* Mama always said life was like a box-o-chocolates...", "* Ya never know what ya might get..."},
            {"* Have you heard of the woody theory...", "* It means there is a friend inside you..."},
            {"* AcousticJamm once said...", "* Brb, I gotta iron my fish..."},
            {"* Did you know sans is Ness...", "* Game Theory told me so..."},
            {"* Did you know Dess is Ness...", "* JaruJaruJ told me so..."},
            {"* I can see your FUN value...", "* I'm not allowed to tell you though..."},
            {"* Don't forget...", "* I'm with you in the dark..."},
            {"* You need to go fast...", "* As fast as you can..."},
            {"* It need to be in an infinity room...", "* There stands a goner who could aid you on your quest..."},
            {"* The DEVS don't know they aren't the real ones...", "* Never tell them this information..."},
            {"* DeltaDreams died for this...", "* Not really..."},
            {"* I can see things far away...", "* I can't see you..."},
            {"* Drink soda...", "* It'll help you see faster..."},
            {"* I had a wife...", "* But they took her in the devorce..."},
            {"* I was created in a night...", "* Sleep deprivation is unhealthy..."},
            {"* This is a full quote in the code...", "* It was just split into two..."},
            {"* If it's not worth it...", "* You should not do it..."},
            {"* Hunger strikes me...", "* I must proceed..."},
            {"* The lore doesn't matter...", "* Just enjoy the fun..."},
            {"* There is nobody behind the tree...", "* I checked..."},
            {"* Time does not matter...", "* It always ends..."},
            {"* Do your choices matter...", "* It always depends..."},
            {"* What is a dark world...", "* A world in darkness..."},
            {"* Is there a light fountain...", "* I would not know..."},
            {"* Do you miss them...", "* You probably don't know who I'm talking about..."},
            {"* Is it fate...", "* Or is it chance..."},
            {"* Gender is odd to me...", "* It keeps being updated..."},
            {"* The end is never...", "* Or so I was told..."},
            {"* The line between fact and fiction can be blurred...", "* Until it isn't there anymore..."},
            {"* Our universe doesn't have a lightner strong enough to seal our fountain...", "* So we looked in other worlds..."},
            {"* Our world grows unstable...", "* A single BAD HOOK could end it all..."},
            {"* A giant schoolgirl and a boot are lurking...", "* They both seem famillar somehow..."},
            {"* What counts as a duplicate...", "* And what does not..."},
            {"* There is only one being more aware then the self aware characters here...", "* How does it feel to be that being?\n* Don't answer,[speed:0.25]I can't hear you."},
            {"* If my thoughts were still in order...", "* I would be able to socialize agian..."},
            {"* The timelines...", "* They're three of them..."},
            {"* A DEV tried to fix me...", "* But I was never broken..."}, --But holy hell did you optimize my fucking shitty code
            {"* I've heard a story once...", "* I forgot how it ends..."},
            {"* The shop out of bounds...", "* The guy inside it is an handful..."},
            {"* People often ask what's my head...", "* I'm getting too old for this..."},
            {"* Simbel once said...", "* I don't have his quote yet..."},
            {"* I tried to talk to people once...", "* But they all just said \"Why are you in my house?\"..."},
            {"* Here's a fact about Kristal...", "* It's a combination of \"Crystal\" and \"Kris\"..."},
            {"* You can recruit your enemies now...", "* But where do they go after the battle..."},
            {"* Keep your friends close to you...", "* And your enemies even closer..."},
            {"* What's canon...", "* Well it's a weapon..."},
            {"* Don't forget to take a break...", "* Lack of sleep is bad, y'know..."},
            {"* It's raining somewhere else...", "* So take out your umbrella..."}
        }

        cutscene:text("[speed:0.5]" .. Utils.pick(dialogue_pairs)[1])

        fun_fax:setSprite("searching")
        cutscene:wait(1.5)
        fun_fax:setSprite("watching")
        cutscene:wait(1.5)

        cutscene:text("[speed:0.5]" .. Utils.pick(dialogue_pairs)[2])

        cutscene:wait(3)
        fun_fax:setSprite("searching")
        Assets.playSound("ui_select")
        random_theme:stop()
        cutscene:wait(0.2)
        fun_fax:setSprite("watching")
        cutscene:wait(2)

        cutscene:slideTo(fun_fax, 800, 660, 0.8, "in-out-quint")
        Assets.playSound("mac_start")
        cutscene:wait(0.2)
        fun_fax:setSprite("searching")
        cutscene:wait(2)

        fun_fax:remove()
        Game.world.music:fade(1, 0.5)
    end
}
