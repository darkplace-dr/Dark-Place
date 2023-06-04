---@param chara_lookup_table? table<string, Character> face:chara
---@return fun(self: DialogueText, face: string) nodeface
---@return { functions: table<string, fun(self: DialogueText, ...)> } preset_options
return function(chara_lookup_table)
    local current_face

    ---@param self DialogueText
    ---@param face string a face found under face/embedded
    local function createFace(self, face)
        current_face = face

        local chara = chara_lookup_table
            and chara_lookup_table[face]
            or (Game.world and Game.world:getCharacter(face) or nil)
        if chara then
            chara:setAnimation("talk")
        end

        local y = self.state.current_y + (self:getFont():getHeight() / 2)
        local sprite = Sprite("talk", self.state.current_x - 12, y, nil, nil, "face/embedded/" .. face)
        sprite:setOrigin(0, 0.5)
        sprite.layer = self.layer + 1
        sprite:setAnimation(function(sprite, wait)
            while true do
                sprite:setFrame(sprite.frame == 1 and 2 or 1)

                if sprite.frame == 1 and not (current_face == face and self:isTyping()) then
                    if chara then
                        chara:setAnimation("idle")
                    end
                    sprite:setFrame(1)
                    break
                end
                wait(0.15)
            end
        end)
        self:addChild(sprite)
        table.insert(self.sprites, sprite)

        self.state.current_x = (self.state.current_x + sprite.width + self.state.spacing) - 8
    end

    ---@type { functions: table<string, fun(self: DialogueText, ...)> }
    local preset_options = {
        functions = {
            nodeface = createFace
        }
    }

    return createFace, preset_options
end