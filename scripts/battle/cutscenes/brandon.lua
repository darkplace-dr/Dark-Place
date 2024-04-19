return {
    hurt = function(cutscene)
        local brandon = Game.battle:getEnemyBattler("brandon")
        if (brandon.hits == 1 or brandon.hits == 2) and brandon.hurt_progress < 1 then
            brandon.hits = 2
            cutscene:text("* Guys,[wait:5] what the hell was that for?!", "angry_c", "susie")
            cutscene:text("* hey im just practicing my second amendment rights here", "neutral_b", "dess")
            cutscene:text("* he literally tried to shoot me", "angry", "dess")
            cutscene:text("* I know but,[wait:5] he's also our friend!", "angry", "susie")
            cutscene:text("* Look,[wait:5] something seriously wrong is going on with him.", "annoyed_down", "susie")
            cutscene:text("* We need to help him out,[wait:5] not attack him!", "annoyed", "susie")
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
            brandon.health = 8000
            brandon.hurt_progress = 1
        end
        if brandon.hits == 3 and brandon.hurt_progress < 2 then
            cutscene:text("* Jamm,[wait:5] what the hell did I just say?!", "angry", "susie")
            cutscene:text("* ...", "shaded_neutral", "jamm")
            brandon.health = 6000
            brandon.hurt_progress = 2
        end
        if brandon.hits == 4 and brandon.hurt_progress < 3 then
            cutscene:text("* Please,[wait:5] stop attacking Brandon!", "angry_b", "susie")
            cutscene:text("* I know he attacked us first,[wait:5] but...", "sad_frown", "susie")
            cutscene:text("* Don't I deserve this,[wait:5] Susie?", "shaded_b", "brandon")
            cutscene:text("* Brandon...", "sad_frown", "susie")
            brandon.health = 4000
            brandon.hurt_progress = 3
        end
        if brandon.hits == 5 and brandon.hurt_progress < 4 then
            cutscene:text("* susie i don't think he's listening to you", "neutral_c", "dess")
            cutscene:text("* Yeah,[wait:5] I can see that...", "bangs_neutral", "susie")
            brandon.health = 2000
            brandon.hurt_progress = 4
        end
        if brandon.hits == 6 and brandon.hurt_progress < 5 then
            cutscene:text("* ...", "bangs_neutral", "susie")
            brandon.health = 1000
            brandon.hurt_progress = 5
        end
    end,

    defeat_violence = function(cutscene)
        local susie = cutscene:getCharacter("susie")
        local jamm = cutscene:getCharacter("jamm")
        local brandon = Game.battle:getEnemyBattler("brandon")
        jamm:setAnimation("battle/attack_ready")
        cutscene:wait(2)
        cutscene:fadeOut(0, {wait = false})
        jamm:setAnimation("battle/attack")
        susie.x = brandon.x - 80
        susie.y = brandon.y - 5
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
        cutscene:text("* ...[wait:10]\n* Wh-what...?", "shaded_b", "brandon")
        cutscene:text("* ...", "bangs_neutral", "susie")
        cutscene:fadeOut(1, {wait = false})
        cutscene:wait(1)
        cutscene:fadeIn(1, {wait = false})
        Game:setFlag("b_fight", true)
        Game:setFlag("b_fight_violence", true)
        Game.battle:returnToWorld()
    end,
}