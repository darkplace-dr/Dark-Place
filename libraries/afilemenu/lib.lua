local lib = {}

function lib:getPaletteColor(key)
    local style = "normal"
    if Game.world and Game.world.map then
        style = Game.world.map.menustyle
    end
    local function bystyle(table)
        return table[style] or table.default
    end
    if key == "filemenu_deselected" then
        return bystyle{
            default = {0.6, 0.6, 0.7},
            DEVICE = {0, 0.5, 0},
            greatdoor = {.7, .6, .6},
        }
    elseif key == "filemenu_selected" then
        return bystyle {
            default = {1, 1, 1},
            DEVICE = {0,1,0}
        }
    elseif key == "filemenu_copy" then
        return bystyle {
            default = {1, 1, 0.4},
            DEVICE = {0.5,1,0.5}
        }
    elseif key == "filemenu_settings" then
        return bystyle {
            default = {1, 1, 1},
            DEVICE = {0.4,1.0,0.2}
        }
    end
    MUSIC_PITCHES.menu = 0.95
    MUSIC_PITCHES.mod_menu = 0.95
end

function lib:postInit()
    Game.world:loadMap("fileselect")
end

return lib
