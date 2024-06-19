return {
    doc = function(cutscene, event)

        if Game.party[4] then
            Game:setFlag("wildeast_docprice", 120)
        elseif Game.party[3] then
            Game:setFlag("wildeast_docprice", 90)
        elseif Game.party[2] then
            Game:setFlag("wildeast_docprice", 60)
        else
            Game:setFlag("wildeast_docprice", 30)
        end

        if Game:getFlag("wildeast_docmet")~=true then
            cutscene:showNametag("Doctor?")
            cutscene:text("* Welcome to the Wild East\nClinic!")
            cutscene:text("* We put the \"hospital\" in\nhospitality!")
            cutscene:showNametag("The Doc")
            cutscene:text("* They call me The Doc!")
            cutscene:text("* Are you sick?[wait:5] Hurt?")
            local opinion = cutscene:textChoicer("* What is your diagnosis?\n", {"Uh...", "  Hurt"})
            if opinion == 1 then
                cutscene:text("* Ah,[wait:5] a shy one![wait:5] No problem!")
            else
                cutscene:text("* Yes of course!")
                cutscene:text("* We have a tough one!")
            end
            cutscene:text("* I have just the boost you need!")
            cutscene:text("* For an upfront price of 30G\nper person I can OVERCHARGE\nyour health!")
            cutscene:text("* It is an...[wait:10] experimental\nmedicine but who said\nI was qualified?")
            local opinion = cutscene:textChoicer("* What do you say?\n", {"Deal", "   No thanks"})
            if opinion == 1 then
                if Game.lw_money < Game:getFlag("wildeast_docprice") then
                    Assets.playSound("error")
                else
                    Game.lw_money = Game.lw_money - Game:getFlag("wildeast_docprice")
                    cutscene:text("* Come closer and I'll begin the\nprocedure!")
                    cutscene:text("* Mhm,[wait:5] I see.")
                    cutscene:text("* Little bit of this...")
                    cutscene:text("* Aaaand done!")
                    cutscene:hideNametag()
                    Game.party[1]:setHealth(Game.party[1]:getStat("health") + 15)
                    if Game.party[2] then
                        Game.party[2]:setHealth(Game.party[2]:getStat("health") + 15)
                    end
                    if Game.party[3] then
                        Game.party[3]:setHealth(Game.party[3]:getStat("health") + 15)
                    end
                    if Game.party[4] then
                        Game.party[4]:setHealth(Game.party[4]:getStat("health") + 15)
                    end
                    Assets.playSound("success")
                    cutscene:text("* (You gained +15 extra HP!)")
                    cutscene:showNametag("The Doc")
                    cutscene:text("* When the energy wears off,[wait:5] it's\ngone for good!")
                    cutscene:text("* You can always visit me again\nfor more but only one at a time!")
                    cutscene:text("* I might take risks but I'm not\ncrazy![wait:5] Ha ha...[wait:10] Ahem.")
                end
            else
                cutscene:text("* Sorry to hear that!")
                cutscene:text("* I'll always be here if you need\nanything!")
            end

            cutscene:hideNametag()
            Game:setFlag("wildeast_docmet", true)
        else
            Game:setFlag("party_haslighthealthboost", false)
            if Game.party[1]:getHealth() > Game.party[1]:getStat("health") then
                Game:setFlag("party_haslighthealthboost", true)
            end
            if Game.party[2] then
                if Game.party[2]:getHealth() > Game.party[2]:getStat("health") then
                    Game:setFlag("party_haslighthealthboost", true)
                end
            end
            if Game.party[3] then
                if Game.party[3]:getHealth() > Game.party[3]:getStat("health") then
                    Game:setFlag("party_haslighthealthboost", true)
                end
            end
            if Game.party[4] then
                if Game.party[4]:getHealth() > Game.party[4]:getStat("health") then
                    Game:setFlag("party_haslighthealthboost", true)
                end
            end

            cutscene:showNametag("The Doc")
            if Game:getFlag("party_haslighthealthboost")==true then
                cutscene:text("* Your overcharge needs to\ndeplete before I can do another\nprocedure!")
            else
                cutscene:text("* Hello again!")
                cutscene:text("* Need a boost?")
                local opinion = cutscene:textChoicer("* Keep in mind that this is\n30G per person!", {"Yes", "    No thanks"})
                if opinion == 1 then
                    if Game.lw_money < Game:getFlag("wildeast_docprice") then
                        Assets.playSound("error")
                    else
                        Game.lw_money = Game.lw_money - Game:getFlag("wildeast_docprice")
                        cutscene:text("* Alright![wait:5] Let's begin!")
                        cutscene:text("* Little bit of this...")
                        cutscene:text("* Aaaand done!")
                        cutscene:hideNametag()
                        Game.party[1]:setHealth(Game.party[1]:getStat("health") + 15)
                        if Game.party[2] then
                            Game.party[2]:setHealth(Game.party[2]:getStat("health") + 15)
                        end
                        if Game.party[3] then
                            Game.party[3]:setHealth(Game.party[3]:getStat("health") + 15)
                        end
                        if Game.party[4] then
                            Game.party[4]:setHealth(Game.party[4]:getStat("health") + 15)
                        end
                        Assets.playSound("success")
                        cutscene:text("* (You gained +15 extra HP!)")
                        cutscene:showNametag("The Doc")
                        cutscene:text("* Thank you![wait:5] Come again soon!")
                    end
                else
                    cutscene:text("* Sorry to hear that!")
                    cutscene:text("* I'll always be here if you need\nanything!")
                end
            end
            cutscene:hideNametag()
        end
    end,
}
