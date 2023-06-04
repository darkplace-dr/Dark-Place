local Ach, super = Class(Achievement)

function Ach:init()
    super.init(self)
    
    self.name = "Neuron Activation" -- Display name

    self.icon = "achievements/takodownbad" -- Normal icon
    self.desc = "\"I guess these artists... really\ngot your back...\"" -- Description
    self.hint = "They're innocent-looking, but if\nyou look past that..." -- If info hidden is true then this will show up in place of description, used for hints
    self.hidden = true -- Doesn't show up in the menu if not collected
    self.rarity = "Common" -- An indicator on how difficult this achievement is. "Common", "Uncommon", "Rare", "Epic" "Legendary", "Unique", "Impossible"
    self.completion = false -- Shows a percent indicator if true, shows x/int if an integer, nothing if false.
end

return Ach