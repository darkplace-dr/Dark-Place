local Ach, super = Class(Achievement)

function Ach:init()
    super:init(self)
    
    self.name = "One With The Maus" -- Display name

    self.icon = "achievements/velvetsqueak" -- Normal icon
    self.desc = "Make Velvet squeak like a Maus." -- Description
    self.hint = "You might need to find a gray mouse.\nNot to be confused with Maus." -- If info hidden is true then this will show up in place of description, used for hints
    self.hidden = true -- Doesn't show up in the menu if not collected
    self.rarity = "Uncommon" -- An indicator on how difficult this achievement is. "Common", "Uncommon", "Rare", "Epic" "Legendary", "Unique", "Impossible"
    self.completion = false -- Shows a percent indicator if true, shows x/int if an integer, nothing if false.
end

return Ach