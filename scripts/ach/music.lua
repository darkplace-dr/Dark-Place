local ach, super = Class(Achievement)

function ach:init()
    super.init(self)

    self.name = "Musical Nightmare" -- Display name

    self.icon = "achievements/music" -- Normal icon
    self.desc = "Congratulations! You failed the quiz." -- Description
    self.hint = "Get a certain score on a quiz." -- If info hidden is true then this will show up in place of description, used for hints
    self.hidden = true -- Doesn't show up in the menu if not collected
    self.rarity = "Common" -- An indicator on how difficult this achievement is. "Common", "Uncommon", "Rare", "Epic" "Legendary", "Unique", "Impossible"
    self.completion = false -- Shows a percent indicator (progress/completion) if a number, nothing if false.
end

return ach