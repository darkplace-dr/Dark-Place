return {
    deal = function(cutscene, battler, enemy)
        cutscene:text("* You took one of Spamgolor's deals.")
        Assets.playSound("ui_cancel")
        cutscene:text("* You felt your wallet becoming lighter.")
        local loss = love.math.random(1, 100)
        Game.money = Game.money - loss
        cutscene:text("* You lost "..loss.." D$...")
    end,

    x_deal = function(cutscene, battler, enemy)
        cutscene:text("* You and Susie took some of Spamgolor's deals.")
        Assets.playSound("ui_cancel")
        cutscene:text("* You felt your wallet becoming lighter.")
        local loss = love.math.random(50, 300)
        Game.money = Game.money - loss
        cutscene:text("* You lost $"..loss.."...")
    end,

    heal_deal = function(cutscene, battler, enemy)
        local price = love.math.random(150, 300)

        cutscene:text("* Spamgolor offered you a healing item for $"..price.."\n* You have $"..Game.money..".")
        cutscene:text("* Will you buy it?")

        if cutscene:choicer({"Yes", "No"}) == 2 then
            enemy.dialogue_override = "DON'T BE A\n[Windows 95]\nSHOPPER!"
            cutscene:text("* You decided not to buy anything.")
            return
        end

        if Game.money >= price then
            Assets.playSound("equip")
            Game.money = Game.money - price
            cutscene:text("* You bought the healing item!")
            for _,battler in ipairs(Game.battle.party) do
                battler:heal(60)
            end
            cutscene:text("* Everyone was healed!")
        else
            enemy.dialogue_override = "[Money] NO."
            cutscene:text("* You didn't have enough money...")
        end
    end,

    susie_talk = function(cutscene, battler, enemy)
        cutscene:text("* Susie tried to talk to Spamgolor...")

        cutscene:text("* Hey,[wait:5] we should like...", "nervous_side", "susie")
        cutscene:text("* Stop fighting,[wait:5] or something...", "nervous", "susie")

        cutscene:text("* WHY THE [[$4.99]] SHOULD WE DO THAT?", "", "spamgolor")

        cutscene:text("* Uh...[wait:10] I dunno...", "shock_nervous", "susie")
        cutscene:text("* PACIFISM IS HARD,[wait:5] OKAY?!", "teeth_b", "susie")

        cutscene:text("* But nothing of use happened...")
    end,

    brandon_insult = function(cutscene, battler, enemy)
        cutscene:text("* Brandon tried to insult Spamgolor...")

        cutscene:text("* Your Jordans are completely fake!", "miffed", "brandon")

        cutscene:text("* ... WHAT...", "", "spamgolor")

        cutscene:text("* Wait I forgot you don't even have feet.", "shock", "brandon")

        cutscene:text("* But nothing of use happened...")
    end
}