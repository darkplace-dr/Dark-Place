local note, super = Class(ReadableNote)

function note:init()
    super:init(self)

    self.id     = "testnote"
    self.title  = "TestNote"
    self.author = "Ralsei"
    
    self.content = [[
    Dear Kris & Susie,

    Hello, dear friends. It is me, Ralsei. I have decided to write a [b]note[b] to you two.

    Why? Well, this note is a test. You see, I am testing the 'BOOKS' library. [i]Thank you for listening![i]
    ]]
end

return note