local Costumes, super = Class(Object)

function Costumes:init()
    super.init(self, 0,0, SCREEN_WIDTH, SCREEN_HEIGHT)

    self.parallax_x = 0
    self.parallax_y = 0
    self.layer = WORLD_LAYERS["ui"]

    self.box = UIBox(80, 60, 480, 320)
    self.box.layer = -1
    self:addChild(self.box)

	self.font = Assets.getFont("main")

    self.heart = Sprite("player/heart_menu")
    self.heart:setOrigin(0.5, 0.5)
	self.heart:setScale(2)
    self.heart:setColor(Game:getSoulColor())
    self.heart.layer = 100
    self:addChild(self.heart)

	self.heart_target_x = 330
	self.heart_target_y = 112
	self.heart:setPosition(self.heart_target_x, self.heart_target_y)

    self.selected_index = 1
    self.skin_index = 1

    self.char_box = Sprite("ui/char_gradient", 100, 100)
    self.char_box.color = {1, 1, 1}
    self:addChild(self.char_box)

    self.costumes = {
        {
            name = "Kris",
            icon = Assets.getTexture("ui/partyselect/kris"),
            color = {0, 1, 1},
            sprite_base_path = "party/kris",
            skins = {
                {"DEFAULT", "dark", {180, 150}},
                {"LIGHT", "light", {180, 150}},
                {"MTT", "repainted", {180, 150}},
                {"VESSEL", "dark", {180, 150}}
            }
        },
        {
            name = "Susie",
            icon = Assets.getTexture("ui/partyselect/susie"),
            color = {1, 0.3, 1},
            sprite_base_path = "party/susie",
            skins = {
                {"DEFAULT", "dark", {174, 138}},
                {"LIGHT", "light", {174, 134}},
                {"DIO", "repainted", {174, 138}}
            }
        },
        {
            name = "Noelle",
            icon = Assets.getTexture("ui/partyselect/noelle"),
            color = {1, 1, 0},
            sprite_base_path = "party/noelle",
            skins = {
                {"DEFAULT", "dark", {176, 132}},
                {"LIGHT", "light", {176, 132}},
                {"ANTONYMPH", "antonymph", {174, 132}}
            }
        },
        {
            name = "YOU",
            icon = Assets.getTexture("ui/partyselect/you"),
            color = {0, 0.5, 1},
            sprite_base_path = "party/you",
            skins = {
                {"DEFAULT", "dark", {172, 144}},
                {"LIGHT", "light", {176, 144}},
                {"DARK (OLD)", "old_dark", {180, 150}},
                {"LIGHT (OLD)", "old_light", {180, 150}}
            }
        },
        {
            name = "Dess",
            icon = Assets.getTexture("ui/partyselect/dess_lol"),
            color = {1, 0, 0},
            sprite_base_path = "party/dess",
            skins = {
                {"DEFAULT", "", {168, 132}},
                {"FLIMBO", "", {168, 132}}
            }
        },
        {
            name = "Brandon",
            icon = Assets.getTexture("ui/partyselect/brandon"),
            color = {0, 0, 1},
            sprite_base_path = "party/brandon",
            skins = {
                {"DEFAULT", "dark", {176, 145}},
                {"BRENDA", "dark", {176, 145}}
            }
        }
    }
end

function Costumes:draw()
    super.draw(self)

	love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(self.font)
    love.graphics.printf("COSTUMES", self.box.x, self.box.y, self.box.width, "center")

	love.graphics.setLineWidth(2)
    love.graphics.rectangle("line", 100, 100, 200, 140)

    local cos = self.costumes[self.selected_index]
    love.graphics.print(cos.name, 100, 235, 0, 0.5, 1)
    for i, v in ipairs(cos.skins) do
        local skin_text_y = 95 + (i - 1) * 30
		love.graphics.print(v[1], 360, skin_text_y, 0, 1, 1)
    end
    local skin = cos.skins[self.skin_index]
    if skin then
        local typeid = skin[2]
        local preview = Assets.getTexture(cos.sprite_base_path.."/"..(typeid ~= "" and typeid.."/" or typeid).."walk/down_1")
        love.graphics.draw(preview, skin[3][1], skin[3][2], 0, 2, 2)
    end

    for i, char in ipairs(self.costumes) do
        local icon_x = 170 + (i - 1) * 50
        love.graphics.setColor(1, 1, 1)
        if i ~= self.selected_index then
            love.graphics.setColor(1, 1, 1, 0.5)
        end
        love.graphics.draw(char.icon, icon_x, 330, 0, 1, 1)
    end
	love.graphics.setColor(1, 1, 1)
end

function Costumes:close()
    Game.world.menu = nil
    self:remove()
end

function Costumes:update()
    if Input.pressed("cancel") then
        Assets.playSound("ui_cancel_small")
        Game.world:closeMenu()
        return
    end

    if Input.pressed("left") then
        Assets.playSound("ui_move")
	    self.selected_index = self.selected_index - 1
        self.skin_index = 1
    end
    if Input.pressed("right") then
        Assets.playSound("ui_move")
	    self.selected_index = self.selected_index + 1
        self.skin_index = 1
    end
    self.selected_index = Utils.clamp(self.selected_index, 1, #self.costumes)
    self.char_box.color = self.costumes[self.selected_index].color

    if Input.pressed("up") then
        Assets.playSound("ui_move")
        self.skin_index = self.skin_index - 1
    end
    if Input.pressed("down") then
        Assets.playSound("ui_move")
        self.skin_index = self.skin_index + 1
    end
    self.skin_index = Utils.clamp(self.skin_index, 1, #self.costumes[self.selected_index].skins)

    self.heart_target_y = 112 + (self.skin_index - 1) * 30
    self.heart:setPosition(self.heart_target_x, self.heart_target_y)
end

return Costumes
