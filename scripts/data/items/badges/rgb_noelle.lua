local badge, super = Class("badge", "rgb_noelle")

function badge:init()
    super.init(self)

    -- Display name
    self.name = "Snow Angel"

    self.type = "badge"

    -- Menu description
    self.description = "Makes Noelle stronger."

    -- The cost of putting it on
    self.badge_points = 3

    -- Default shop price (sell price is halved)
    self.price = 180
end

function badge:update(equipped)
    local noelle = Game:hasPartyMember("noelle") and (Game.battle and Game.battle:getPartyBattler("noelle") or Game.world:getCharacter("noelle"))
    if equipped then
        if noelle then
            if not noelle:getFX(OutlineFX) then
                noelle:addFX(OutlineFX())
            end
            noelle:getFX(OutlineFX):setColor(Utils.hslToRgb(Kristal.getTime() / 4 % 1, 1, 0.5))
        end
    else
        if noelle then
            if noelle:getFX(OutlineFX) then
                noelle:removeFX(OutlineFX)
            end
        end
    end
end

function badge:onBadgeEquipped()
    local noelle = Game:getPartyMember("noelle")
    noelle.stats.health = noelle.stats.health + 60
    noelle.stats.attack = noelle.stats.attack + 13
    noelle.stats.defense = noelle.stats.defense + 6
    noelle.stats.magic = noelle.stats.magic + 6
end

function badge:onBadgeRemoved()
    local noelle = Game:getPartyMember("noelle")
    noelle.stats.health = noelle.stats.health - 60
    noelle.stats.attack = noelle.stats.attack - 13
    noelle.stats.defense = noelle.stats.defense - 6
    noelle.stats.magic = noelle.stats.magic - 6
    if noelle.health > noelle.stats.health then
        noelle.health = noelle.stats.health
    end
end

return badge