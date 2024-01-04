local Ach, super = Class(Achievement)

function Ach:init()
    super.init(self)
    
    self.name = "An Achievement" -- Display name

    self.icon = "achievements/achievement" -- Normal icon
    self.desc = "...yu're welcome 👍" -- Description
    self.hint = "THIS EXPERIMENT WAS VERY INTERESTING." -- If info hidden is true then this will show up in place of description, used for hints
    self.hidden = true -- Doesn't show up in the menu if not collected
    self.rarity = "Impossible" -- An indicator on how difficult this achievement is. "Common", "Uncommon", "Rare", "Epic" "Legendary", "Unique", "Impossible"
    self.completion = false -- Shows a percent indicator if true, shows x/int if an integer, nothing if false.
end

return Ach