local Ach, super = Class(Achievement)

function Ach:init()
    super.init(self)

    self.name = "A Price to Pay" -- Display name

    self.icon = "achievements/gods" -- Normal icon
    self.desc = "Anger the Gods." -- Description
    self.hint = "Anger the Gods." -- If info hidden is true then this will show up in place of description, used for hints
    self.hidden = true -- Doesn't show up in the menu if not collected
    self.rarity = "Unique" -- An indicator on how difficult this achievement is. "Common", "Uncommon", "Rare", "Epic" "Legendary", "Unique", "Impossible"
    self.completion = false -- Shows a percent indicator if true, shows x/int if an integer, nothing if false.
end

return Ach