local Ach, super = Class(Achievement)

function Ach:init()
    super.init(self)
    
    self.name = "Deathmaster28" -- Display name

    self.icon = "achievements/explosion" -- Normal icon
    self.desc = "Game over. Score: -10" -- Description
    self.hint = "\"Get Fucked\" (metaphorically) 10 times." -- If info hidden is true then this will show up in place of description, used for hints
    self.hidden = true -- Doesn't show up in the menu if not collected
    self.rarity = "Rare" -- An indicator on how difficult this achievement is. "Common", "Uncommon", "Rare", "Epic" "Legendary", "Unique", "Impossible"
    self.completion = 10 -- Shows a percent indicator if true, shows x/int if an integer, nothing if false.
    self.progress = 0
end

return Ach