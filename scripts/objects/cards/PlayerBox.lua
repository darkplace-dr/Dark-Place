local PlayerBox, super = Class(Object)

function PlayerBox:init(x, y)
    super:init(self, x, y)

    self.animation_timer = 0
    self.selection_siner = 0

    self.index = index
    self.battler = battler

    self.selected_button = 1

    self.revert_to = 40

    self.data_offset = 0

    self.box = PlayerBoxDisplay(self)
    self.box.layer = 1
    self:addChild(self.box)

    self.head_offset_x = 2
	self.head_offset_y = -1

    self.head_sprite = Sprite(Game.party[1].head_icons .. "/head", 13 + self.head_offset_x, 11 + self.head_offset_y)

    self.name_sprite = Sprite(Game.party[1].name_sprite, 51, 14)
    self.box:addChild(self.name_sprite)

    self.hp_sprite   = Sprite("ui/hp", 109, 22)

    self.box:addChild(self.head_sprite)
    self.box:addChild(self.hp_sprite)
end

function PlayerBox:draw()

    super:draw(self)
end

return PlayerBox