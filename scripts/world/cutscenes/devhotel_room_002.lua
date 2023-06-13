return {
    entry = function(cutscene, event)
        local susie = cutscene:getCharacter("susie")
        if susie then
            cutscene:wait(1)
            cutscene:showNametag("Susie")
            cutscene:text("[voice:susie]* Huh... Guess we fit afterall", "surprise_smile", "susie")
            cutscene:hideNametag()

            Game:setFlag("enter_velvet_room", true)
        end
    end,

    transition = function(cutscene, event)
        Game.world:mapTransition("devhotel1", "door_002")
    end
}