---@class TrafficArea : Event
---@overload fun(...) : TrafficArea
local TrafficArea, super = Class(Event)

-- This is a sneaky little modified hideparty event (well its basically all a hideparty event but there are also callbacks)

function TrafficArea:init(data)
    super.init(self, data)

    self.alphas         = {}
    self.target_alpha   = 0

    self.properties     = data.properties
end

function TrafficArea:onEnter(chara)
    if chara.is_player then
        local id = self:getUniqueID().."_alpha"
        for _,follower in ipairs(Game.world.followers) do
            if Kristal.callEvent("onEnterTraffic", self, follower) then
                goto continue
            end
            self.alphas[follower] = follower.sprite.alpha
            local mask = follower:addFX(AlphaFX(1), id)
            self.world.timer:tween(10/30, mask, {alpha = self.target_alpha})
            ::continue::
        end
    end
end

function TrafficArea:onExit(chara)
    if chara.is_player then
        local id = self:getUniqueID().."_alpha"
        for follower,alpha in pairs(self.alphas) do
            local mask = follower:getFX(id)
            if mask then
                self.world.timer:tween(10/30, mask, {alpha = alpha}, "linear", function()
                    follower:removeFX(mask)
                end)
            end
        end
        self.alphas = {}

        for _, follower in ipairs(Game.world.followers) do
            Kristal.callEvent("onExitTraffic", self, follower)
        end
    end
end

return TrafficArea