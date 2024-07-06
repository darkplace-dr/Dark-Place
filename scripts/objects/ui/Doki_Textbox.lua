---@class Doki_Textbox : Object
---@overload fun(...) : Doki_Textbox
local Doki_Textbox, super = Class(Object)

Doki_Textbox.REACTION_X = {
        ["left"] = 70  -38,
     ["leftmid"] = 160 -38,
         ["mid"] = 260 -38,
      ["middle"] = 260 -38,
    ["rightmid"] = 360 -38,
       ["right"] = 400 -38,
}
Doki_Textbox.REACTION_Y = {
          ["top"] = -10 -4,
          ["mid"] =  30 -4,
       ["middle"] =  30 -4,
    ["bottommid"] =  50 -4,
       ["bottom"] =  68 -4,
}

Doki_Textbox.REACTION_X_BATTLE = {
        ["left"] = 60  -40,
     ["leftmid"] = 160 -40,
         ["mid"] = 260 -40,
      ["middle"] = 260 -40,
    ["rightmid"] = 360 -40,
       ["right"] = 460 -40,
}
Doki_Textbox.REACTION_Y_BATTLE = {
          ["top"] = -10 -2,
          ["mid"] =  30 -2,
       ["middle"] =  30 -2,
    ["bottommid"] =  45 -2,
       ["bottom"] =  56 -2,
}

local function centerText(text, y)
    local windowWidth = 640
    local font = Assets.getFont("RifficFree_Bold")
    local textWidth = font:getWidth(text)
    --print(textWidth..": Doki")
    local x = (windowWidth - textWidth) / 2
    return {x - 174, y}
end

