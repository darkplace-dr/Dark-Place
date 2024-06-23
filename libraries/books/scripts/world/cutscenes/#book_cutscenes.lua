return {
    _main = function(cutscene, event)
        local book = event.book
        local note = event.note
        local optionsBook = event.optionsBook
        local optionsNote = event.optionsNote
        if book then cutscene:text(optionsBook.Text) elseif note then cutscene:text(optionsNote.Text) else cutscene:text("* what the fuck are you looking at , waltuh? there is nothing there, waltuh") end

        local choicer = nil
        if book then
            choicer = cutscene:choicer({optionsBook.Option1, optionsBook.Option2})
        elseif note then
            choicer = cutscene:choicer({optionsBook.Option1, optionsBook.Option2})
        end

        if choicer == 1 then
            cutscene:after(function()
                if book then
                    Game.world:openMenu(bookMenu(booksLib:createBook(book)))
                elseif note then
                    Game.world:openMenu(noteMenu(booksLib:createNote(note)))
                end
            end)
        end
    end,
}
