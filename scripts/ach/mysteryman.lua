local Ach, super = Class(Achievement)

function Ach:init()
    super.init(self)
    
    self.name = "SHUT UP LOSER" -- Display name

    self.icon = "achievements/mysteryman" -- Normal icon
    self.desc = "Found room 269 in the Dev Hotel." -- Description
    self.hint = "Find one of many rooms between." -- If info hidden is true then this will show up in place of description, used for hints
    self.hidden = true -- Doesn't show up in the menu if not collected
    self.rarity = "Rare" -- An indicator on how difficult this achievement is. "Common", "Uncommon", "Rare", "Epic" "Legendary", "Unique", "Impossible"
    self.completion = false -- Shows a percent indicator if true, shows x/int if an integer, nothing if false.
end

return Ach