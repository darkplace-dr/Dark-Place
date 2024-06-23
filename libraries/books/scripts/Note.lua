---@class Note : Object
---@overload fun(...) : Note
local Note = Class()

function Note:init()

    self.id     = "testnote"
    self.title  = "TestNote"
    self.author = "undertaled"

    self.show_details = true -- Show the title and author of the book or note in the first page.
    
    self.content = [[]]
end

function Note:getText()
    return self.content
end

return Note