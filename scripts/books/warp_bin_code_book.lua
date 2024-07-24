local book, super = Class(ReadableBook)

function book:init()
    super:init(self)

    self.id     = "warp_bin_code_book"
    self.title  = "CODE BOOK"
    self.author = Game.save_name --Haha, it is I, the PLAYER
    self.volume = 1

    self.show_details = false -- Show the title and author of the book or note in the first page.
    
    self.pages = {
        [1] = [[
                        [s:3][b]00000000

    [color:blue]DEVDINER[color:white]
    [color:black]WIFIDOWN[color:white]
    [color:#5fcde4]GARRYMOD[color:white]
    [color:blue]DARKCADE[color:white]
    [color:ff7800]WILDEAST[color:white]
      [color:red]SLIDER[color:white] ]],
        [2] = [[
              [image:world/npcs/spam_mosquito/idle,0,0] [s:3][b][color:yellow]SPAM[color:pink]ROOM[color:reset] [image:world/npcs/spam_mosquito/idle,0,0]

    (Go to the code 
    "[color:yellow]SPAM[color:pink]ROOM[color:reset]"! [image:world/npcs/cardspam/laugh,0,0]
    It's where all the
    [BIG SHOT]s [image:world/npcs/beta_spamton,0,0]
    are!)
         [image:world/npcs/cungaderospamton/laugh,0,0]


         [image:world/npcs/alternatespam,0,0]    [image:world/npcs/marispam/idle,0,0]    [image:world/npcs/spamongus/idle,0,0]    [image:world/npcs/spamgolor/glitch,0,0]    [image:world/npcs/muppet_kris/idle,0,0]
         
         

                                                       [image:world/npcs/soapton,0,0]
        ]],
        [3] = [[
                       [s:3][b][color:red]DESSHERE[color:reset]

    (yo whaddup. go to 
    "[color:red]DESSHERE[color:reset]".)
        ]],
        [4] = [[
                       [s:3][b][color:yellow]BOSSRUSH[color:reset]

    (Want to fight bosses you've 
    previously fought?

    Go to "[color:yellow]BOSSRUSH[color:reset]"!)
        ]],
        [5] = [[
    No more codes for now...
        ]],
    }
    --Game.world:openMenu(bookMenu(booksLib:createBook("warp_bin_code_book"))) to open book
end

return book