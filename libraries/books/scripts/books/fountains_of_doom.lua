local book, super = Class(ReadableBook)

function book:init()
    super:init(self)

    self.id     = "fountains_of_doom"
    self.title  = "Deltarune: Fountains of Doom"
    self.author = "undertaled"
    self.volume = 1

    self.show_details = false -- Show the title and author of the book or note in the first page.
    
    self.pages = {
        [1] = [[
[image:bookslib/books/fountains_of_doom/cover,0,216]
]],
        [2] = [[
                       [s:3][b]Chapter 1:
                  [s:3]The Roaring
                    
	[s:1]“S[b][s:2]O THIS IS THE FINAL[s] Dark Fountain. Sealing this fountain will be the last thing we do in this great journey.”
    Standing at the edge of a cliff were three beings whose power exceeded what could be called ‘possible.’ A human built off a certain person’s determination, a monster of strong will, and—
    “Let’s go, Kris, Susie.”
    A Prince of Darkness, who was determined to bring light to this world once and for all.
        ]],
        [3] = [[
    “this book is         [b][color:red]Pissing[color:reset][b] me off. I am the    [b][color:red]Original Starwalker[color:reset][b].”
    Oh
    He’s also here
    “Hohoho, merry christmas!”
    …wait, why is he here again?

    “I am the evil knight, And I will kill you, the Lancer Fan Club,” said the Knight, who suddenly spawned.
    Ralsei smoked a fat blunt, before yelling— “Oh FUCK kris, run!”
    
    but it was too late. the knigh kiled chris. they dieded.
    [b]End[b]
]],
    }
end

return book