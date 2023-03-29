local Ach, super = Class(Achievement)

function Ach:init()
    super:init(self)
    
    self.name = "Doobie" -- Display name

    self.iconanimated = false -- If icons should be animated, if true then the input for both icons should be a table of paths
    self.icon = "achievements/doobie" -- Normal icon
    self.desc = "Encounter Doobie Ralsei." -- Description
    self.hint = "Encounter a fluffy friend." -- If info hidden is true then this will show up in place of description, used for hints
    self.hidden = true -- Doesn't show up in the menu if not collected
    self.rarity = "Common" -- An indicator on how difficult this achievement is. "Common", "Uncommon", "Rare", "Epic" "Legendary", "Unique", "Impossible"
    self.completion = false -- Shows a percent indicator if true, shows x/int if an integer, nothing if false.
    self.index = 1 -- Order in which the achievements will show up on the menu.
end

return Ach