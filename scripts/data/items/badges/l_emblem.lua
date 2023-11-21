local badge, super = Class("badge", "l_emblem")

function badge:init()
    super.init(self)

    -- Display name
    self.name = "L Emblem"

    self.type = "badge"

    -- Menu description
    self.description = "Changes your appearance."

    -- The cost of putting it on
    self.badge_points = 0

    -- Default shop price (sell price is halved)
    self.price = 180
end

function badge:update(equipped)
    if equipped and not Game.world.player.l_color then
        Game.world.player.l_color = ColorMaskFX({0,1,0}, 0.5)
		Game.world.player:addFX(Game.world.player.l_color, "l_emblem")
	end
	if equipped and Game.battle and #Game.battle.party > 0 and not Game.battle.party[1]:getFX("l_emblem") then
		Game.battle.party[1].l_color = ColorMaskFX({0,1,0}, 0.5)
		Game.battle.party[1]:addFX(Game.battle.party[1].l_color, "l_emblem")
	end
	if not equipped and Game.world.player.l_color then
        Game.world.player:removeFX("l_emblem")
		Game.world.player.l_color = nil
    end
end

return badge