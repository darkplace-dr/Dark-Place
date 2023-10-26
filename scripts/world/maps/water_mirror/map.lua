local room, super = Class(Map)

function room:onEnter()
    super.onEnter(self)

    --
    Game.world:startCutscene(function (cs)
        Game.world:loadMap("misc/dogcheck")
        cs:wait(1)
        if Game.dogcheck.variant ~= "banned" then
            local text = Text("No.", 0, SCREEN_HEIGHT/2 + 50, SCREEN_WIDTH, SCREEN_HEIGHT, 
            {
                align = "center",
                --font = "plain"
                --font_size = 16,
                style = "dark"
            })
            Game.world:spawnObject(text, "ui")
            cs:wait(5)
            local text2 = Text("Go away.", 0, SCREEN_HEIGHT/2 + 70, SCREEN_WIDTH, SCREEN_HEIGHT, 
            {
                align = "center",
                --font = "plain"
                --font_size = 16,
                style = "dark"
            })
            Game.world:spawnObject(text2, "ui")
        end
    end)
    --]]

    for i in ipairs(Game.party) do
        Game.party[i].actor.mirror_sprites = {
        ["walk/down"] = "walk_mirror/up",
        ["walk/up"] = "walk_mirror/down",
        ["walk/left"] = "walk_mirror/left",
        ["walk/right"] = "walk_mirror/right",
        }
    end
end

function room:onExit()
    super.onExit(self)

    for i in ipairs(Game.party) do
        Game.party[i].actor.mirror_sprites = {
        ["walk/down"] = "walk/up",
        ["walk/up"] = "walk/down",
        ["walk/left"] = "walk/left",
        ["walk/right"] = "walk/right",
        }
    end
end

return room