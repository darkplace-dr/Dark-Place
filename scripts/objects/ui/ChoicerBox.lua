local ChoicerBox, super = Class(Object)

function ChoicerBox:init(choices, options)
    options = options or {
        sprite = nil,           -- Sprite for the Soul Component to use instead of the regular heart.
        cancel_option = nil     -- Default option to select when cancelling out of the menu. Leaving it as nil prevents doing this.
    }
    Input.clear("confirm")
    Input.clear("cancel")
    local textbox = Game.world.cutscene.textbox
    Game.world.cutscene.choice = nil
    Game.world.cutscene:wait(function ()
        return Game.world.cutscene.choice
    end)

    local soul = Game.stage:addChild(EasingSoul(0,0))
    if not options.sprite and Mod:isOmori() then
        soul.sprite:set("player/heart_menu_right_omori")
        soul.sprite.color = {1,1,1}
        soul:setScale(0.5)
        soul:setOrigin(0.5,-0.5)
    end
    if options.sprite then
        soul.sprite:set(options.sprite)
        soul.sprite.color = {1,1,1}
    end
    soul.use_parent = true
    soul.layer = WORLD_LAYERS["above_ui"]

    local box = BoxComponent(FitSizing())
    local menu = EasingSoulMenuComponent(FitSizing(), (#choices > 5 and FixedSizing(160) or FitSizing()), { hold = true, soul = soul })
    --menu.open_sound = "ui_move"
    if #choices > 5 then
        local scrollbar = ScrollbarComponent({gutter = "nothing", margins = {8, 0, 0, 0}, arrows = true})
        scrollbar.gutter_color = {1,1,1}
        menu:setScrollbar(scrollbar)
    end
    menu:setLayout(VerticalLayout({ gap = 0, align = "start" }))
    menu:setOverflow("scroll")
    menu:setScrollType("scroll")
    menu.choices = {}

    for i, choice in ipairs(choices) do
        local mychoice = i
        menu.choices[i] = menu:addChild(TextMenuItemComponent(Text( "[font:".. (Mod:getDefaultDialogTextFont() or "main") .. "]" .. choice), function ()
            Game.world.cutscene.choice = mychoice
            menu:close()
            box:remove()
            soul:remove()
            self:remove()
        end))
        if Mod:isOmori() then
            menu.choices[i].text.font = "OMORI"
            menu.choices[i].highlight = false
        end
    end

    if options.cancel_option then
        menu:setCancelCallback(function ()
            Game.world.cutscene.choice = options.cancel_option
            menu:close()
            box:remove()
            soul:remove()
            self:remove()
        end)
    end



    --]]
    menu:setFocused()
    box:addChild(menu)
    Game.stage:addChild(box)
    box.x = 24
    soul.x = box.x
    if textbox and textbox.y > SCREEN_HEIGHT/2 then -- Textbox is most likely on the bottom half of the screen
        box:setOrigin(0, 1)
        box.y = SCREEN_HEIGHT/2 + 80
        soul.y = box.y - (32 * #choices+32)
    else
        box:setOrigin(0, 0)
        box.y = 160
        soul.y = box.y
    end
end

return ChoicerBox