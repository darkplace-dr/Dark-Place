---@class Book : Object
---@overload fun(...) : Book
local Book = Class()

function Book:init()

    self.id     = "testbook"
    self.title  = "TestBook"
    self.author = "undertaled"
    self.volume = 1

    self.show_details = true -- Show the title and author of the book or note in the first page.
    
    self.pages = {
        [1] = [[gt]],
        [2] = [[gsdgs]]
    } 
end

function Book:getProgress()
    return booksLib.bookprogress[self.id] or 1
end

function Book:getPageText(page)
    return self.pages[page]
end

return Book