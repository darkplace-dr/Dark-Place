local Ach, super = Class(Achievement)

function Ach:init()
    super:init(self)
    
    self.name = "A Good Night's [[SHUTTING DOWN]]" -- Display name

    self.icon = "achievements/blankiequest" -- Normal icon
    self.desc = "Find Spamton's Blankie [TM]." -- Description
    self.hint = "It seems you can only do this at night..." -- If info hidden is true then this will show up in place of description, used for hints
    self.hidden = true -- Doesn't show up in the menu if not collected
    self.rarity = "Rare" -- An indicator on how difficult this achievement is. "Common", "Uncommon", "Rare", "Epic" "Legendary", "Unique", "Impossible"
    self.completion = false -- Shows a percent indicator if true, shows x/int if an integer, nothing if false.
end

return Ach