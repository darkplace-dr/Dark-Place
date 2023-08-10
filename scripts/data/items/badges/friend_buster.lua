local badge, super = Class("badge", "friend_buster")

function badge:init()
    super.init(self)

    -- Display name
    self.name = "Friend Buster"

    self.type = "badge"

    -- Menu description
    self.description = "Allow Susie to use Friend Buster,\na different form of Rude Buster."

    -- The cost of putting it on
    self.badge_points = 0

    -- Default shop price (sell price is halved)
    self.price = 180
end

function badge:update(equipped)
    if equipped and Game:hasPartyMember("susie") and not Game:getPartyMember("susie"):hasSpell("friend_buster") then
        Game:getPartyMember("susie"):addSpell("friend_buster")
    end
    if not equipped and Game:hasPartyMember("susie") and Game:getPartyMember("susie"):hasSpell("friend_buster") then
        Game:getPartyMember("susie"):removeSpell("friend_buster")
    end
end

return badge