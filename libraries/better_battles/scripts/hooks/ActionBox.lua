---@class ActionBox
---@overload fun(...) : ActionBox
local ActionBox, super = Class(ActionBox)

function ActionBox:createButtons()
    for _,button in ipairs(self.buttons or {}) do
        button:remove()
    end

    self.buttons = {}

    local btn_types = {"fight", "act", "magic", "item", "spare", "defend"}
	
	if self.battler.chara:hasSkills() and Kristal.getLibConfig("better_battles", "skill_button") then
		btn_types = {"fight", "skill", "item", "spare", "defend"}
	else
		if not self.battler.chara:hasAct() then Utils.removeFromTable(btn_types, "act") end
		if not self.battler.chara:hasSpells() then Utils.removeFromTable(btn_types, "magic") end
	end

    for lib_id,_ in pairs(Mod.libs) do
        btn_types = Kristal.libCall(lib_id, "getActionButtons", self.battler, btn_types) or btn_types
    end
    btn_types = Kristal.modCall("getActionButtons", self.battler, btn_types) or btn_types

    local start_x = (213 / 2) - ((#btn_types-1) * 35 / 2) - 1

    if (#btn_types <= 6) and Game:getConfig("oldUIPositions") then
        start_x = 30
    end

    for i,btn in ipairs(btn_types) do
        if type(btn) == "string" then
            local button = ActionButton(btn, self.battler, math.floor(start_x + ((i - 1) * 35)) + 0.5, 21)
            button.actbox = self
            table.insert(self.buttons, button)
            self:addChild(button)
        else
            btn:setPosition(math.floor(start_x + ((i - 1) * 35)) + 0.5, 21)
            btn.battler = self.battler
            btn.actbox = self
            table.insert(self.buttons, btn)
            self:addChild(btn)
        end
    end

    self.selected_button = Utils.clamp(self.selected_button, 1, #self.buttons)
end

return ActionBox