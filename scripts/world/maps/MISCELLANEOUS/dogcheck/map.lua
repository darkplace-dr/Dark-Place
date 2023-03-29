local room, super = Class(Map)

function room:load()
  super:load(self)

  Game.world:startCutscene(function(cutscene)

    
    
    Kristal.hideBorder(0)
    --local dog = Sprite("misc/dogcheck/dogcheck", SCREEN_WIDTH/2, SCREEN_HEIGHT/2, 10, 10)
    local dog = Sprite("misc/dogcheck/dogcheck")
    dog.x = 150
    dog.y = 70
    dog:setScale(2)
    dog:play(0.1, true)
    --dog:setOrigin(0.5, 0.5)
    dog.layer = 500
    dog.parallax_x = 0
    dog.parallax_y = 0
    Game.world:addChild(dog)

    cutscene:pause()


  end)

end

return room
