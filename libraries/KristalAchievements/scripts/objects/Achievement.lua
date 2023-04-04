local Achievement, super = Class(Object)

function Achievement:init()
    super:init(self)

    self.name = "example" -- Display name

    self.icon = "path" -- Normal icon
    self.menuicon = nil -- Optional, icon used for the acheivements menu
    self.desc = "description" -- Description
    self.menudesc = nil -- Optional, description for the achievements menu
    self.hint = "hint" -- If info hidden is true then this will show up in place of description, used for hints
    self.hidden = true -- Doesn't show up in the menu if not collected
    self.rarity = "Common" -- An indicator on how difficult this achievement is. "Common", "Uncommon", "Rare", "Epic" "Legendary", "Unique", "Impossible"
    self.completion = false -- Shows a percent indicator if true, shows x/int if an integer, nothing if false.
    self.index = 1 -- Order in which the achievements will show up on the menu.
    self.earned = false
    if self.completion == false then
        self.progress = false
    else
        self.progress = 0
    end
end

function Achievement:save()
    local data = {
		progress = self.progress
    }
    return data
end

function Achievement:load(data)
	self.progress = data.progress
    Kristal.callEvent("checkAchProgression", self, true)
end

return Achievement
