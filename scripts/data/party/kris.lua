local character, super = Class("kris", true)

function character:init()
    super.init(self)

    self.has_spells = true

    self.has_xact = false

    self:addSpell("xslash")

    self.special_actors = { flipside = Registry.createActor("flipside/kris") }
end

function character:getActor(light)
    if Game.world and Game.world.map and is_in_flipside then
        local is_in_flipside, _ = Utils.startsWith(Game.world.map.id, "flipside/")
        if is_in_flipside then return self.special_actors.flipside end
    end

    return super.getActor(self, light)
end

return character