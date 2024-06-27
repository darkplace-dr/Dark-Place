local EbottBGClouds, super = Class(Event)

function EbottBGClouds:init(data)
    super:init(self, data.center_x, data.center_y)

    self.cloud_1 = Assets.getTexture("world/maps/ebott/cloud")
    self.cloud_2 = Assets.getTexture("world/maps/ebott/cloud")

    self.timer = 0

    for i = 1, math.floor(Game.world.map.width / 8) do
        local cloud_index = ((i - 1) % 4) + 1
        local x_offset = math.floor((i - 1) / 4)
        if cloud_index == 1 then
            self:createCloud(self.cloud_2, x_offset + -244, 238/2, 0.2 , 0.5,  0.9, {1, 1, 1})
        elseif cloud_index == 2 then
            self:createCloud(self.cloud_1, x_offset + 154,  154/2, 0.35, 0.6,  0.9, {1, 1, 1})
        elseif cloud_index == 3 then
            self:createCloud(self.cloud_2, x_offset - 560,  240/2, 0.25, 0.55, 0.9, {1, 1, 1})
        elseif cloud_index == 4 then
            self:createCloud(self.cloud_1, x_offset - 840,  190/2, 0.25, 0.5,  0.9, {1, 1, 1})
        end
    end
end

function EbottBGClouds:createCloud(asset, x, y, speed, parallax_x, parallax_y, color)
    local cloud = EbottCloud(asset, x, y, speed, parallax_x, parallax_y)
    if color then
        cloud:setColor(color)
    end
    self:addChild(cloud)
    return cloud
end

function EbottBGClouds:draw()

    super:draw(self)
end

return EbottBGClouds
