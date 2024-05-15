return {
    comfort1 = function(cutscene)
        local brenda = Game.battle:getEnemyBattler("brenda")
        cutscene:text("* Please,[wait:5] Brenda,[wait:5] you're a great friend,[wait:5] I don't want to fight you.", "sad_frown", "susie")
        cutscene:text("* And what makes you think that?", "shaded", "brenda")
        cutscene:text("* Well you're fun to be around,[wait:5] for one.", "sincere_smile", "susie")
        cutscene:text("* Remember that time we saved Berdly together?", "sincere", "susie")
        cutscene:text("* I...", "shaded_b", "brenda")
        brenda:addMercy(10)
        brenda.comfort = brenda.comfort + 1
    end,

    comfort2 = function(cutscene)
        local brenda = Game.battle:getEnemyBattler("brenda")
        cutscene:text("* yeah what susie said", "neutral_c", "dess")
        cutscene:text("* look i know im an annoying asshole but...", "neutral_b", "dess")
        cutscene:text("* i still care about you", "neutral", "dess")
        cutscene:text("* you're like one of the few people that actually tollerate my existence", "genuine_b", "dess")
        cutscene:text("* why don't we just talk it out", "neutral", "dess")
        cutscene:text("* ...", "shaded_b", "brenda")
        cutscene:text("* (Dess...[wait:10] I didn't know you cared about her...)", "sad", "susie")
        brenda:addMercy(10)
        brenda.comfort = brenda.comfort + 1
    end,

    comfort3 = function(cutscene)
        local brenda = Game.battle:getEnemyBattler("brenda")
        cutscene:text("* Brenda,[wait:5] I get that we may have our differences sometimes...", "nervous_left", "jamm")
        cutscene:text("* But you're one of the few people who help keep me sane.", "worried", "jamm")
        cutscene:text("* I may not have shown it much,[wait:5] but I really appreciate you.", "wink", "jamm")
        cutscene:text("* Thank you so much for being my friend,[wait:5] Brenda.", "side_smile", "jamm")
        cutscene:text("* Dess is right.[wait:10]\n* Let's talk it out over some tea.", "worried", "jamm")
        cutscene:text("* Wh...", "shaded_b", "brenda")
        cutscene:text("* (Jamm... [wait:10]I didn't know you could be so...)", "sad", "susie")
        brenda:addMercy(10)
        brenda.comfort = brenda.comfort + 1
    end,

    dk_comfort1 = function(cutscene)
        local brenda = Game.battle:getEnemyBattler("brenda")
        cutscene:text("* look,[wait:5] i know what it feels like to fuck things up", "neutral_b", "dess")
        cutscene:text("* and i mean like,[wait:5] SERIOUSLY fuck things up", "neutral", "dess")
        cutscene:text("* you think you're doing the right thing at first...", "neutral_b", "dess")
        cutscene:text("* ... and then the consequences of your actions catch up to you.", "neutral_b", "dess")
        cutscene:text("* then you feel like garbage afterwards", "neutral_c", "dess")
        cutscene:text("* ...", "shaded_neutral", "jamm")
        cutscene:text("* (... Is...[wait:10] Jamm doing alright...?)", "sad", "susie")
        brenda:addMercy(15)
        brenda.comfort = brenda.comfort + 1
    end,

    dk_comfort2 = function(cutscene)
        local brenda = Game.battle:getEnemyBattler("brenda")
        cutscene:text("* but everyone makes mistakes", "kind", "dess")
        cutscene:text("* so there's no reason to feel like you're the worst person in the world", "neutral", "dess")
        cutscene:text("* just have it be a learning experience", "heckyeah", "dess")
        cutscene:text("* like susie said,[wait:5] i don't really wanna fight you either...", "neutral_b", "dess")
        cutscene:text("* Dess,[wait:5] I...", "shaded", "brenda")
        brenda:addMercy(15)
        brenda.comfort = brenda.comfort + 1
    end,

    dk_comfort3 = function(cutscene)
        local brenda = Game.battle:getEnemyBattler("brenda")
        cutscene:text("* Look,[wait:5] Brenda,[wait:5] I'm not mad at all for that whole Spamgolor thing.", "sad_frown", "susie")
        cutscene:text("* I'd have broken that wall down even if I didn't have your help.", "shy_b", "susie")
        if Game:getFlag("spamgolorneo_killed") then
            cutscene:text("* And,[wait:5] to be honest...", "shy", "susie")
            cutscene:text("* I don't think you're in the wrong for doing what you did to him...", "shy_down", "susie")
            cutscene:text("* As much as I'd prefer you didn't kill him...", "annoyed", "susie")
            cutscene:text("* He did sort of force that as your only option...", "annoyed_down", "susie")
        else
            cutscene:text("* Look,[wait:5] I'm probably just as reckless as you are.", "nervous", "susie")
            cutscene:text("* There's no need to be upset at yourself over that,[wait:5] I forgive you.", "small_smile", "susie")
        end
        cutscene:text("* Susie...", "shaded", "brenda")
        brenda:addMercy(20)
        brenda.comfort = brenda.comfort + 1
    end,

    dk_comfort4 = function(cutscene)
        local brenda = Game.battle:getEnemyBattler("brenda")
        cutscene:text("* So please,[wait:5] let's stop fighting and just talk things out.", "sad", "susie")
        cutscene:text("* I don't wanna hurt you,[wait:5] man.", "sad_frown", "susie")
        cutscene:text("* I care too much about you to do that.", "shy_down", "susie")
        cutscene:text("* yeah same here", "neutral", "dess")
        cutscene:text("* i know you tried to shoot me,[wait:5] but...", "neutral_b", "dess")
        cutscene:text("* i still want to help you out", "genuine", "dess")
        cutscene:text("* Guys,[wait:5] I...", "shaded", "brenda")
        brenda:addMercy(30)
        Game.battle.music:fade(0, 1)
        cutscene:wait(3)
        cutscene:fadeOut(1, {wait = false})
        cutscene:wait(1)
        cutscene:fadeIn(1, {wait = false})
        Game:setFlag("b_fight", true)
        Game.battle:returnToWorld()
    end,

    hurt = function(cutscene)
        local brenda = Game.battle:getEnemyBattler("brenda")
        if (brenda.hits == 1 or brenda.hits == 2) and brenda.hurt_progress < 1 then
            brenda.hits = 2
            cutscene:text("* Guys,[wait:5] what the hell was that for?!", "angry_c", "susie")
            cutscene:text("* hey im just practicing my second amendment rights here", "neutral_b", "dess")
            cutscene:text("* she literally tried to shoot me", "angry", "dess")
            cutscene:text("* I know but,[wait:5] she's also our friend!", "angry", "susie")
            cutscene:text("* Look,[wait:5] something seriously wrong is going on with her.", "annoyed_down", "susie")
            cutscene:text("* We need to help her out,[wait:5] not attack her!", "annoyed", "susie")
            cutscene:text("* i...", "neutral", "dess")
            cutscene:text("* ...", "neutral_b", "dess")
            cutscene:text("* got it", "neutral", "dess")
            cutscene:text("* That goes for you too,[wait:5] Jamm.", "annoyed", "susie")
            cutscene:text("* ...", "shaded_neutral", "jamm")
            Game:setFlag("b_fight_dess", true)
            local dess_party = Game:getPartyMember("dess")
            if dess_party:hasSpell("starshot") then
                dess_party:removeSpell("starshot")
                Game:setFlag("b_fight_starshot", true)
            end
            if dess_party:hasSpell("starstorm") then
                dess_party:removeSpell("starstorm")
                Game:setFlag("b_fight_starstorm", true)
            end
            brenda.health = 8000
            brenda.hurt_progress = 1
        end
        if brenda.hits == 3 and brenda.hurt_progress < 2 then
            cutscene:text("* Jamm,[wait:5] what the hell did I just say?!", "angry", "susie")
            cutscene:text("* ...", "shaded_neutral", "jamm")
            brenda.health = 6000
            brenda.hurt_progress = 2
        end
        if brenda.hits == 4 and brenda.hurt_progress < 3 then
            cutscene:text("* Please,[wait:5] stop attacking Brenda!", "angry_b", "susie")
            cutscene:text("* I know she attacked us first,[wait:5] but...", "sad_frown", "susie")
            cutscene:text("* Don't I deserve this,[wait:5] Susie?", "shaded_b", "brenda")
            cutscene:text("* Brenda...", "sad_frown", "susie")
            brenda.health = 4000
            brenda.hurt_progress = 3
        end
        if brenda.hits == 5 and brenda.hurt_progress < 4 then
            cutscene:text("* susie i don't think he's listening to you", "neutral_c", "dess")
            cutscene:text("* Yeah,[wait:5] I can see that...", "bangs_neutral", "susie")
            brenda.health = 2000
            brenda.hurt_progress = 4
        end
        if brenda.hits == 6 and brenda.hurt_progress < 5 then
            cutscene:text("* ...", "bangs_neutral", "susie")
            brenda.health = 1000
            brenda.hurt_progress = 5
        end
    end,

    defeat_violence = function(cutscene)
        local susie = cutscene:getCharacter("susie")
        local jamm = cutscene:getCharacter("jamm")
        local brenda = Game.battle:getEnemyBattler("brenda")
        jamm:setAnimation("battle/attack_ready")
        cutscene:wait(2)
        cutscene:fadeOut(0, {wait = false})
        jamm:setAnimation("battle/attack")
        susie.x = brenda.x - 80
        susie.y = brenda.y - 5
        susie.flip_x = true
        susie:setSprite("battle/defeat")
        Game.battle.music:stop()
        Assets.stopAndPlaySound("sling")
        cutscene:wait(2)
        cutscene:fadeIn(0, {wait = false})
        Assets.stopAndPlaySound("damage")
        susie:shake(5)
        cutscene:wait(3)
        cutscene:text("* ", "wtf_b", "dess")
        cutscene:text("* ...[wait:10]\n* Wh-what...?", "shaded_b", "brenda")
        cutscene:text("* ...", "bangs_neutral", "susie")
        cutscene:fadeOut(1, {wait = false})
        cutscene:wait(1)
        cutscene:fadeIn(1, {wait = false})
        Game:setFlag("b_fight", true)
        Game:setFlag("b_fight_violence", true)
        Game.battle:returnToWorld()
    end,
}