function Doki_Textbox:init(x, y, width, height, default_font, default_font_size, battle_box, nametext)
    super.init(self, x, y, width, height)
    if nametext then
        self.nametext = nametext
    end
    --self.width

    --self.box = UIBox(0, 0, width, height)
    self.box = Sprite("ui/box/doki_doki_literature_club/textbox")
    self.box.layer = -1
    self.box.debug_select = false
    self:addChild(self.box)
    self.box:setScale(0.75)


    --namebox
    self.tag_font = Assets.getFont("RifficFree_Bold")    --self:getFont("RifficFree-Bold")
    self.namebox = Sprite("ui/box/doki_doki_literature_club/namebox")
    self.namebox.layer = -1
    self.namebox.debug_select = false

    if self.nametext then
    self:addChild(self.namebox)
    self.namebox:setScale(0.75)
    self.namebox.y = -29
    self.namebox.x = 25
    end



    self.battle_box = battle_box
    if battle_box then
        self.box.visible = false
    end

    if battle_box then
        self.face_x = -4
        self.face_y = 2

        self.text_x = 0
        self.text_y = -2 -- TODO: This was changed 2px lower with the new font, but it was 4px offset. Why? (Used to be 0)
    elseif Game:isLight() then
        self.face_x = 13
        self.face_y = 6

        self.text_x = 2
        self.text_y = -4
    else
        self.face_x = 18
        self.face_y = 6

        self.text_x = 28
        self.text_y = 18

        --self.text_x = -88
        --self.text_y = 22
    end

    self.actor = nil

    self.default_font = "Aller_Rg"
    self.default_font_size = default_font_size

    self.font = self.default_font
    self.font_size = self.default_font_size

    self.face = Sprite(nil, self.face_x, self.face_y, nil, nil, "face")
    self.face:setScale(2, 2)
    self.face.getDebugOptions = function(self2, context)
        context = super.getDebugOptions(self2, context)
        if Kristal.DebugSystem then
            context:addMenuItem("Change", "Change this portrait to a different one", function()
                Kristal.DebugSystem:setState("FACES", self)
            end)
        end
        return context
    end
    --self:addChild(self.face)

    -- Added text width for autowrapping
    self.wrap_add_w = battle_box and 0 or 14

    self.text = DialogueText("", self.text_x, self.text_y, width + self.wrap_add_w, SCREEN_HEIGHT, {line_offset = 2})
    self.text.box_parent = self
    self:addChild(self.text)
    self.text:addFX(OutlineFX_V2({81/255, 54/255, 67/255}, {thickness = 1.35}))

    self.reactions = {}
    self.reaction_instances = {}

    self.text:registerCommand("face", function(text, node, dry)
        if self.actor and self.actor:getPortraitPath() then
            self.face.path = self.actor:getPortraitPath()
        end
        self:setFace(node.arguments[1], tonumber(node.arguments[2]), tonumber(node.arguments[3]))
    end)
    self.text:registerCommand("facec", function(text, node, dry)
        self.face.path = "face"
        local ox, oy = tonumber(node.arguments[2]), tonumber(node.arguments[3])
        if self.actor then
            local actor_ox, actor_oy = self.actor:getPortraitOffset()
            ox = (ox or 0) - actor_ox
            oy = (oy or 0) - actor_oy
        end
        self:setFace(node.arguments[1], ox, oy)
    end)

    self.text:registerCommand("react", function(text, node, dry)
        local react_data
        if #node.arguments > 1 then
            react_data = {
                text = node.arguments[1],
                x = tonumber(node.arguments[2]) or (self.battle_box and self.REACTION_X_BATTLE[node.arguments[2]] or self.REACTION_X[node.arguments[2]]),
                y = tonumber(node.arguments[3]) or (self.battle_box and self.REACTION_Y_BATTLE[node.arguments[3]] or self.REACTION_Y[node.arguments[3]]),
                face = node.arguments[4],
                actor = node.arguments[5] and Registry.createActor(node.arguments[5]),
            }
        else
            react_data = tonumber(node.arguments[1]) and self.reactions[tonumber(node.arguments[1])] or self.reactions[node.arguments[1]]
        end
        local reaction = SmallFaceText(react_data.text, react_data.x, react_data.y, react_data.face, react_data.actor)
        reaction.layer = 0.1 + (#self.reaction_instances) * 0.01
        self:addChild(reaction)
        table.insert(self.reaction_instances, reaction)
    end, {instant = false})

    self.advance_callback = nil
end
    local offset = 588
    local Btime = 0.68
    local xcord = 4 + offset
    local xcord2 = 0 + offset
function Doki_Textbox:bop1()
    Game.world.timer:tween(Btime, self.next_arrow, {x = xcord}, "sine", function() self:bop2() end)
end

function Doki_Textbox:bop2()
    Game.world.timer:tween(Btime, self.next_arrow, {x = xcord2}, "sine", function() self:bop1() end)
end



function Doki_Textbox:update()

    if not self:isTyping() then
        self.face:stop()
        if not self.next_arrow then
            self.next_arrow = Sprite("ui/box/doki_doki_literature_club/ctc")
            self.next_arrow:setScale(0.75)
            self.next_arrow.y = 90
            self.next_arrow.x = offset
            self:addChild(self.next_arrow)
            self:bop1()
            --Utils.ease(10, self.next_arrow.x, (100), "out-sine")
        else
            self.next_arrow:setColor(1, 1, 1, (self.next_arrow.x - 584)/8)
        end
    end
    super.update(self)
end

function Doki_Textbox:advance()
    self.text:advance()
end

function Doki_Textbox:setSize(w, h)
    self.width, self.height = w or 0, h or 0

    self.face:setPosition(116 / 2, self.height /2)
    self:updateTextBounds()
    if self.face.texture then
        self.box:setSize(self.width - 116, self.height)
    else
        self.box:setSize(self.width, self.height)
    end
end

function Doki_Textbox:setActor(actor)
    if type(actor) == "string" then
        actor = Registry.createActor(actor)
    end
    self.actor = actor

    if self.actor and self.actor:getPortraitPath() then
        self.face.path = self.actor:getPortraitPath()
    else
        self.face.path = "face"
    end
end

function Doki_Textbox:setFace(face, ox, oy)
    self.face:setSprite(face)
    self.face:play(4/30)

    if self.actor then
        local actor_ox, actor_oy = self.actor:getPortraitOffset()
        ox = (ox or 0) + actor_ox
        oy = (oy or 0) + actor_oy
    end
    self.face:setPosition(self.face_x + (ox or 0), self.face_y + (oy or 0))

    self:updateTextBounds()
end

function Doki_Textbox:setFont(font, size)
    if not font then
        self.font = self.default_font
        self.font_size = self.default_font_size
    else
        self.font = font
        self.font_size = size
    end
end

function Doki_Textbox:setAuto(auto)
    self.text.auto_advance = auto or false
end

function Doki_Textbox:setAdvance(advance)
    self.text.can_advance = advance or false
end

function Doki_Textbox:setSkippable(skippable)
    self.text.skippable = skippable or false
end

function Doki_Textbox:setAlign(align)
    self.text.align = align or "left"
    self:updateTextBounds()
end

function Doki_Textbox:setCallback(callback)
    self.advance_callback = callback
    self.text.advance_callback = callback
end

function Doki_Textbox:resetReactions()
    self.reactions = {}
    for _,reaction in ipairs(self.reaction_instances) do
        reaction:remove()
    end
    self.reaction_instances = {}
end

function Doki_Textbox:addReaction(id, text, x, y, face, actor)
    x, y = x or 0, y or 0
    if type(x) == "string" then
        x = self.battle_box and self.REACTION_X_BATTLE[x] or self.REACTION_X[x]
    end
    if type(y) == "string" then
        y = self.battle_box and self.REACTION_Y_BATTLE[y] or self.REACTION_Y[y]
    end
    if type(actor) == "string" then
        actor = Registry.createActor(actor)
    end
    self.reactions[id] = {
        text = text,
        x = x,
        y = y,
        face = face,
        actor = actor
    }
end

function Doki_Textbox:resetFunctions()
    self.text.functions = {}
end

function Doki_Textbox:addFunction(id, func)
    self.text:addFunction(id, func)
end

function Doki_Textbox:setText(text, callback)
    for _,reaction in ipairs(self.reaction_instances) do
        reaction:remove()
    end
    self.reaction_instances = {}
    self.text.font = self.font
    self.text.font_size = self.font_size

    if self.actor then
        if self.actor:getVoice() then
            if type(text) ~= "table" then
                text = {text}
            else
                text = Utils.copy(text)
            end
            for i,line in ipairs(text) do
                text[i] = "[voice:"..self.actor:getVoice().."]"..line
            end
        end
        if self.actor:getFont() then
            if type(text) ~= "table" then
                text = {text}
            else
                text = Utils.copy(text)
            end
            for i,line in ipairs(text) do
                text[i] = "[font:"..self.actor:getFont().."]"..line
            end
        end
        if self.actor:getIndentString() then
            self.text.indent_string = self.actor:getIndentString()
        end
    end
    self.text:setText(text, callback or self.advance_callback)
end

function Doki_Textbox:getText()
    return self.text.text
end

function Doki_Textbox:updateTextBounds()
    self.text.x = self.text_x
    self.text.width = self.width + self.wrap_add_w
end

function Doki_Textbox:getBorder()
    if self.box.visible then
        return 0, 0
    end
end

function Doki_Textbox:getDebugRectangle()
    if not self.debug_rect then
        local bw, bh = self:getBorder()
        return {-bw, -bh, self.width + bw*2, self.height + bh*2}
    end
    return super.getDebugRectangle(self)
end

function Doki_Textbox:isTyping()
    return self.text:isTyping()
end

function Doki_Textbox:isDone()
    return self.text:isDone()
end
--[[
function centerText(text, y)
    -- Get the width of the window
    local windowWidth = 640
    
    -- Get the width of the text
    local font = love.graphics.getFont()
    local textWidth = font:getWidth(text)
    
    -- Calculate the x coordinate to center the text
    local x = (windowWidth - textWidth) / 2
    
    -- Return the coordinates
    return x, y
end

function love.draw()
    local text = "Your Text Here"
    local y = 100  -- y coordinate where you want to place the text
    
    local x, y = centerText(text, y)
    
    love.graphics.print(text, x, y)
end
]]
function Doki_Textbox:draw()
    super.draw(self)
    love.graphics.setFont(self.tag_font)

    Draw.setColor(187/255, 85/255, 153/255, 1)
    --love.graphics.scale(0.7, 0.7)
    love.graphics.scale(0.6, 0.6)
    Draw.setColor(187/255, 85/255, 153/255, 1)
    local dm = 3.2

    --local text = "Your Text Here"
    
   -- local x, y = centerText(self.nametext, y)
    if self.nametext then
    local y = -45 -- for "Sayori" in the center
    local coord = centerText(self.nametext, y)
    --local coord = {122, -45} --for "???" question marks in center
    local directions = {
        {-dm, 0}, {dm, 0}, {0, -dm}, {0, dm},
        {-dm, -dm}, {dm, -dm}, {-dm, dm}, {dm, dm}
    }
    for _, dir in ipairs(directions) do
        love.graphics.print(self.nametext, dir[1] + coord[1], dir[2] + coord[2])
    end
    Draw.setColor(1, 1, 1, 1)
    love.graphics.print(self.nametext, coord[1], coord[2])
    end
    Draw.setColor(1, 1, 1, 1)
end

return Doki_Textbox