local map, super = Class(Map)

function map:init(world,data)
    super.init(self,world,data)
    self.menu = FileSelectMenu()
    self.menustyle = Kristal.callEvent("afmGetStyle") or Kristal.getLibConfig("afilemenu", "style")
    self.music = Kristal.callEvent("afmGetMusic", self.menustyle)
    or Kristal.getLibConfig("afilemenu", "music")
    or ({
        normal = "mod_menu",
        greatdoor = "menu",
        DEVICE = "AUDIO_DRONE"
    })[self.menustyle]
end

function map:onEnter()
    self.world:openMenu(self.menu)
    if FileSelectBackground then
        local bg = self.world:spawnObject(FileSelectBackground(self.menu), WORLD_LAYERS["below_ui"])
        Kristal.callEvent("afmSpawnBackground", self.menustyle, bg)
    end
end

return map
