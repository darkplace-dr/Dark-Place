local test, super = Class(Combo, "jd_batter")

function test:init()
    -- Display name
    self.name = "JD Batter"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = "Launch\nJamm"
    -- Menu description
    self.description = "With her bat, Dess launches Jamm at an enemy. Jamm hits the enemy, dealing huge damage."

    -- TP cost
    self.cost = 32
    -- Whether the combo can be used
    self.usable = true

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"

    -- Tags that apply to this combo
    self.tags = {}

    -- Other party members that are required to be in the party.
    self.party = {"jamm", "dess"}
end

function test:doCutscene(cutscene, target)
	cutscene:text("* This move isn't complete yet.")
	Assets.playSound("damage")
	local dess_damage = ((Game:getPartyMember("dess"):getStat("attack") * 100) / 20) - (target.defense * 3)
	local jamm_damage = ((Game:getPartyMember("jamm"):getStat("attack") * 100) / 20) - (target.defense * 3)
	target:hurt(dess_damage + jamm_damage, nil, nil, {1, 1, 0, 1})
	cutscene:wait(1)
end

return test