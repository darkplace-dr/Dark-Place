return {
    deal = function(cutscene, battler, enemy)
        cutscene:text("* You took one of Spamgolor's deals.")

        Assets.playSound("ui_cancel")
        cutscene:text("* You felt your wallet becoming lighter.")

        local loss = love.math.random(1, 100)
        Game.money = Game.money - loss
        cutscene:text("* You lost "..loss.." D$...")

        enemy.dialogue_override = "PLEASURE DOING\n[[Shady Business]]\nWITH YOU, KID!"
    end,

    x_deal = function(cutscene, battler, enemy)
        cutscene:text("* You and Susie took some of Spamgolor's deals.")

        Assets.playSound("ui_cancel")
        cutscene:text("* You felt your wallet becoming lighter.")

        local loss = love.math.random(50, 300)
        Game.money = Game.money - loss
        cutscene:text("* You lost $"..loss.."...")
		
        enemy.dialogue_override = "PLEASURE DOING\n[[Shady Business]]\nWITH YOU TWO!"
    end,

    heal_deal = function(cutscene, battler, enemy)
        local price = love.math.random(150, 300)

        cutscene:text("* Spamgolor offered you a healing item for $"..price.."\n* You have $"..Game.money..".")
        cutscene:text("* Will you buy it?")

        if cutscene:choicer({"Yes", "No"}) == 2 then
            cutscene:text("* You decided not to buy anything.")
			
            enemy.dialogue_override = "DON'T BE A\n[Windows 95]\nSHOPPER!"

            return
        end

        if Game.money < price then
            cutscene:text("* You didn't have enough money...")

            enemy.dialogue_override = "[Money] NO."

            return
        end

        Assets.playSound("equip")
        Game.money = Game.money - price
        cutscene:text("* You bought the healing item!")

        for _,battler in ipairs(Game.battle.party) do
            battler:heal(60)
        end
        cutscene:text("* Everyone was healed!")

        enemy.dialogue_override = "ENJOY YOUR\n[Healing Item]!"
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

    brenda_insult = function(cutscene, battler, enemy)
        cutscene:text("* Brenda tried to insult Spamgolor...")

        cutscene:text("* Your Jordans are completely fake!", "miffed", "brenda")

        cutscene:text("* ... WHAT...", "", "spamgolor")

        cutscene:text("* Wait I forgot you don't even have feet.", "shock", "brenda")

        cutscene:text("* But nothing of use happened...")
    end,

    frisk2_talk = function(cutscene, battler, enemy)
        cutscene:text("* Frisk tried to initiate a conversation with Spamgolor...")

        cutscene:text("* So do you like.", "neutral", "frisk2")
        cutscene:text("* Come here often?", "neutral", "frisk2")
		
        cutscene:text("* NO[wait:5], NOT REALLY.", "", "spamgolor")

        cutscene:text("* Oh ok I see, Thanks.", "neutral", "frisk2")
    end,
}
