local BossRematchMenu, super = Class(Object)

function BossRematchMenu:init()
    super.init(self, SCREEN_WIDTH / 2 - 480 / 2, SCREEN_HEIGHT / 2 - 320 / 2, 480, 320)

    self.parallax_x = 0
    self.parallax_y = 0

    self.draw_children_below = 0

    self.bg = UIBox(0, 0, self.width, self.height)
    self.bg.layer = -1
    self.bg.debug_select = false
    self:addChild(self.bg)

    self.font = Assets.getFont("main")
    self.font_2 = Assets.getFont("plain")

    self.ui_move = Assets.newSound("ui_move")
    self.ui_select = Assets.newSound("ui_select")
    self.ui_cant_select = Assets.newSound("ui_cant_select")
    self.ui_cancel_small = Assets.newSound("ui_cancel_small")

    self.up_sprite = Assets.getTexture("ui/page_arrow_up")
    self.down_sprite = Assets.getTexture("ui/page_arrow_down")
    self.soul = Assets.getTexture("player/heart")
    self.gradient = Assets.getTexture("ui/char_gradient")

    self.currently_selected = 1
    self.page = 1
    self.line_height = 30
    self.item_color_unk = {0.5, 0.5, 0.5}
    self.item_color = {1, 1, 1}

    -- preview is a table. First index is a sprite path, second is the X offset, third is the Y offset.
    -- Each page has room for 8 entries. Any more than that, and you'll either have text overlapping or text going off the UI box.
    self.encounters = {
        -- Page 1
        {
            { name = "Spamgolor",            flag = "spamgolor_defeated",    encounter = "spamgolor",             grad_color = {20/255, 60/255, 194/255}, preview = {"world/npcs/spamgolor/idle", 70, 50}},
            { name = "Mimic",                flag = "mimic_defeated",        encounter = "mimicboss",             grad_color = {24/255, 94/255, 231/255},  preview = {"battle/enemies/ufoofdoom/idle_1", 70, 0}},
            { name = "Starwalker",           flag = "starwalker_defeated",   encounter = "starwalker",            grad_color = {134/255, 148/255, 183/255}, preview = {"battle/enemies/starwalker2/starwalker", 60, 50}},
            { name = "Sam",                  flag = "sam_defeated",          encounter = "sam",                   grad_color = {0, 0, 1},                  preview = {"world/npcs/sam/idle", 60, 50}},
            { name = "Zero",                 flag = "zero_defeated",         encounter = "zero",                  grad_color = {136/255, 48/255, 80/255}, preview = {"battle/enemies/zero/idle_0", 70, 50}},
            { name = "Omega Spamton",        flag = "omegaspamton_defeated", encounter = "omegaspamtonbossfight", grad_color = {93/255, 73/255, 139/255}, preview = {"battle/enemies/omegaspamton/preview", -19, 0}},
            { name = "Google Dino",          flag = "googledino_defeated",   encounter = "googledino",            grad_color = {0.5, 0.5, 0.5},           preview = {"world/npcs/googledino/static", 60, 50}},
            { name = "Shade Ania",           flag = "jamm_closure",          encounter = "ania_boss",             grad_color = {92/255, 88/255, 188/255}, preview = {"battle/enemies/shade_ania/idle", 75, 50}},
        },
        -- Page 2
        {
            { name = "Booty the Bootleg",    flag = "booty_finished",        encounter = "big_booty",             grad_color = {20/255, 60/255, 194/255}, preview = {"battle/enemies/booty/idle", 75, 50}},
        },

    }
	
	self.bosses = {}
	
    for i, _ in ipairs(self.encounters) do
	    for n, v in ipairs(self.encounters[i]) do
		    if Game:getFlag(v.flag) then
			    table.insert(self.bosses, v)
		    end
	    end
    end

end

