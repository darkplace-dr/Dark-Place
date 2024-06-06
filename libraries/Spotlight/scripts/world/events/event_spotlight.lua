local SpotlightEvent, super = Class(Event, "spotlight")

--comma-seperated-list to array of valid lua variable names
local function praseLuaNames(csv)
    if(csv) then
        local t = {}
        for v in string.gmatch(csv, "%a[%w_]+") do 
            table.insert(t, v)
        end
        return t
    end
    return nil
end

function SpotlightEvent:init(data)
    super.init(self, data)
    local spotlight_data = {
        width = data.properties.width or self.width, --beam width at bottom
        
        beam_height = data.properties.beam_height or self.height, --height of beam,
        source_x = data.properties.source_x and (data.properties.source_x), --top of beam x, 
        source_y = data.properties.source_y  and (data.properties.source_y), --top of beam y, 
        lock_source = data.properties.lock_source, --keep source position on move

        offset_x = data.properties.offset_x, --x offset of entire spotlight
        offset_y = data.properties.offset_y, --y "

        top_color = data.properties.top_color and Utils.parseColorProperty(data.properties.top_color), --color of top of beam
        bottom_color = data.properties.bottom_color and Utils.parseColorProperty(data.properties.bottom_color), --color of bottom of beam
        base_color = data.properties.base_color and Utils.parseColorProperty(data.properties.base_color), --color of circular base

        shader = data.properties.shader, --custom shader code to apply to beam
        shader_fields = praseLuaNames(data.properties.shader_fields) --values of self[<field>] that are passed into shader
    }
    self.spotlight = Spotlight(self.x + self.width/2, self.y + self.height,spotlight_data)
    self.spotlight:setLayer(0.4)
    Game.world:addChild(self.spotlight)
end

return SpotlightEvent