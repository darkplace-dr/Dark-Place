ReadableBook = libRequire("books", "scripts/Book")
ReadableNote = libRequire("books", "scripts/Note")

booksLib = {}
local lib = booksLib

function lib:unload()
    Book = nil
end

function lib:save(data)
    data.books = {}
    data.books["bookprogress"] = booksLib.bookprogress
end

function lib:load(data, new_file)
    if new_file then
        lib.bookprogress = {}
    else
        data.books = data.books or {}
        lib.bookprogress = data.books["bookprogress"] or {}
    end
end

function lib:preInit()
    self.books = {}
    self.notes = {}

    for _,path,v in Registry.iterScripts("books") do
        assert(v ~= nil, '"books/'..path..'.lua" does not return value')
        v.id = v.id or path
        self.books[v.id] = v
    end

    for _,path,v in Registry.iterScripts("notes") do
        assert(v ~= nil, '"notes/'..path..'.lua" does not return value')
        v.id = v.id or path
        self.notes[v.id] = v
    end
end

function lib:loadHooks()
    Utils.hook(World, "createBookMenu", function(orig, self)
        
    end)
end

function lib:postInit()
    
end

function lib:registerBook(id, class)
    self.books[id] = class
end
function lib:getBook(id)
    return self.books[id]
end
function lib:createBook(id, ...)
    if self.books[id] then
        return self.books[id](...)
    else
        error("Attempt to create non existent book \"" .. tostring(id) .. "\"")
    end
end

function lib:registerNote(id, class)
    self.notes[id] = class
end
function lib:getNote(id)
    return self.notes[id]
end
function lib:createNote(id, ...)
    if self.notes[id] then
        return self.notes[id](...)
    else
        error("Attempt to create non existent note \"" .. tostring(id) .. "\"")
    end
end

return lib