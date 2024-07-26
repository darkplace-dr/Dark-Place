return {
    doc = function(cutscene, event)
        local price = 30 * #Game.party

        if not Game:getFlag("wildeast_docmet") then
            cutscene:showNametag("Doctor?")
            cutscene:text("* Welcome to the Wild East\nClinic!", nil, event)
            cutscene:text("* We put the \"hospital\" in\nhospitality!", nil, event)
            cutscene:showNametag("The Doc")
            cutscene:text("* They call me The Doc!", nil, event)
            cutscene:text("* Are you sick?[wait:5] Hurt?", nil, event)
            local opinion = cutscene:textChoicer("* What is your diagnosis?\n", {"Uh...", "  Hurt"}, nil, event)
            if opinion == 1 then
                cutscene:text("* Ah,[wait:5] a shy one![wait:5] No problem!", nil, event)
            else
                cutscene:text("* Yes of course!", nil, event)
                cutscene:text("* We have a tough one!", nil, event)
            end
            cutscene:text("* I have just the boost you need!", nil, event)
            cutscene:text("* For an upfront price of 30G\nper person I can OVERCHARGE\nyour health!", nil, event)
            cutscene:text("* It is an...[wait:10] experimental\nmedicine but who said\nI was qualified?", nil, event)
            local opinion = cutscene:textChoicer("* What do you say?\n", {"Deal", "   No thanks"}, nil, event)
            if opinion == 1 then
                if Game.lw_money < price then
                    Assets.playSound("error")
                else
                    Game.lw_money = Game.lw_money - price
                    cutscene:text("* Come closer and I'll begin the\nprocedure!", nil, event)
                    cutscene:text("* Mhm,[wait:5] I see.", nil, event)
                    cutscene:text("* Little bit of this...", nil, event)
                    cutscene:text("* Aaaand done!", nil, event)
                    cutscene:hideNametag()
                    for _,pm in ipairs(Game.party) do
                        pm:setHealth(pm:getStat("health") + 15)
                    end
                    Assets.playSound("won")
                    cutscene:text("* (You gained +15 extra HP!)")
                    cutscene:showNametag("The Doc")
                    cutscene:text("* When the energy wears off,[wait:5] it's\ngone for good!", nil, event)
                    cutscene:text("* You can always visit me again\nfor more but only one at a time!", nil, event)
                    cutscene:text("* I might take risks but I'm not\ncrazy![wait:5] Ha ha...[wait:10] Ahem.", nil, event)
                end
            else
                cutscene:text("* Sorry to hear that!", nil, event)
                cutscene:text("* I'll always be here if you need\nanything!", nil, event)
            end
        else
            local boosted = false
            for _,pm in ipairs(Game.party) do
                if pm:getHealth() > pm:getStat("health") then
                    boosted = true
                    break
                end
            end

            cutscene:showNametag("The Doc")
            if boosted then
                cutscene:text("* Your overcharge needs to\ndeplete before I can do another\nprocedure!", nil, event)
            else
                cutscene:text("* Hello again!", nil, event)
                cutscene:text("* Need a boost?", nil, event)
                local opinion = cutscene:textChoicer("* Keep in mind that this is\n30G per person!", {"Yes", "    No thanks"}, nil, event)
                if opinion == 1 then
                    if Game.lw_money < price then
                        Assets.playSound("error")
                    else
                        Game.lw_money = Game.lw_money - price
                        cutscene:text("* Alright![wait:5] Let's begin!", nil, event)
                        cutscene:text("* Little bit of this...", nil, event)
                        cutscene:text("* Aaaand done!", nil, event)
                        cutscene:hideNametag()
                        for _,pm in ipairs(Game.party) do
                            pm:setHealth(pm:getStat("health") + 15)
                        end
                        Assets.playSound("won")
                        cutscene:text("* (You gained +15 extra HP!)")
                        cutscene:showNametag("The Doc")
                        cutscene:text("* Thank you![wait:5] Come again soon!", nil, event)
                    end
                else
                    cutscene:text("* Sorry to hear that!", nil, event)
                    cutscene:text("* I'll always be here if you need\nanything!", nil, event)
                end
            end
        end
        cutscene:hideNametag()
        Game:setFlag("wildeast_docmet", true)
    end,
}