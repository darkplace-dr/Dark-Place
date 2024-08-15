local MacroFroggitChest, super = Class(Event)

function MacroFroggitChest:init(data)
    super.init(self, data.center_x, data.center_y, data.width, data.height)

    self.solid = true
    self:setOrigin(0.5, 1)
    self:setSprite("world/maps/steamworks/objects/18_macro_froggit_chest")
end

function MacroFroggitChest:onInteract(chara, dir)
    Game.world:startCutscene(function(cutscene)
        if not Game:getFlag("ceroba_told_chest_story") then
            cutscene:text("* (An empty chest.)")
            if cutscene:getCharacter("ceroba") then
                cutscene:text("* Oh,[wait:5] an interesting story about this thing.", "neutral", "ceroba")
                cutscene:text("* When I was here for the first time,[wait:5] I was not alone.", "alt", "ceroba")
                cutscene:text("* I was with...[wait:5] A certain someone.", "closed_eyes", "ceroba")
                cutscene:text("* And so when we approached here,[wait:5] they just vanished.", "surprised", "ceroba")
                cutscene:text("* It's like I blinked and lost them...", "nervous", "ceroba")
                cutscene:text("* Anyways,[wait:5] in a couple of minutes they appeared back.", "closed_eyes", "ceroba")
                cutscene:text("* And not JUST them,[wait:5] that weird chest appeared here for some reason.", "surprised", "ceroba")
                cutscene:text("* They were laying on the ground,[wait:5] so I thought they fainted...", "closed_eyes", "ceroba")
                cutscene:text("* But strangely,[wait:5] they woke up almost immediately.", "alt", "ceroba")
                cutscene:text("* And then,[wait:5] when they opened that chest...", "closed_eyes", "ceroba")
                cutscene:text("* There was a Golden Bandana.", "alt", "ceroba")
                cutscene:text("* And so,[wait:5] they just wore it until the end.", "neutral", "ceroba")
                Game:setFlag("ceroba_told_chest_story", true)
            end
        else
            cutscene:text("* (It's full of epic emptiness.)")
        end
    end)
    return true
end

return MacroFroggitChest