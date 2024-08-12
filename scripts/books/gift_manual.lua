local book, super = Class(ReadableBook)

function book:init()
    super:init(self)

    self.id     = "gift_manual"
    self.title  = "Gift Manual"
    self.author = "Santa Claus"
    self.volume = 1

    self.show_details = false -- Show the title and author of the book or note in the first page.
    
    self.pages = {
        [1] = [[
					   [s:3][b]Gift Manual
				  [s:3][b]By Santa Claus
				  
		The North Pole's guide on making and wrapping toys to give lightner children worldwide an amazing Christmas and Happy Ho-Ho-Holidays!
		]],
		[2] = [[
                        [s:3][b]Contents

    3. Materials
    4. Molding
    5. Wrapping
    6. Shipping
    7. Coal]],
        [3] = [[
					   [s:3][b]Materials
		]],
        [4] = [[
                       [s:3][b]Molding
		]],
        [5] = [[
                       [s:3][b]Wrapping
		]],
        [6] = [[
                       [s:3][b]Shipping
        ]],
        [7] = [[
                      [image:ui/event_inv/coal,0,0] [s:3][b]Coal [image:ui/event_inv/coal,0,0]
        ]],
    }
    --Game.world:openMenu(bookMenu(booksLib:createBook("gift_manual"))) to open book
end

return book