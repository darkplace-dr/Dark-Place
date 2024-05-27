local Poseur, super = Class(Recruit)

function Poseur:init()
    super.init(self)
    
    -- Display Name
    self.name = "Poseur"
    
    -- How many times an enemy needs to be spared to be recruited.
    self.recruit_amount = 1
    
    -- Selection Display
    self.description = "A virus with a slightly\ncriminal streak... and a heart\nof gold."
    self.chapter = 2
    self.level = 7
    self.attack = 4
    self.defense = 1
    self.element = "VIRUS"
    self.like = "Posing"
    self.dislike = "Staying Still"
    
    -- Controls the type of the box gradient
    -- Available options: dark, bright
    self.box_gradient_type = "bright"
    
    -- Dyes the box gradient
    self.box_gradient_color = {1,1,1,1}
    
    -- Sets the animated sprite in the box
    -- Syntax: Sprite/Animation path, offset_x, offset_y
    self.box_sprite = {"battle/enemies/poseur/idle", 0, 18}
    
    -- Recruit Status (saved to the save file)
    -- Number: Recruit Progress
    -- Boolean: True = Recruited | False = Lost Forever
    self.recruited = 0
end

return Poseur