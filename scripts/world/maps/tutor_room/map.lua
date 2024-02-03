local tutor_room, super = Class(Map)

function tutor_room:onEnter()
    super.onEnter(self)
    party = party or Game.party
    local why = 400


    if Game.party[1] then 
        local party1 = Game.party[1].id
        print(party1)
        Game.world:spawnNPC(party1.."_master", 180, why, {cutscene = "master."..party1})
    else
    end

    if Game.party[2] then 
        local party2 = Game.party[2].id
        print(party2)
        Game.world:spawnNPC(party2.."_master", 260, why, {cutscene = "master."..party2})
    else
    end

    if Game.party[3] then 
        local party3 = Game.party[3].id
        print(party3)
        Game.world:spawnNPC(party3.."_master", 340, why, {cutscene = "master."..party3})
    else
    end

    if Game.party[4] then 
        local party4 = Game.party[4].id
        print(party4)
        Game.world:spawnNPC(party4.."_master", 420, why, {cutscene = "master."..party4})
    else
    end

end
return tutor_room