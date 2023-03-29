local DogCheck, super = Class(Object)

function DogCheck:init()
    super:init(self)
	
    self.parallax_x = 0
    self.parallax_y = 0
	
	self.variant = math.random(0, 2)
	self.sleep_music = math.random(0, 1)
	
	local dark = Rectangle(0, 0, 640, 480)
	dark.color = {0, 0, 0}
	dark.layer = 800
    Game.world:addChild(dark)
	
    if self.variant == 0 then
        local dog = Sprite("objects/dogcheck/dog_dance", 320, 240)
        dog:setScale(6)
        dog:setOrigin(0.5, 0.5)
        dog:play(0.2, true)
        dog.layer = 1000
        Game.world.music:play("dance_of_dog")
        Game.world:addChild(dog)
    elseif self.variant == 1 then
        local dog = Sprite("misc/dog_sleep", 320, 240)
        dog:setScale(6)
        dog:setOrigin(0.5, 0.5)
        dog:play(0.8, true)
        dog.layer = 1000
        if self.sleep_music == 0 then
            Game.world.music:play("deltarune/dogcheck")
        elseif self.sleep_music == 1 then
            Game.world.music:play("results")
        elseif self.sleep_music == 1 then
            Game.world.music:play("sigh_of_dog")
        end
        Game.world:addChild(dog)
    elseif self.variant == 2 then
        local dog = Sprite("objects/dogcheck/dog_maracas", 340, 220)
        dog:setOrigin(0.5, 0.5)
        dog:setScale(6)
        dog:play(0.1, true)
        dog.layer = 1000
        Game.world.music:play("baci_perugina2")
        Game.world:addChild(dog)
    end
end

return DogCheck