local actor, super = Class("susie", true)

function actor:init()
    super.init(self)

    self.taunt_sprites = {"pose", "away_hand", "turn_around", "angry_down", "diagonal_kick_left_5", "shock_right"}
end

return actor