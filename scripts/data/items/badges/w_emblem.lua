local badge, super = Class("badge", "w_emblem")

function badge:init()
    super.init(self)

    -- Display name
    self.name = "W Emblem"

    self.type = "badge"

    -- Menu description
    self.description = "Changes your appearance."

    -- The cost of putting it on
    self.badge_points = 0

    -- Default shop price (sell price is halved)
    self.price = 180
end

function badge:update(equipped)
	if equipped and Game.battle and #Game.battle.party > 0 and not Game.battle.party[1].emblem then
		if BadgesLib:getBadgeEquipped("l_emblem") > 0 then
			Game.battle.party[1].emblem = ColorMaskFX({0.5,0,0.5}, 0.5)
			Game.battle.party[1]:addFX(Game.battle.party[1].emblem, "emblem")
		else
			Game.battle.party[1].emblem = ColorMaskFX({1,1,0}, 0.5)
			Game.battle.party[1]:addFX(Game.battle.party[1].emblem, "emblem")
		end
	end
end

function badge:onBadgeEquipped()
	if (BadgesLib:getBadgeEquipped("l_emblem") > 0) then
		Kristal.Console:log("L Emblem detected")
	end
    if Game.world.player.emblem then
		Game.world.player:removeFX("emblem")
		Game.world.player.emblem = ColorMaskFX({0.5,0,0.5}, 0.5)
		Game.world.player:addFX(Game.world.player.emblem, "emblem")
	else
        Game.world.player.emblem = ColorMaskFX({1,1,0}, 0.5)
		Game.world.player:addFX(Game.world.player.emblem, "emblem")
	end
end

function badge:onBadgeRemoved()
	Game.world.player:removeFX("emblem")
	if (BadgesLib:getBadgeEquipped("l_emblem") > 0) then
		Game.world.player.emblem = ColorMaskFX({0,1,0}, 0.5)
		Game.world.player:addFX(Game.world.player.emblem, "emblem")
	else
		Game.world.player.emblem = nil
	end
end

return badge