local Ach, super = Class(Achievement)

function Ach:init()
    super.init(self)
    
    self.name = "Dummy Puncher" -- Display name

    self.icon = "achievements/dummy" -- Normal icon
    self.desc = "You have punched the dummy." -- Description
    self.hint = nil -- If info hidden is true then this will show up in place of description, used for hints
    self.hidden = false -- Doesn't show up in the menu if not collected
    self.rarity = "Common" -- An indicator on how difficult this achievement is. "Common", "Uncommon", "Rare", "Epic" "Legendary", "Unique", "Impossible"
    self.completion = false -- Shows a percent indicator if true, shows x/int if an integer, nothing if false.
end

return Ach