---@class DarkMenuPartySelect
local DarkMenuPartySelect, super = Class(DarkMenuPartySelect)

function DarkMenuPartySelect:draw()
    for i,party in ipairs(Game.party) do
        if self.selected_party ~= i then
            love.graphics.setColor(1, 1, 1, 0.4)
        else
            love.graphics.setColor(1, 1, 1, 1)
        end
        local ox, oy = party:getMenuIconOffset()
        local im = Assets.getTexture(party:getMenuIcon())
        -- TODO: If we could get a reliable timer we could just do this
        -- in YOU:getMenuIcon instead
        if party.id == "YOU" then
            local head_frames = Assets.getFrames("party/you/head")
            im = head_frames[(math.floor(self.heart_siner/20)-1)%#head_frames+1]
        elseif party.id == "robo_susie" then
            local head_frames = Assets.getFrames("party/robo_susie/head")
            im = head_frames[(math.floor(self.heart_siner/20)-1)%#head_frames+1]
        elseif party.id == "noyno" then
            local head_frames = Assets.getFrames("party/noyno/head")
            im = head_frames[(math.floor(self.heart_siner/20)-1)%#head_frames+1]
        end
        Draw.draw(im, (i-1)*50 + (ox*2), oy*2, 0, 2, 2)
    end
    if self.focused then
        local frames = Assets.getFrames("player/heart_harrows")
        love.graphics.setColor(Game:getSoulColor())
        Draw.draw(frames[(math.floor(self.heart_siner/20)-1)%#frames+1], (self.selected_party-1)*50 + 10, -18)
    end
    super.super.draw(self)
end

return DarkMenuPartySelect