local Lib = {}

function Lib:init()
    print("Loaded city_traffic!")
end

function Lib:onEnterTraffic(region, follower)
    if follower.actor.id == "noelle" and Kristal.getLibConfig("city_traffic", "doNoelleScaredInTraffic") then
        follower.visible                = false

        follower.noelle_traffic         = NoelleTraffic(follower.x, follower.y)
        follower.noelle_traffic.noelle  = follower
        follower.noelle_traffic.region  = region

        follower.noelle_traffic:setFrame(follower.sprite.frame)

        Game.world:spawnObject(follower.noelle_traffic, follower.layer)
        return true
    end
end

function Lib:onExitTraffic(region, follower)
    if follower.actor.id == "noelle" and follower.noelle_traffic then
        follower.x = follower.noelle_traffic.x
        follower.y = follower.noelle_traffic.y

        follower:interpolateHistory()

        follower.noelle_traffic:remove()
        follower.noelle_traffic = nil

        follower.visible        = true
    end
end

return Lib