local Ach, super = Class(Achievement)

function Ach:init()
    super.init(self)

    self.name = "Unhinged Rant" -- Display name

    self.icon = "achievements/airant" -- Normal icon
    self.desc = "Read the whole rant of an AI becoming\nself-aware about her body odor." -- Description
    self.hint = "AI can do wonders and sometimes becomes\nself-aware. But uh..." -- If info hidden is true then this will show up in place of description, used for hints
    self.hidden = true -- Doesn't show up in the menu if not collected
    self.rarity = "Uncommon" -- An indicator on how difficult this achievement is. "Common", "Uncommon", "Rare", "Epic" "Legendary", "Unique", "Impossible"
    self.completion = false -- Shows a percent indicator if true, shows x/int if an integer, nothing if false.
end

return Ach