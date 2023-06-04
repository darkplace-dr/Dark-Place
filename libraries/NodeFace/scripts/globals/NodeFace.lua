---@param chara_lookup_table? table<string, Character> face:chara
---@return fun(self: DialogueText, face: string) nodeface
---@return { functions: table<string, fun(self: DialogueText, ...)> } preset_options
return function(chara_lookup_table)
    local current_face

    ---@param self DialogueText
    ---@param face string a face found under face/embedded
    ---@param x_off number
    local function createFace(self, face, x_off)
        x_off = x_off or 0

        current_face = face

        local chara = chara_lookup_table
            and chara_lookup_table[face]
            or (Game.world and Game.world:getCharacter(face) or nil)
        if chara then
            chara:setAnimation("talk")
        end

        local x, y = self.state.current_x + x_off, self.state.current_y + self:getFont():getHeight() / 2
        local sprite = Sprite("talk", x, y, nil, nil, "face/embedded/" .. face)
        sprite:setOrigin(0, 0.5)
        sprite.layer = self.layer + 1
        sprite:setAnimation(function(sprite_here, wait)
            while true do
                sprite_here:setFrame(sprite_here.frame == 1 and 2 or 1)

                if sprite_here.frame == 1 and not (current_face == face and sprite_here:isTyping()) then
                    if chara then
                        chara:setAnimation("idle")
                    end
                    break
                end
                wait(0.15)
            end
        end)
        self:addChild(sprite)
        table.insert(self.sprites, sprite)

        self.state.current_x = sprite.x + (sprite.width * sprite.scale_x) + self.state.spacing
    end

    ---@type { functions: table<string, fun(self: DialogueText, ...)> }
    local preset_options = {
        functions = {
            nodeface = createFace
        }
    }

    return createFace, preset_options
end