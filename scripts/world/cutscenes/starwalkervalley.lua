return {

    smallwalker1 = function(cutscene)
        cutscene:text("* The [color:yellow]city[color:reset] is [color:yellow]Annoying[color:reset] me...")
        cutscene:text("* I'm a   [color:yellow]Smallwalker[color:reset]")
    end,
    
    smallwalker2 = function(cutscene)
        cutscene:text("* I'm [color:yellow]hiding[color:reset]...")
        cutscene:text("* I'm a   [color:yellow]Smallwalker[color:reset]")
    end,

    starwalker1 = function(cutscene)
        cutscene:text("* This [color:yellow]Kid[color:reset] is [color:yellow]Pissing[color:reset] me off...")
        cutscene:text("* I'm a   [color:yellow]Starwalker[color:reset]")
    end,

    starwalker2 = function(cutscene)
        cutscene:text("* My [color:yellow]Fucking[color:reset] kid is [color:yellow]Gone[color:reset]...")
        cutscene:text("* I'm a   [color:yellow]Sadwalker[color:reset]")
    end,




    bigwalker = function(cutscene)
        cutscene:text("* These [color:red]Walkers[color:reset] are [color:red]Enraging[color:reset] me...")
        cutscene:text("* I'm the   [color:yellow]Big Walker[color:reset]")

        if Game:hasPartyMember("starwalker") then
            cutscene:showNametag("Starwalker?")
            cutscene:text("* Hi   [color:yellow]Father[color:reset]")
            cutscene:hideNametag()
            cutscene:text("* Hi   [color:yellow]Son[color:reset]")
        end
    end,

}