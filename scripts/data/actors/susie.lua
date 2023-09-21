local actor, super = Class("susie", true)

function actor:init()
    super.init(self)

    local costume = Game:getFlag("susie_costume")
    if costume ~= nil then
        if costume == 0 or costume > 2 then
            self.path = "party/susie/dark"
        elseif costume == 1 then
            self.path = "party/susie/light"
        elseif costume == 2 then
            self.path = "party/susie/repainted"
        end
    else
        self.path = "party/susie/dark"
    end

    self.taunt_sprites = {"pose", "away_hand", "turn_around", "angry_down", "diagonal_kick_left_5", "shock_right"}


end

return actor