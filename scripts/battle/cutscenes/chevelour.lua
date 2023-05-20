return {
    Insult = function(cutscene, battler, enemy)
        local rnd = math.random(1, 4)
        if rnd == 1 then
            cutscene:text("* You told Chevelour that American cheese is better than cream cheese.")
            cutscene:text("* Chevelour was offended. Her AT increased!") 
            enemy.dialogue_override = "Not even real cheese!"
        elseif rnd == 2 then
            cutscene:text("* You told Chevelour that her donut is actually a bagel.")
            cutscene:text("* Chevelour was offended. Her AT increased!")
            enemy.dialogue_override = "It's a donut! *squeak*"
        elseif rnd == 3 then
            cutscene:text("* You told Chevelour that she has zero skateboard skills.")
            cutscene:text("* Chevelour was offended. Her AT increased!")
            enemy.dialogue_override = "He's a stupid dog!"
        else
            cutscene:text("* You told Chevelour that she looks like she lives in trash.")
            cutscene:text("* Chevelour was offended. Her AT increased!")
            enemy.dialogue_override = "Trash-talker huh? *squeak*"
        end
    end,

    X2_Insult = function(cutscene, battler, enemy)
        local rnd = math.random(1, 4)
        if rnd == 1 then
            cutscene:text("* You and Susie told Chevelour that American cheese is better than\ncream cheese.")
            cutscene:text("* At least American cheese is a mix of cheese.", "annoyed", "susie")
            cutscene:text("* And cream cheese is just spread!", "annoyed", "susie")
            cutscene:text("* Chevelour was offended. Her AT increased greatly!")  
            enemy.dialogue_override = "Not even real cheese!"
        elseif rnd == 2 then
            cutscene:text("* You and Susie told Chevelour that her donut is actually a bagel.")
            cutscene:text("* It's not even a donut at all!", "teeth", "susie")
            cutscene:text("* It's a freaking bagel!!!", "teeth_b", "susie")
            cutscene:text("* WITH JAM AND CHEESE!!!", "teeth_b", "susie")
            cutscene:text("* Chevelour was offended. Her AT increased greatly!")
            enemy.dialogue_override = "It's a donut! *squeak*"
        elseif rnd == 3 then
            cutscene:text("* You and Susie told Chevelour that she has zero skateboard skills.")
            cutscene:text("* You know there's a skater better than you, right?", "smile", "susie")
            cutscene:text("* It's Toby Radiation Fox!", "teeth_smile", "susie")
            cutscene:text("* Chevelour was offended. Her AT increased greatly!")
            enemy.dialogue_override = "He's a stupid dog!"
        else
            cutscene:text("* You and Susie told Chevelour that she looks like she lives in trash.")
            cutscene:text("* Those visors look like you dumpster dived for them...", "surprise_smile", "susie")
            cutscene:text("* Chevelour was offended. Her AT increased greatly!")
            enemy.dialogue_override = "Trash-talker huh? *squeak*"
        end
    end,
}