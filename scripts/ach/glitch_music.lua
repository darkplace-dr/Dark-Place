local Ach, super = Class(Achievement)

function Ach:init()
    super.init(self)

    self.name = "The Song Of My People" -- Display name

    self.icon = "achievements/glitch_music" -- Normal icon
    self.desc = "Destroy a map by having too many items\non you." -- Description
    self.hint = "When you have too many items, a part of a\nmap may start to break..." -- If info hidden is true then this will show up in place of description, used for hints
    self.hidden = true -- Doesn't show up in the menu if not collected
    self.rarity = "Epic" -- An indicator on how difficult this achievement is. "Common", "Uncommon", "Rare", "Epic" "Legendary", "Unique", "Impossible"
    self.completion = false -- Shows a percent indicator if true, shows x/int if an integer, nothing if false.
end

return Ach