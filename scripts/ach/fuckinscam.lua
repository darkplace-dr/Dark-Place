local Ach, super = Class(Achievement)

function Ach:init()
    super.init(self)
    
    self.name = "High Quality Scam" -- Display name

    self.icon = "achievements/fuckinscam" -- Normal icon
    self.desc = "Lose at least 300 D$ in Scam-Rated\nsubscriptions." -- Description
    self.hint = "Imagine having a friend that would buy a\nscam again and again." -- If info hidden is true then this will show up in place of description, used for hints
    self.hidden = true -- Doesn't show up in the menu if not collected
    self.rarity = "Uncommon" -- An indicator on how difficult this achievement is. "Common", "Uncommon", "Rare", "Epic" "Legendary", "Unique", "Impossible"
    self.completion = false -- Shows a percent indicator if true, shows x/int if an integer, nothing if false.
end

return Ach