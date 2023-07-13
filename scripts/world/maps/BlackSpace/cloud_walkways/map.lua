local CloudWalkways, super = Class(Map)

function CloudWalkways:onEnter()
    super.onEnter(self)
	
    local bs_clouds = Sprite("objects/bs_clouds")
    bs_clouds:setWrap(true)
    bs_clouds.physics.speed_x = 1
    bs_clouds.physics.speed_y = 1
    Game.world:addChild(bs_clouds)
end

return CloudWalkways
