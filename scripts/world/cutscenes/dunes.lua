return {
    steamworks_gate = function(cutscene, event)
        local ceroba = cutscene:getCharacter("ceroba")
        local gate = Game.world.map:getEvent("steamworks_gate")

        cutscene:showNametag("Ceroba")
        cutscene:text("* You ready to go?", "neutral", "ceroba")
        cutscene:text("* Just remember that we [color:red]won't be able to come back for a while[color:reset].", "closed_eyes", "ceroba")
        cutscene:hideNametag()
        cutscene:text("* WARNING! This area is unfinished, and there's no way to come back without cheats.")
        cutscene:text("* Continue anyway?")
        local opinion = cutscene:choicer({"Yes", "No"})
        if opinion == 1 then
            cutscene:detachFollowers()
            cutscene:detachCamera()
            cutscene:panTo("camspot")
            if Game.party[1].id == "ceroba" then
                cutscene:walkTo(ceroba, "cerobaspot")
                cutscene:walkTo(cutscene:getCharacter(Game.party[2].id), "party1")
                if Game.party[3] then
                    cutscene:walkTo(cutscene:getCharacter(Game.party[3].id), "party2")
                end
                if Game.party[4] then
                    cutscene:walkTo(cutscene:getCharacter(Game.party[4].id), "party3")
                end
            elseif Game.party[2].id == "ceroba" then
                cutscene:walkTo(ceroba, "cerobaspot")
                cutscene:walkTo(cutscene:getCharacter(Game.party[1].id), "party1")
                if Game.party[3] then
                    cutscene:walkTo(cutscene:getCharacter(Game.party[3].id), "party2")
                end
                if Game.party[4] then
                    cutscene:walkTo(cutscene:getCharacter(Game.party[4].id), "party3")
                end
            elseif Game.party[3].id == "ceroba" then
                cutscene:walkTo(ceroba, "cerobaspot")
                cutscene:walkTo(cutscene:getCharacter(Game.party[1].id), "party1")
                cutscene:walkTo(cutscene:getCharacter(Game.party[2].id), "party2")
                if Game.party[4] then
                    cutscene:walkTo(cutscene:getCharacter(Game.party[4].id), "party3")
                end
            elseif Game.party[4].id == "ceroba" then
                cutscene:walkTo(ceroba, "cerobaspot")
                cutscene:walkTo(cutscene:getCharacter(Game.party[1].id), "party1")
                cutscene:walkTo(cutscene:getCharacter(Game.party[2].id), "party2")
                cutscene:walkTo(cutscene:getCharacter(Game.party[3].id), "party3")
            end
            cutscene:wait(3)
            ceroba:setFacing("down")
            cutscene:text("* Okay, I think I still remember the code...", "neutral", "ceroba")
            ceroba:setFacing("up")
            Assets.playSound("dunes_43_code")
            cutscene:wait(3)
            ceroba:setFacing("right")
            Assets.playSound("dunes_43_gate")
            gate:setSprite("world/events/dunes/steamworks_gate", 0.1)
            cutscene:wait(4.5)
            gate:setSprite("world/events/dunes/steamworks_gate_45")
            cutscene:wait(0.5)
            ceroba:setFacing("down")
            cutscene:text("* Well, what are we waiting for? Let's go.", "smile", "ceroba")
            cutscene:wait(cutscene:walkTo(ceroba, gate.x, ceroba.y, 0.8, "up"))
            ceroba:fadeOutAndRemove(0.5)
            cutscene:wait(0.8)
            for _,member in ipairs(Game.party) do
                local chara = Game.world:getCharacter(member.id)
                if chara then
                    cutscene:walkTo(chara, chara.x, gate.y, 1, "up")
                end
            end
            cutscene:wait(0.8)
            cutscene:mapTransition("steamworks/01")
        else
            cutscene:showNametag("Ceroba")
            cutscene:text("* Just don't take too long,[wait:5] alright?", "neutral", "ceroba")
            cutscene:hideNametag()
            cutscene:walkTo(Game.world.player, Game.world.player.x, Game.world.player.y + 80, 0.8)
        end
    end,
}
