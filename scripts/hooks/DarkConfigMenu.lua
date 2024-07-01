---@class DarkConfigMenu
local DarkConfigMenu, super = Class("DarkConfigMenu", true)

function DarkConfigMenu:init()
    super.init(self)

    self.extras_substate = ""
    self.bulborb_positions = {"TopLeft", "TopRight", "BottomLeft", "BottomRight", "Center"}

--  Setup variables
    self.current_page = 1

    self.key_bindings = {}

    self.banned_key = {}

    self.arrow_sprite = Assets.getTexture("ui/flat_arrow_right")

    self:setKeyBindings()

    self:setGamePad()

--  Set the maximum number of page
    self.max_page = Utils.ceil(#self.key_bindings/7)
end

function DarkConfigMenu:setKeyBindings()
    -- Count how many key bind in everything
    local count = 0

    for _, _ in pairs(Input.key_bindings) do
        count = count + 1
    end

    -- Call a function that verify if get then key binds that are in the mod and the libs while not taking banned key
    for index = 1, count do
        self:getKeyBindings(Input.orderedNumberToKey(index))
    end

    --  Get all key bind that weren't in the banned_key list
    for index = 1, count do
        if not Utils.containsValue(self.banned_key, Input.orderedNumberToKey(index)) then 
            table.insert(self.key_bindings, Input.orderedNumberToKey(index))
        end
    end
end

function DarkConfigMenu:getKeyBindings(key)
--  Create a variable for later check
    local valid_keys = {}

--  Check if the mod has key binds and if so, insert said key binds in valid_keys
    if Mod["info"].keybinds then
        for index, _ in pairs(Mod["info"].keybinds) do
            table.insert(valid_keys, Mod["info"].keybinds[index].id)
        end
    end

    --  Check for banned key from mod config
    if Mod["info"].banned_key then
        for _, name in pairs(Mod["info"].banned_key) do
            table.insert(self.banned_key, name)
        end
    end

    --  Check if the mod's libs has key binds and if so, insert said key binds in valid_keys
    for _, lib in pairs(Mod.libs) do
        if lib["info"].keybinds then
            for index, _ in pairs(lib["info"].keybinds) do
                table.insert(valid_keys, lib["info"].keybinds[index].id)
            end
        end
        if Kristal.getLibConfig(lib["info"].id, "banned_key") then
            for _, name in pairs(Kristal.getLibConfig(lib["info"].id, "banned_key")) do
                table.insert(self.banned_key, name)
            end
        end
    end

--  Check for the vanilla key binds and insert them in valid_keys
    for index = 1, #Input.order do
        table.insert(valid_keys, Input.order[index])
    end

--  Insert all key binds that wern't found in the banned_key list
    for index, name in pairs(valid_keys) do
        if not Utils.containsValue(valid_keys, key) then
            table.insert(self.banned_key, key)
        end
    end    
end

function DarkConfigMenu:setGamePad()
    --  Check if the mod has controller binds and if not add it.
    if Mod["info"].keybinds then
        for index, _ in pairs(Mod["info"].keybinds) do
            if not Mod["info"].keybinds[index].gamepad and not Input.gamepad_bindings[Mod["info"].keybinds[index].id] then
                Input.gamepad_bindings[Mod["info"].keybinds[index].id] = {}
            end
        end
    end

    --  Check if the mod's libs has controller binds and if not add it.
    for _, lib in pairs(Mod.libs) do
        if lib["info"].keybinds then
            for index, _ in pairs(lib["info"].keybinds) do
                if not lib["info"].keybinds[index].gamepad and not Input.gamepad_bindings[Mod["info"].keybinds[index].id] then
                    Input.gamepad_bindings[lib["info"].keybinds[index].id] = {}
                end
            end
        end
    end
end

function DarkConfigMenu:getBindNumberFromIndex(current_index)
    local shown_bind = 1
    local alias = self.key_bindings[current_index]
    local keys = Input.getBoundKeys(alias, Input.usingGamepad())
    for index, current_key in ipairs(keys) do
        if Input.usingGamepad() then
            if Utils.startsWith(current_key, "gamepad:") then
                shown_bind = index
                break
            end
        else
            if not Utils.startsWith(current_key, "gamepad:") then
                shown_bind = index
                break
            end
        end
    end
    return shown_bind
end

function DarkConfigMenu:update()
    if self.state == "MAIN" then
        if Input.pressed("confirm") then
            self.ui_select:stop()
            self.ui_select:play()

            if self.currently_selected == 1 then
                self.state = "VOLUME"
                self.noise_timer = 0
            elseif self.currently_selected == 2 then
                self.state = "CONTROLS"
                self.currently_selected = 1
            elseif self.currently_selected == 3 then
                Kristal.Config["simplifyVFX"] = not Kristal.Config["simplifyVFX"]
            elseif self.currently_selected == 4 then
                Kristal.Config["fullscreen"] = not Kristal.Config["fullscreen"]
                love.window.setFullscreen(Kristal.Config["fullscreen"])
            elseif self.currently_selected == 5 then
                Kristal.Config["autoRun"] = not Kristal.Config["autoRun"]
            elseif self.currently_selected == 6 then
                self.state = "EXTRAS"
                self.extras_substate = ""
                self.currently_selected = 1
            elseif self.currently_selected == 7 then
                Game.world.menu:closeBox()
            end

            return
        end

        if Input.pressed("cancel") then
            self.ui_cancel_small:stop()
            self.ui_cancel_small:play()
            Game.world.menu:closeBox()
            return
        end

        if Input.pressed("up") then
            self.currently_selected = self.currently_selected - 1
            self.ui_move:stop()
            self.ui_move:play()
        end
        if Input.pressed("down") then
            self.currently_selected = self.currently_selected + 1
            self.ui_move:stop()
            self.ui_move:play()
        end

        self.currently_selected = Utils.clamp(self.currently_selected, 1, 7)
    elseif self.state == "EXTRAS" then
        if self.extras_substate == "BORDER" then
            -- FIXME: if we write to Kristal.Config, we completely change the global setting,
            -- so if we add our own borders to BORDER_TYPES and a user selects one,
            -- it will cause the engine to load nonexistent borders outside of the mod,
            -- fail and fallback to a potentially unwanted setting (off i think)
            -- DON'T EDIT scripts/globals/BORDER_TYPES.lua to add new entries
            -- until we figure out how to deal with this

            if Input.pressed("cancel") or Input.pressed("confirm") then
                self.extras_substate = ""
                self.ui_select:stop()
                self.ui_select:play()
            end
            local border_index = -1
            for current_index, border in ipairs(BORDER_TYPES) do
                if border[1] == Kristal.Config["borders"] then
                    border_index = current_index
                end
            end
            if border_index == -1 then
                border_index = 1
            end
            local old_index = border_index
            if Input.pressed("left") then
                border_index = math.max(border_index - 1, 1)
            end
            if Input.pressed("right") then
                border_index = math.min(border_index + 1, #BORDER_TYPES)
            end
            if old_index ~= border_index then
                self.ui_move:stop()
                self.ui_move:play()
                Kristal.Config["borders"] = BORDER_TYPES[border_index][1]
                if BORDER_TYPES[border_index][1] == "off" then
                    Kristal.resetWindow()
                elseif BORDER_TYPES[old_index][1] == "off" then
                    Kristal.resetWindow()
                end
            end
        elseif self.extras_substate == "BULBORBSCALE" then
            if Input.pressed("cancel") or Input.pressed("confirm") then
                self.extras_substate = ""
                self.ui_select:stop()
                self.ui_select:play()
            end
            local scale = Mod.bulborb_reaction:getScale()
            if Input.pressed("left") then
                scale = math.max(scale - 0.1, 0.1)
                Mod.bulborb_reaction:setScale(scale)
                Game:setFlag("bulborb_scale", scale)
                self.ui_move:stop()
                self.ui_move:play()
            end
            if Input.pressed("right") then
                scale = scale + 0.1
                Mod.bulborb_reaction:setScale(scale)
                Game:setFlag("bulborb_scale", scale)
                self.ui_move:stop()
                self.ui_move:play()
            end
        elseif self.extras_substate == "BULBORBLOCATION" then
            if Input.pressed("cancel") or Input.pressed("confirm") then
                self.extras_substate = ""
                self.ui_select:stop()
                self.ui_select:play()
                self.ui_move:stop()
                self.ui_move:play()
            end
            local b_pos = Game:getFlag("bulborb_position", 2)
            if Input.pressed("left") then
                b_pos = math.max(b_pos - 1, 1)
                Game:setFlag("bulborb_position", b_pos)
                Mod:repositionBulborb()
                self.ui_move:stop()
                self.ui_move:play()
            end
            if Input.pressed("right") then
                b_pos = math.min(b_pos + 1, 5)
                Game:setFlag("bulborb_position", b_pos)
                Mod:repositionBulborb()
                self.ui_move:stop()
                self.ui_move:play()
            end
        else
            if Input.pressed("confirm") then
                self.ui_select:stop()
                self.ui_select:play()

                if self.currently_selected == 1 then
                    Game.world:openMenu(AchievementsMenu())
                elseif self.currently_selected == 2 then
                    self.extras_substate = "BORDER"
                elseif self.currently_selected == 3 then
                    self.extras_substate = "BULBORBSCALE"
                elseif self.currently_selected == 4 then
                    self.extras_substate = "BULBORBLOCATION"
                elseif self.currently_selected == 5 then
                    self.state = "MAIN"
                    self.currently_selected = 1
                end

                return
            end

            if Input.pressed("cancel") then
                self.ui_cancel_small:stop()
                self.ui_cancel_small:play()
                self.state = "MAIN"
                self.currently_selected = 1
                return
            end

            if Input.pressed("up") then
                self.currently_selected = self.currently_selected - 1
                self.ui_move:stop()
                self.ui_move:play()
            end
            if Input.pressed("down") then
                self.currently_selected = self.currently_selected + 1
                self.ui_move:stop()
                self.ui_move:play()
            end

            self.currently_selected = Utils.clamp(self.currently_selected, 1, 6)
        end
    elseif self.state == "VOLUME" then
        if Input.pressed("cancel") or Input.pressed("confirm") then
            Kristal.setVolume(Utils.round(Kristal.getVolume() * 100) / 100)
            self.ui_select:stop()
            self.ui_select:play()
            self.state = "MAIN"
            return
        end

        self.noise_timer = self.noise_timer + DTMULT
        if Input.down("left") then
            Kristal.setVolume(Kristal.getVolume() - ((2 * DTMULT) / 100))
            if self.noise_timer >= 3 then
                self.noise_timer = self.noise_timer - 3
                Assets.stopAndPlaySound("noise")
            end
        end
        if Input.down("right") then
            Kristal.setVolume(Kristal.getVolume() + ((2 * DTMULT) / 100))
            if self.noise_timer >= 3 then
                self.noise_timer = self.noise_timer - 3
                Assets.stopAndPlaySound("noise")
            end
        end
        if (not Input.down("right")) and (not Input.down("left")) then
            self.noise_timer = 3
        end
    end

    self.reset_flash_timer = math.max(self.reset_flash_timer - DTMULT, 0)

    super.super.update(self)
end

function DarkConfigMenu:onKeyPressed(key)
    if self.state == "CONTROLS" then

    --  Check if not rebinding
        if not self.rebinding then
        --  If not rebinding and allowed, close the "controls" sub menu
            if Input.pressed("cancel") and Kristal.getLibConfig("xtractrl", "cancel") then
                self.reset_flash_timer = 0
                self.state = "MAIN"
                self.currently_selected = 2
                Input.clear("confirm", true)
            end
        end

        if self.rebinding then
            local gamepad = Utils.startsWith(key, "gamepad:")

            local worked = key ~= "escape" and
                Input.setBind(self.key_bindings[self.currently_selected + 7*(self.current_page-1)], 1, key, gamepad)

            self.rebinding = false

            if worked then
                self.ui_select:stop()
                self.ui_select:play()
            else
                self.ui_cant_select:stop()
                self.ui_cant_select:play()
            end

            return
        end
        if Input.pressed("confirm") then
            if self.currently_selected < 8 then
                self.ui_select:stop()
                self.ui_select:play()
                self.rebinding = true
                return
            end

            if self.currently_selected == 8 then
                Assets.playSound("levelup")

                if Kristal.isConsole() then
                    Input.resetBinds(true)  -- Console, no keyboard, only reset gamepad binds
                elseif Input.hasGamepad() then
                    Input.resetBinds()      -- PC, keyboard and gamepad, reset all binds
                else
                    Input.resetBinds(false) -- PC, no gamepad, only reset keyboard binds
                end
                self:setGamePad()
                Input.saveBinds()
                self.reset_flash_timer = 10
            end

            if self.currently_selected == 9 then
                self.reset_flash_timer = 0
                self.state = "MAIN"
                self.currently_selected = 2
                self.ui_select:stop()
                self.ui_select:play()
                Input.clear("confirm", true)
            end
            return
        end

        local old_selected = self.currently_selected
        if Input.pressed("up") then
            self.currently_selected = self.currently_selected - 1
            if self.currently_selected ~= 8 and self.current_page == self.max_page and self.max_page ~= 1 and self.key_bindings[self.currently_selected + 7*(self.current_page-1)] == nil then
                self.currently_selected = #self.key_bindings - 7*(self.current_page-1)
            end
        end
        if Input.pressed("down") then
            self.currently_selected = self.currently_selected + 1
            if self.currently_selected <= 8 and self.key_bindings[self.currently_selected + 7*(self.current_page-1)] == nil then
                self.currently_selected = 8
            end
        end

    --  Check if the right key is pressed
        if Input.pressed("right") then

        --  Check if there is no key with an index = self.currently_select on the next page
            if self.key_bindings[self.currently_selected + 7*(self.current_page)] == nil and self.current_page ~= self.max_page and self.currently_selected < 8 then

            --  If the cursor is more close to the last key bind set it to the last key
                if self.currently_selected < 8 - Utils.round((8 - (#self.key_bindings - 7*(self.current_page)/2))) then
                    self.currently_selected = #self.key_bindings - 7*(self.current_page)
                    
            --  Otherwise set it to the 8 selection
                elseif self.currently_selected >= 8 - Utils.round((8 - (#self.key_bindings - 7*(self.current_page)/2))) and self.currently_selected <= 8 then
                    self.currently_selected = 8
                end
            end
        end

        self.currently_selected = Utils.clamp(self.currently_selected, 1, 9)

        if old_selected ~= self.currently_selected then
            self.ui_move:stop()
            self.ui_move:play()
        end

    --  Stuff for the page selection
        local old_page = self.current_page
        if Input.pressed("left") then
            self.current_page = self.current_page - 1
        end
        if Input.pressed("right") then
            self.current_page = self.current_page + 1
        end

        self.current_page = Utils.clamp(self.current_page, 1, self.max_page)

        if old_page ~= self.current_page then
            self.ui_move:stop()
            self.ui_move:play()
        end
    end
end

function DarkConfigMenu:draw()
    if Game.state == "EXIT" then
        super.super.draw(self)
        return
    end
    love.graphics.setFont(self.font)
    love.graphics.setColor(PALETTE["world_text"])

    if self.state == "EXTRAS" then
        love.graphics.print("EXTRAS", 188, -12)

        love.graphics.print("Achievements",     88, 38 + (0 * 32))
        if self.extras_substate == "BORDER" then
            love.graphics.setColor(PALETTE["world_text_selected"])
        end
        love.graphics.print("Border",           88, 38 + (1 * 32))
        love.graphics.setColor(PALETTE["world_text"])
        if self.extras_substate == "BULBORBSCALE" then
            love.graphics.setColor(PALETTE["world_text_selected"])
        end
        love.graphics.print("Bulborb Scale",    88, 38 + (2 * 32))
        love.graphics.setColor(PALETTE["world_text"])
        if self.extras_substate == "BULBORBLOCATION" then
            love.graphics.setColor(PALETTE["world_text_selected"])
        end
        love.graphics.print("Bulborb Location", 88, 38 + (3 * 32))
        love.graphics.setColor(PALETTE["world_text"])
        love.graphics.print("Back",             88, 38 + (4 * 32))

        if self.extras_substate == "BORDER" then
            love.graphics.setColor(PALETTE["world_text_selected"])
        end
        love.graphics.print(Kristal.getBorderName(),                                        348, 38 + (1 * 32))
        love.graphics.setColor(PALETTE["world_text"])
        if self.extras_substate == "BULBORBSCALE" then
            love.graphics.setColor(PALETTE["world_text_selected"])
        end
        love.graphics.print(tostring(Mod.bulborb_reaction:getScale()),                      348, 38 + (2 * 32))
        love.graphics.setColor(PALETTE["world_text"])
        if self.extras_substate == "BULBORBLOCATION" then
            love.graphics.setColor(PALETTE["world_text_selected"])
        end
        love.graphics.print(self.bulborb_positions[Game:getFlag("bulborb_position", 2)],    348, 38 + (3 * 32), 0, 0.9, 1)

        love.graphics.setColor(Game:getSoulColor())
        love.graphics.draw(self.heart_sprite,  63, 48 + ((self.currently_selected - 1) * 32))
    elseif self.state ~= "CONTROLS" then
        love.graphics.print("CONFIG", 188, -12)

        if self.state == "VOLUME" then
            love.graphics.setColor(PALETTE["world_text_selected"])
        end
        love.graphics.print("Master Volume",   88, 38 + (0 * 32))
        love.graphics.setColor(PALETTE["world_text"])
        love.graphics.print("Controls",        88, 38 + (1 * 32))
        love.graphics.print("Simplify VFX",    88, 38 + (2 * 32))
        love.graphics.print("Fullscreen",      88, 38 + (3 * 32))
        love.graphics.print("Auto-Run",        88, 38 + (4 * 32))
        love.graphics.print("Extras",          88, 38 + (5 * 32))
        love.graphics.print("Back",            88, 38 + (6 * 32))

        if self.state == "VOLUME" then
            love.graphics.setColor(PALETTE["world_text_selected"])
        end
        love.graphics.print(Utils.round(Kristal.getVolume() * 100) .. "%",      348, 38 + (0 * 32))
        love.graphics.setColor(PALETTE["world_text"])
        love.graphics.print(Kristal.Config["simplifyVFX"] and "ON" or "OFF",    348, 38 + (2 * 32))
        love.graphics.print(Kristal.Config["fullscreen"]  and "ON" or "OFF",    348, 38 + (3 * 32))
        love.graphics.print(Kristal.Config["autoRun"]     and "ON" or "OFF",    348, 38 + (4 * 32))

        love.graphics.setColor(Game:getSoulColor())
        love.graphics.draw(self.heart_sprite,  63, 48 + ((self.currently_selected - 1) * 32))
    else
        -- NOTE: This is forced to true if using a PlayStation in DELTARUNE... Kristal doesn't have a PlayStation port though.
        local dualshock = Input.getControllerType() == "ps4"

        love.graphics.print("Function", 23,  -12)
        -- Console accuracy for the Heck of it
        if not USING_CONSOLE then
            love.graphics.print("Key", 243, -12)
        end
        if Input.hasGamepad() then
            love.graphics.print(USING_CONSOLE and "Button" or "Gamepad", 353, -12)
        end

--  Lib Stuff
    --  Show current page/last page if not on the first and supposed to hide it
    if Kristal.getLibConfig("xtractrl", "hide_if_1") and self.max_page == 1 then
    else
        if self.max_page < 10 then
            love.graphics.print(self.current_page.."/"..self.max_page, 418, -4 + (28 * 9) + 4)
        elseif self.max_page >= 10 and self.current_page < 10 then
            love.graphics.print(self.current_page.."/"..self.max_page, 418 - 6, -4 + (28 * 9) + 4)
        else
            love.graphics.print(self.current_page.."/"..self.max_page, 418 - 14, -4 + (28 * 9) + 4)
        end
    end

--  Code for the arrow sprite
    local sine_off
    if sine_off == nil then
        sine_off = 0
    end

    sine_off = math.sin((Kristal.getTime()*30)/16) * 3

    if Kristal.getLibConfig("xtractrl", "hide_if_1") and self.max_page == 1 then
    else
        if self.current_page ~= 1 then -- Gauche
            if self.max_page < 10 then
                Draw.draw(self.arrow_sprite, 418 - 8 + sine_off, 264, 0, -1, 1)
            elseif self.max_page >= 10 and self.current_page < 10 then
                Draw.draw(self.arrow_sprite, 418 - 14 + sine_off, 264, 0, -1, 1)
            else
                Draw.draw(self.arrow_sprite, 418 - 22 + sine_off, 264, 0, -1, 1)
            end
        end
        if self.current_page ~= self.max_page then -- Droite
            if self.max_page < 10 then
                Draw.draw(self.arrow_sprite, 418 + 50 - sine_off, 264)
            elseif self.max_page >= 10 and self.current_page < 10 then
                Draw.draw(self.arrow_sprite, 418 + 56 - sine_off, 264)
            else
                Draw.draw(self.arrow_sprite, 418 + 62 - sine_off, 264)
            end
        end
    end

--  Switch out Input.order for the key_bindings list made in init
    for index, name in ipairs(self.key_bindings) do
        if index <= 7*self.current_page and index > (self.current_page-1)*7 then
            Draw.setColor(PALETTE["world_text"])
            if self.currently_selected == index - (self.current_page-1)*7 then
                if self.rebinding then
                    Draw.setColor(PALETTE["world_text_rebind"])
                else
                    Draw.setColor(PALETTE["world_text_hover"])
                end
            end

            if dualshock then
                love.graphics.print(name:gsub("_", " "):upper(), 23, -4 + (29 * (index - (self.current_page-1)*7)))
            else
                love.graphics.print(name:gsub("_", " "):upper(), 23, -4 + (28 * (index - (self.current_page-1)*7) + 4))
            end

            --local shown_bind = self:getBindNumberFromIndex(index)

            if not Kristal.isConsole() then
                local alias = Input.getBoundKeys(name, false)[1]
                if type(alias) == "table" then
                    local title_cased = {}
                    for _, word in ipairs(alias) do
                        table.insert(title_cased, Utils.titleCase(word))
                    end
                    love.graphics.print(table.concat(title_cased, "+"), 243, 0 + (28 * (index - (self.current_page-1)*7)))
                elseif alias ~= nil then
                    love.graphics.print(Utils.titleCase(alias), 243, 0 + (28 * (index - (self.current_page-1)*7)))
                end
            end

            Draw.setColor(1, 1, 1)

            if Input.hasGamepad() then
                local alias = Input.getBoundKeys(name, true)[1]
                if alias then
                    local btn_tex = Input.getButtonTexture(alias)
                    if dualshock then
                        Draw.draw(btn_tex, 353 + 42, -2 + (29 * (index - (self.current_page-1)*7)), 0, 2, 2, btn_tex:getWidth() / 2, 0)
                    else
                        Draw.draw(btn_tex, 353 + 42 + 16 - 6, -2 + (28 * (index - (self.current_page-1)*7)) + 11 - 6 + 1, 0, 2, 2,
                                btn_tex:getWidth() / 2, 0)
                    end
                end
            end
        end
    end

        love.graphics.setColor(PALETTE["world_text"])
        if self.currently_selected == 8 then
            love.graphics.setColor(PALETTE["world_text_hover"])
        end

        if (self.reset_flash_timer > 0) then
            love.graphics.setColor(Utils.mergeColor(PALETTE["world_text_hover"], PALETTE["world_text_selected"], ((self.reset_flash_timer / 10) - 0.1)))
        end

        if dualshock then
            love.graphics.print("Reset to default", 23, -4 + (29 * 8))
        else
            love.graphics.print("Reset to default", 23, -4 + (28 * 8) + 4)
        end

        love.graphics.setColor(PALETTE["world_text"])
        if self.currently_selected == 9 then
            love.graphics.setColor(PALETTE["world_text_hover"])
        end

        if dualshock then
            love.graphics.print("Finish", 23, -4 + (29 * 9))
        else
            love.graphics.print("Finish", 23, -4 + (28 * 9) + 4)
        end

        love.graphics.setColor(Game:getSoulColor())

        if dualshock then
            love.graphics.draw(self.heart_sprite,  -2, 34 + ((self.currently_selected - 1) * 29))
        else
            love.graphics.draw(self.heart_sprite,  -2, 34 + ((self.currently_selected - 1) * 28) + 2)
        end
    end

    love.graphics.setColor(1, 1, 1, 1)

    super.super.draw(self)
end

return DarkConfigMenu