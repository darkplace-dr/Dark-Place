return {
    box_a = function(cutscene)
        Assets.stopAndPlaySound("dimbox")
        cutscene:wait(7/30)
        cutscene:after(function() Game.world:openMenu(LightStorageMenu("items", "box_a")) end)
    end,
    box_b = function(cutscene)
        Assets.stopAndPlaySound("dimbox")
        cutscene:wait(7/30)
        cutscene:after(function() Game.world:openMenu(LightStorageMenu("items", "box_b")) end)
    end
}