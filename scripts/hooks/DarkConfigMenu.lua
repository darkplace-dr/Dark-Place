---@class DarkConfigMenu
local DarkConfigMenu, super = Class("DarkConfigMenu", true)

function DarkConfigMenu:init()
    super.init(self)

    self.extras_substate = ""
    self.bulborb_positions = {"TopLeft", "TopRight", "BottomLeft", "BottomRight", "Center"}
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

        for index, name in ipairs(Input.order) do
            if index > 7 then
                break
            end
            love.graphics.setColor(PALETTE["world_text"])
            if self.currently_selected == index then
                if self.rebinding then
                    love.graphics.setColor(PALETTE["world_text_rebind"])
                else
                    love.graphics.setColor(PALETTE["world_text_hover"])
                end
            end

            if dualshock then
                love.graphics.print(name:gsub("_", " "):upper(),  23, -4 + (29 * index))
            else
                love.graphics.print(name:gsub("_", " "):upper(),  23, -4 + (28 * index) + 4)
            end

            local shown_bind = self:getBindNumberFromIndex(index)

            if not USING_CONSOLE then
                local alias = Input.getBoundKeys(name, false)[1]
                if type(alias) == "table" then
                    local title_cased = {}
                    for _, word in ipairs(alias) do
                        table.insert(title_cased, Utils.titleCase(word))
                    end
                    love.graphics.print(table.concat(title_cased, "+"), 243, 0 + (28 * index))
                elseif alias ~= nil then
                    love.graphics.print(Utils.titleCase(alias), 243, 0 + (28 * index))
                end
            end

            love.graphics.setColor(1, 1, 1)

            if Input.hasGamepad() then
                local alias = Input.getBoundKeys(name, true)[1]
                if alias then
                    local btn_tex = Input.getButtonTexture(alias)
                    if dualshock then
                        love.graphics.draw(btn_tex, 353 + 42, -2 + (29 * index), 0, 2, 2, btn_tex:getWidth()/2, 0)
                    else
                        love.graphics.draw(btn_tex, 353 + 42 + 16 - 6, -2 + (28 * index) + 11 - 6 + 1, 0, 2, 2, btn_tex:getWidth()/2, 0)
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