function BossRematchMenu:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(self.font)
    love.graphics.printf("Bosses", 0, 0, self.width, "center")
    love.graphics.setFont(self.font_2)
    love.graphics.printf("Press [R] to fight all bosses in a boss rush.", 0, 300, self.width, "center")

    local entry = self.encounters[self.page][self.currently_selected]
	
    if Game:getFlag(entry.flag) then
	    love.graphics.setColor(entry.grad_color)
    end

    love.graphics.draw(self.gradient, 260, 50)

    if Game:getFlag(entry.flag) then
	    love.graphics.setColor(1, 1, 1)
    else
        love.graphics.setColor(0, 0, 0)
    end
	
	
	love.graphics.setColor(1, 1, 1)
	love.graphics.setLineWidth(2)
    love.graphics.rectangle("line", 260, 50, 200, 140)

    if Game:getFlag(entry.flag) and entry.preview then
        local preview = entry.preview
        love.graphics.draw(Assets.getTexture(preview[1]), 260 + preview[2], 50 + preview[3], 0, (entry.name == "Omega Spamton" and 1 or 2))
    end

    local y_off = 16

    love.graphics.setFont(self.font_2)
    love.graphics.setColor(1, 0, 0)
    love.graphics.draw(self.soul, 0, y_off + self.line_height * self.currently_selected)
    love.graphics.setColor(1, 1, 1)

    local line_x = 24
    local line_y = y_off + self.line_height * 1
    for _, encounter in ipairs(self.encounters[self.page]) do
        if Game:getFlag(encounter.flag) then
            love.graphics.setColor(unpack(self.item_color))
            love.graphics.print(encounter.name, line_x, line_y)
        else
            love.graphics.setColor(unpack(self.item_color_unk))
            love.graphics.print(string.rep("?", utf8.len(encounter.name)), line_x, line_y)
        end
        love.graphics.setColor(1, 1, 1)
        line_y = line_y + self.line_height
    end

    love.graphics.setColor(1, 1, 1)
    if self.page > 1 then
        love.graphics.draw(self.up_sprite, 230, -10, 0, 1, 1)
    end
    if self.page < #self.encounters then
        love.graphics.draw(self.down_sprite, 230, 262, 0, 1, 1)
    end

    super.draw(self)
end

function BossRematchMenu:onKeyPressed(key, is_repeat)
    if Input.isMenu(key) or Input.isCancel(key) then
        self.ui_cancel_small:stop()
        self.ui_cancel_small:play()
        Game.world:closeMenu()
        return
    end

    if Input.is("up", key) then
        if self.currently_selected > 1 then
            self.currently_selected = self.currently_selected - 1
            self.ui_move:stop()
            self.ui_move:play()
        elseif self.page > 1 then
        self.page = self.page - 1
        self.currently_selected = #self.encounters[self.page]
        self.ui_move:stop()
        self.ui_move:play()
        elseif not is_repeat then
            self.currently_selected = #self.encounters[self.page]
            self.ui_move:stop()
            self.ui_move:play()
        end
    end
    if Input.is("down", key) then
        if self.currently_selected < #self.encounters[self.page] then
            self.currently_selected = self.currently_selected + 1
            self.ui_move:stop()
            self.ui_move:play()
        elseif self.page < #self.encounters then
            self.currently_selected = 1
            self.page = self.page + 1
            self.ui_move:stop()
            self.ui_move:play()
        elseif not is_repeat then
            self.currently_selected = 1
            self.ui_move:stop()
            self.ui_move:play()
        end
    end
    if Input.pressed("confirm") then
        local entry = self.encounters[self.page][self.currently_selected]
        if Game:getFlag(entry.flag) then
            self.ui_select:stop()
            self.ui_select:play()
            Game.world:closeMenu()
            Game:encounter(entry.encounter)
        else
            self.ui_cant_select:stop()
            self.ui_cant_select:play()
        end
    end
    if Input.pressed("r") then
        self.ui_select:stop()
        self.ui_select:play()
        Game.world:closeMenu()
        Game.world:startCutscene(function(cutscene)
            for i, v in ipairs(self.bosses) do
                -- cutscene:text("* "..#self.bosses-(i-1).." left to go.[wait:10]\n* Up next:[wait:5] "..v[1]..".")
				cutscene:text("* "..#self.bosses-(i-1).." left to go.[wait:10]\n* Up next:[wait:5]"..v.name..".")
                cutscene:startEncounter(v.encounter, true)
				while Game.battle do end
            end
            cutscene:text("* Congratulations![wait:10] You win absolutely nothing!")
        end)
    end
end

function BossRematchMenu:close()
    Game.world.menu = nil
    self:remove()
end

return BossRematchMenu
