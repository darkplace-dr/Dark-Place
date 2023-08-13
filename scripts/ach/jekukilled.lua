local Ach, super = Class(Achievement)

function Ach:init()
    super.init(self)

    self.name = "Mess with the OP" -- Display name

    self.icon = "achievements/jekukilled" -- Normal icon
    self.desc = "Too OP, please nerf!!" -- Description
    self.hint = "Get killed where it shouldn't be possible." -- If info hidden is true then this will show up in place of description, used for hints
    self.hidden = true -- Doesn't show up in the menu if not collected
    self.rarity = "Uncommon" -- An indicator on how difficult this achievement is. "Common", "Uncommon", "Rare", "Epic" "Legendary", "Unique", "Impossible"
    self.completion = false -- Shows a percent indicator if true, shows x/int if an integer, nothing if false.
end

return Ach