local room, super = Class(Map)

function room:onEnter()
    super:onEnter(self)
    --Game.world:spawnObject(VaporBG(0, 0), "objects_bg")

    if Game.world:getCharacter("susie") then
        Game.world:getCharacter("susie").visible = false
    end

    if Game.world:getCharacter("kris") then
        Game.world:getCharacter("kris").visible = false
    end

    if Game.world:getCharacter("ralsei") then
        Game.world:getCharacter("ralsei").visible = false
    end


    --local parallax = Sprite("worldbg/pizzatower/parallax", 0, 105)
    local parallax = Sprite("worldbg/pizzatower/parallax", 0, 0)
    parallax:setScale(1)
    parallax:setLayer(Game.world:parseLayer("objects2"))
    parallax.wrap_texture_x = true
    parallax.parallax_x = 1
    parallax.parallax_y = 1
    Game.world:addChild(parallax)
end

return room
