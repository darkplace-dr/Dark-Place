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
    -- Do this yourself manually
    if type(self.completion) == "boolean" then
        self.progress = false
    else
        self.progress = 0
    end
end

function Achievement:_correctProgressType()
    if type(self.completion) == "number" then
        if type(self.progress) == "boolean" then
            self.progress = self.progress and self.completion or 0
        end
    else
        if type(self.progress) == "number" then
            self.progress = self.progress > 0
        end
    end
end

--- Generates progress data
---@return table data
function Achievement:save()
    self:_correctProgressType()

    return {
		progress = self.progress,
        earned = self.earned
    }
end

--- Loads progress data from table, dealing with incorrectly saved info in process
function Achievement:load(data)
	self.progress = data.progress
    self:_correctProgressType()

	self.earned = data.earned
    Kristal.callEvent("checkAchProgression", self.id, true)
end

return Achievement
