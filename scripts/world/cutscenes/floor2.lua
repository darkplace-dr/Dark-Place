return {
    queen_sip = function(cutscene, event)
        Assets.playSound("queen/queensip_1")
        cutscene:text("[noskip]*[wait:3s]", "sip", "queen", {auto = true})

        if Game:hasPartyMember("YOU") then
            cutscene:text("* Susie Blue Frog That Isn't Kris How Do You Like My New:", "smile", "queen")
        elseif Game:hasPartyMember("kris") then
            cutscene:text("* Kris Susie How Do You Like My New:", "smile", "queen")
		else
            cutscene:text("* Greetings Everyone How Do You Like My New:", "smile", "queen")
        end
		
        Assets.playSound("queen/queensip_2")
        cutscene:text("[noskip]*[wait:1s]", "sip", "queen", {auto = true})
		
        cutscene:text("* Room", "smile", "queen")

        Assets.playSound("queen/queensip_3")
        cutscene:text("[noskip]*[wait:2s]", "sip", "queen", {auto = true})

        cutscene:text("* Do You Want A Sip", "smile", "queen")
        cutscene:text("* Uhh...[wait:3] that's acid. We'd die.", "nervous_side", "susie")
        cutscene:text("* Oh Dear First You Don't Want To Swim In The Free Pool", "smile", "queen")
        cutscene:text("* Now You Don't Want To Drink The Free Pool Water", "pout", "queen")
        cutscene:text("* More For Me I Suppose", "smile_side_l", "queen")
    end,
}