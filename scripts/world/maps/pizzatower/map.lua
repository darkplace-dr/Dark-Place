local room, super = Class(Map)

function room:onEnter()
    super:onEnter(self)

    if Game.world:getCharacter("susie") then
        Game.world:getCharacter("susie").visible = false
    end

    if Game.world:getCharacter("kris") then
        Game.world:getCharacter("kris").visible = false
    end

    if Game.world:getCharacter("ralsei") then
        Game.world:getCharacter("ralsei").visible = false
    end

    --local parallax = Sprite("world/maps/pizzatower/parallax", 0, 105)
    local parallax = Sprite("world/maps/pizzatower/parallax", 0, 0)
    parallax:setScale(1)
    parallax.wrap_texture_x = true
    parallax.parallax_x = 1
    parallax.parallax_y = 1
    Game.world:spawnObject(parallax, "objects2")
end

return room
