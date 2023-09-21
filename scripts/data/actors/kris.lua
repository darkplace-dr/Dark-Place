local actor, super = Class("kris", true)

function actor:init()
    super.init(self)

    local costume = Game:getFlag("kris_costume")
    if costume ~= nil then
        if costume == 0 or costume > 2 then
            self.path = "party/kris/dark"
        elseif costume == 1 then
            self.path = "party/kris/light"
        elseif costume == 2 then
            self.path = "party/kris/repainted"
        end
    else
        self.path = "party/kris/dark"
    end

    self.taunt_sprites = {"pose", "peace", "t_pose", "sit"}
end

return actor