local actor, super = Class(Actor, "vendy")

function actor:init()
    super.init(self)

    self.name = "Vendy"

    self.width = 136
    self.height = 107

    self.hitbox = nil

    self.color = {1, 0, 0}

    self.flip = nil

    self.path = "shopkeepers/vendy"
    self.default = "body"

    self.voice = nil
    self.portrait_path = nil
    self.portrait_offset = nil

    self.talk_sprites = {}

    self.animations = {
        ["face_angry"]   = {"face_angry", 0.8, true},
        ["face_base"]    = {"face_base", 0.8, true},
        ["face_boot_1"]  = {"face_boot_1", 0.8, true},
        ["face_boot_2"]  = {"face_boot_2", 0.8, true},
        ["face_boot_3"]  = {"face_boot_3", 0.8, true},
        ["face_happy"]   = {"face_happy", 0.8, true},
        ["face_smug"]    = {"face_smug", 0.8, true},
        ["face_sweaty"]  = {"face_sweaty", 0.8, true},
        ["face_uhh"]     = {"face_uhh", 0.8, true},
    }

    self.offsets = {
        ["body"]        = {0, 0},
        ["face_angry"]  = {0, 0},
        ["face_base"]   = {0, 0},
        ["face_boot_1"] = {0, 0},
        ["face_boot_2"] = {0, 0},
        ["face_boot_3"] = {0, 0},
        ["face_happy"]  = {0, 0},
        ["face_smug"]   = {0, 0},
        ["face_sweaty"] = {0, 0},
        ["face_uhh"]    = {0, 0},
    }
end

return actor
