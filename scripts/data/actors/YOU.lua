local actor, super = Class("YOU", true)

function actor:init()
    super.init(self)

    self.taunt_sprites = {"disappointed", "fell", "shoutoutstosimpleflips", "date", "date_flowey_4", "riot"}
end

return actor