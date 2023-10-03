local Ach, super = Class(Achievement)

function Ach:init()
    super.init(self)
    
    self.name = "Friend of Dog" -- Display name

    self.icon = "achievements/corgi" -- Normal icon
    self.desc = "Befriended the corgi!" -- Description
    self.hint = "Find a specific corgi!" -- If info hidden is true then this will show up in place of description, used for hints
    self.hidden = true -- Doesn't show up in the menu if not collected
    self.rarity = "Rare" -- An indicator on how difficult this achievement is. "Common", "Uncommon", "Rare", "Epic" "Legendary", "Unique", "Impossible"
    self.completion = false -- Shows a percent indicator if true, shows x/int if an integer, nothing if false.
end

return Ach