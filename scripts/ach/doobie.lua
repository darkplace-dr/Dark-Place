local ach, super = Class(Achievement)

function ach:init()
    super.init(self)

    self.name = "Doobie" -- Display name

    self.icon = "achievements/doobie" -- Normal icon
    self.desc = "Encounter Doobie Ralsei." -- Description
    self.hint = "Encounter a fluffy friend." -- If info hidden is true then this will show up in place of description, used for hints
    self.hidden = true -- Doesn't show up in the menu if not collected
    self.rarity = "Common" -- An indicator on how difficult this achievement is. "Common", "Uncommon", "Rare", "Epic" "Legendary", "Unique", "Impossible"
    self.completion = false -- Shows a percent indicator (progress/completion) if a number, nothing if false.
end

return ach