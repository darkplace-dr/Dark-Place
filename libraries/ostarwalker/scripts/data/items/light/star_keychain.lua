local item, super = Class(Item, "light/star_keychain")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Star Keychain"

    -- Item type (item, key, weapon, armor)
    self.type = "key"
    -- Whether this item is for the light world
    self.light = true

    -- Light world check text
    self.check = "A small keychain with a star attached\nto it."

    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
end

function item:onWorldUse()
    Game.world:showText({
        "* You put the star on your\nphone's keychain.",
        "* ...[wait:5] Doesn't feel right.[wait:5] You\ntake it back off."
})
    return false
end

function item:onToss()
    Game.world:showText({
        "* (You didn't quite understand\nwhy...)",
        "* (But, the thought of discarding\nit felt very wrong.)",
    })
    return false
end

return item