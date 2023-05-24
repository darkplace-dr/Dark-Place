local item, super = Class(Item, "light/old_cartridge")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Old Cartridge"

    -- Item type (item, key, weapon, armor)
    self.type = "key"

    self.light = true

    -- Menu description
    self.check = "A game cartridge for an old console. The sticker was torn by time."
end

function item:onWorldUse()
    Game.world:showText("* You look at the cartridge in admiration.[wait:5]\nNothing happened.")
end

function item:convertToDark(inventory)
    return "sfb_key"
end

function item:onToss()
    Game.world:startCutscene(function(cutscene)
        cutscene:text("* Throwing it away doesn't feel right.")
        cutscene:text("* Do it anyway?")
        if cutscene:choicer({"Yes", "No"}) == 1 then
            Game.inventory:removeItem(self)
            cutscene:text("* You drop the cartridge and crush it with your foot.")
            cutscene:text("* It feels like you decieved someone...")
            Game.world.timer:everyInstant(1/20, function() Assets.playSound("voice/jeku") end, 20)
        else
            cutscene:text("* It feels right.")
        end
    end)
    return false
end

return item
