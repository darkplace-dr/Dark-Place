local Ach, super = Class(Achievement)

function Ach:init()
    super.init(self)
    
    self.name = "The Original?" -- Display name

    self.icon = "achievements/starwalker" -- Normal icon
    self.desc = "Talk to the (former)\noriginal      Starwalker." -- Description
    self.hint = "This achievement was pissing me off..." -- If info hidden is true then this will show up in place of description, used for hints
    self.hidden = true -- Doesn't show up in the menu if not collected
    self.rarity = "Common" -- An indicator on how difficult this achievement is. "Common", "Uncommon", "Rare", "Epic" "Legendary", "Unique", "Impossible"
    self.completion = false -- Shows a percent indicator if true, shows x/int if an integer, nothing if false.
end

return Ach