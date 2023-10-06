local xpwindow, super = Class(Object, "XPWindow")

function xpwindow:init(x, y, width, height, message, properties)
    super.init(self)
    properties = properties or {}

    -- buttons is a table of tables
    -- button 1 -> (label, callback), button 2...

    self.title = properties["title"]
    self.buttons = properties["buttons"]
    self.icon = properties["icon"]
end

return xpwindow