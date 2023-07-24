---@class DarkMenu : Object
---@overload fun(...) : DarkMenu
local DarkMenu, super = Class("DarkMenu", true)

function DarkMenu:init()
    super.init(self)


    self.badge_button = #self.buttons + 1

    self.desc_sprites[self.badge_button] = Assets.getTexture("ui/menu/desc/badge")

    self.buttons[self.badge_button] = {
        Assets.getTexture("ui/menu/btn/badge"),
        Assets.getTexture("ui/menu/btn/badge_h")
    }

    self.button_offset = 72
end

function DarkMenu:onButtonSelect(button)
    if button == self.badge_button then
        self.state = "BADGEMENU"

        Input.clear("confirm")
        self.box = DarkBadgeMenu()
        self.box.layer = 1
        self:addChild(self.box)

        self.ui_select:stop()
        self.ui_select:play()

        return
    end

    super.onButtonSelect(self, button)
end

return DarkMenu