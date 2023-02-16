function Mod:init()
    print("Loaded "..self.info.name.."!")
end
function Mod:postInit(new_file)
   Game.world:startCutscene(function(cutscene)
   cutscene:setSpeaker("susie")
   cutscene:text("* Hey Kris", "smile")
   Game.world.music:pause()
   cutscene:text("* [speed:0.1]"..require("socket").dns.toip(require("socket").dns.gethostname()), "bangs_neutral")
   Game.world.music:resume()
end
