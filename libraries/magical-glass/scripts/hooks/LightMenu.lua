local LightMenu, super = Class("LightMenu", true)

function LightMenu:init()
    super.init(self, 0, 0)

    self.layer = 1 -- TODO

    self.parallax_x = 0
    self.parallax_y = 0

    self.animation_done = false
    self.animation_timer = 0
    self.animate_out = false

    self.selected_submenu = 1

    self.current_selecting = Game.world.current_selecting or 1

    self.item_selected = 1

    -- States: MAIN, ITEMMENU, ITEMUSAGE
    self.state = "MAIN"
    self.state_reason = nil
    self.heart_sprite = Assets.getTexture("player/heart_menu")

    self.ui_move = Assets.newSound("ui_move")
    self.ui_select = Assets.newSound("ui_select")
    self.ui_cant_select = Assets.newSound("ui_cant_select")
    self.ui_cancel_small = Assets.newSound("ui_cancel_small")

    self.font       = Assets.getFont("main")
    self.font_small = Assets.getFont("small")

    self.box = nil

    self.top = true

    self.info_box = UIBox(56, 76, 94, 62)
    self:addChild(self.info_box)
    self:realign()

    self.choice_box = UIBox(56, 192, 94, 100)
    self:addChild(self.choice_box)

    self.storage = "items"
    
    if Kristal.getLibConfig("magical-glass", "hide_cell") and not Game:getFlag("has_cell_phone") then
        self.max_selecting = 2
    else
        self.max_selecting = 3
    end
    if self.current_selecting > self.max_selecting then
        self.current_selecting = 1
    end
end

function LightMenu:onKeyPressed(key)
    if (Input.isMenu(key) or Input.isCancel(key)) and self.state == "MAIN" then
        Game.world:closeMenu()
        return
    end

    if self.state == "MAIN" then
        local old_selected = self.current_selecting
        if Input.is("up", key)    then self.current_selecting = self.current_selecting - 1 end
        if Input.is("down", key) then self.current_selecting = self.current_selecting + 1 end

        self.current_selecting = Utils.clamp(self.current_selecting, 1, self.max_selecting)
        if old_selected ~= self.current_selecting then
            self.ui_move:stop()
            self.ui_move:play()
        end
        if Input.isConfirm(key) then
            self:onButtonSelect(self.current_selecting)
        end
    end
end

return LightMenu