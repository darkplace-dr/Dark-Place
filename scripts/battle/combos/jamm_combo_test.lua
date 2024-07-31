local test, super = Class(Combo, "jamm_combo_test")

function test:init()
    -- Display name
    self.name = "JammCbTest"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = ""
    -- Menu description
    self.description = "Jamm's combo test lol"

    -- TP cost
    self.cost = 16
    -- Whether the combo can be used
    self.usable = true

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"

    -- Tags that apply to this combo
    self.tags = {}

    -- Other party members that are required to be in the party.
    self.party = {"jamm", "mario"}
end

function test:doCutscene(cutscene)
	cutscene:text("* test")
end

return test