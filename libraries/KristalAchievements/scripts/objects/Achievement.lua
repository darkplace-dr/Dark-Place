local Achievement, super = Class(Object)

function Achievement:init()
    super.init(self)

    self.name = "example" -- Display name

    self.icon = "path" -- Normal icon
    self.menuicon = nil -- Optional, icon used for the acheivements menu
    self.desc = "description" -- Description
    self.menudesc = nil -- Optional, description for the achievements menu
    self.hint = nil -- If info hidden is true then this will show up in place of description, used for hints
    self.hidden = true -- Shows dimmed in the menu if not collected
    self.rarity = "Common" -- An indicator on how difficult this achievement is. "Common", "Uncommon", "Rare", "Epic" "Legendary", "Unique", "Impossible"
    self.completion = false -- Shows a percent indicator (progress/completion) if a number, nothing if false.
    self.index = math.huge -- Order in which the achievements will show up on the menu.
    self.earned = false
    self.progress = type(self.completion) ~= "number" and false or 0 -- Do this yourself manually
end

function Achievement:save()
    local data = {
		progress = self.progress,
        earned = self.earned
    }
    return data
end

function Achievement:load(data)
	self.progress = data.progress
    if type(self.completion) == "number" and type(self.progress) == "boolean" then
        self.progress = self.progress and self.completion or 0
    end
	self.earned = data.earned
    if not self.earned then
        -- Commenting out this line for now because this function is a bit broken
        --Kristal.callEvent("checkAchProgression", self.id, true)
    else
        self.progress = type(self.completion) == "number" and self.completion or true
    end
end

return Achievement
