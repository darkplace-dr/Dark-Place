local Ach, super = Class(Achievement)

function Ach:init()
    super.init(self)
    
    self.name = "Dirty Hacker" -- Display name

    self.icon = "achievements/dirtyhacker" -- Normal icon
    self.desc = "A permanent stain on your reputation.\nCause a scenario only possible with\nconsole commands." -- Description
    self.hint = "You shouldn't have this achievement" -- If info hidden is true then this will show up in place of description, used for hints
    self.hidden = true -- Doesn't show up in the menu if not collected
    self.rarity = "Impossible" -- An indicator on how difficult this achievement is. "Common", "Uncommon", "Rare", "Epic" "Legendary", "Unique", "Impossible"
    self.completion = false -- Shows a percent indicator if true, shows x/int if an integer, nothing if false.
end

return Ach