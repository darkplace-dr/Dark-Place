local diamondwarproom, super = Class(Map)

function diamondwarproom:onEnter()
    super.onEnter(self)
    party = party or Game.party
    Game.world:spawnObject(SpaceBG(), "objects_bg")

    --[[if Game.party[1] then 
        local party1 = Game.party[1].id
        print(party1)
        Game.world:spawnNPC(party1.."_master", Game.world.player.x, Game.world.player.y, {cutscene = "master."..party1})
    else
    end

    if Game.party[2] then 
        local party2 = Game.party[2].id
        print(party2)
        Game.world:spawnNPC(party2.."_master", Game.world.player.x, Game.world.player.y, {cutscene = "master."..party2})
    else
    end

    if Game.party[3] then 
        local party3 = Game.party[3].id
        print(party3)
        Game.world:spawnNPC(party3.."_master", Game.world.player.x, Game.world.player.y, {cutscene = "master."..party3})
    else
    end

    if Game.party[4] then 
        local party4 = Game.party[4].id
        print(party4)
        Game.world:spawnNPC(party4.."_master", Game.world.player.x, Game.world.player.y, {cutscene = "master."..party4})
    else
    end]]

end
return diamondwarproom