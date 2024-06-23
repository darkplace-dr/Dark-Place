local Readable, super = Class(Event)

function Readable:init(data)
    super.init(self, data.x, data.y, data.width, data.height)

    data.properties = data.properties or {}
    
    self.book = data.properties["book"] or nil
    self.note = data.properties["note"] or nil
    self.optionsBook = {
        Text    = data.properties["text"] or "* (It's a book.)[wait:10]\n* (Would you like to look inside?)",
        Option1 = data.properties["confirm"] or "Yes",
        Option2 = data.properties["cancel"] or "No"
    }
    self.optionsNote = {
        Text    = data.properties["text"] or "* (It's a note.)[wait:10]\n* (Would you like to read it?)",
        Option1 = data.properties["confirm"] or "Yes",
        Option2 = data.properties["cancel"] or "No"
    }

    self.cutscene = data.properties["cutscene"] or nil
	
    self.solid = data.properties["solid"] or false
end

function Readable:onInteract(chara, dir)
    if self.book and self.note then print("Readable objects only support one type of readable. Books take priority.") end
    Game.world:startCutscene("#book_cutscenes", self.cutscene or "_main", self)
    return true
end

return Readable