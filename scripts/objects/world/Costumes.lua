local Costumes, super = Class(Object)

function Costumes:init()
    super:init(self, 0,0, SCREEN_WIDTH,SCREEN_HEIGHT)

    self.parallax_x = 0
    self.parallax_y = 0
	
	self.layer = 100
	
    self.box1 = UIBox(80, 60, 480, 320)
    self.box1.layer = -1
    self:addChild(self.box1)
	
	self.font = Assets.getFont("menu")

	self.costumes_title = "COSTUMES"
	
	self.costumes_text = Text(self.costumes_title, 325, 50, 300, 500, {style = "menu"})
	local costumes_text_obj = love.graphics.newText(self.costumes_text:getFont(), self.costumes_title)
    self.costumes_text.x = 325 - Utils.round(costumes_text_obj:getWidth()/2)
    self.costumes_text.layer = 1
    self:addChild(self.costumes_text)
	
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

    --SELECT, PARTYSELECT
    self.state = "SELECT"
	
    self.char_box = Sprite("ui/char_gradient", 100, 100)
    self.char_box.color = {1, 1, 1}
    self:addChild(self.char_box)

    self.costumes = {
        [1] = {
            name = "Kris",
            skin1 = "DEFAULT",
            skin2 = "LIGHT",
            skin3 = "MTT",
            skin4 = "VESSEL"
        },
        [2] = {
            name = "Susie",
            skin1 = "DEFAULT",
            skin2 = "LIGHT",
            skin3 = "DIO"
        },
        [3] = {
            name = "Noelle",
            skin1 = "DEFAULT",
            skin2 = "LIGHT",
        },
        [4] = {
            name = "YOU",
            skin1 = "DEFAULT",
            skin2 = "LIGHT",
            skin3 = "DARK 2.0",
            skin4 = "LIGHT 2.0"
        },
        [5] = {
            name = "Dess",
            skin1 = "DEFAULT",
            skin2 = "FLIMBO"
        },
    }
end

function Costumes:draw()
    super:draw(self)
	love.graphics.setLineWidth(2)
	love.graphics.setColor(1, 1, 1)
	
    char_icon1 = Assets.getTexture("ui/partyselect/kris")
    char_icon2 = Assets.getTexture("ui/partyselect/susie")
    char_icon3 = Assets.getTexture("ui/partyselect/noelle")
    char_icon4 = Assets.getTexture("ui/partyselect/you")
    char_icon5 = Assets.getTexture("ui/partyselect/dess_lol")
	
    love.graphics.rectangle("line", 100, 100, 200, 140)
	
    love.graphics.draw(char_icon1, 190, 330, 0, 1, 1)
    love.graphics.draw(char_icon2, 240, 330, 0, 1, 1)
    love.graphics.draw(char_icon3, 290, 330, 0, 1, 1)
    love.graphics.draw(char_icon4, 340, 330, 0, 1, 1)
    love.graphics.draw(char_icon5, 390, 330, 0, 1, 1)
	
-- Kris
	
    if self.selected_index == 1 then
        love.graphics.setColor(1, 1, 1)
		love.graphics.print(self.costumes[1].name, 100, 235, 0, 0.5, 1)
		love.graphics.print(self.costumes[1].skin1, 360, 95, 0, 1, 1)
		love.graphics.print(self.costumes[1].skin2, 360, 125, 0, 1, 1)
		love.graphics.print(self.costumes[1].skin3, 360, 155, 0, 1, 1)
		love.graphics.print(self.costumes[1].skin4, 360, 185, 0, 1, 1)
    end
    if self.selected_index == 1 and self.skin_index == 1 then
        preview = Assets.getTexture("party/kris/dark/walk/down_1")
        love.graphics.draw(preview, 180, 150, 0, 2, 2)
    end
    if self.selected_index == 1 and self.skin_index == 2 then
        preview = Assets.getTexture("party/kris/light/walk/down_1")
        love.graphics.draw(preview, 180, 150, 0, 2, 2)
    end
    if self.selected_index == 1 and self.skin_index == 3 then
        preview = Assets.getTexture("party/kris/repainted/walk/down_1")
        love.graphics.draw(preview, 180, 150, 0, 2, 2)
    end
    if self.selected_index == 1 and self.skin_index == 4 then
        preview = Assets.getTexture("party/kris/dark/walk/down_1")
        love.graphics.draw(preview, 180, 150, 0, 2, 2)
    end
	
--Susie
	
    if self.selected_index == 2 then
        love.graphics.setColor(1, 1, 1)
		love.graphics.print(self.costumes[2].name, 100, 235, 0, 0.5, 1)
		love.graphics.print(self.costumes[2].skin1, 360, 95, 0, 1, 1)
		love.graphics.print(self.costumes[2].skin2, 360, 125, 0, 1, 1)
		love.graphics.print(self.costumes[2].skin3, 360, 155, 0, 1, 1)
    end
	
    if self.selected_index == 2 and self.skin_index == 1 then
        preview = Assets.getTexture("party/susie/dark/walk/down_1")
        love.graphics.draw(preview, 174, 138, 0, 2, 2)
    end
    if self.selected_index == 2 and self.skin_index == 2 then
        preview = Assets.getTexture("party/susie/light/walk/down_1")
        love.graphics.draw(preview, 174, 134, 0, 2, 2)
    end
    if self.selected_index == 2 and self.skin_index == 3 then
        preview = Assets.getTexture("party/susie/repainted/walk/down_1")
        love.graphics.draw(preview, 174, 138, 0, 2, 2)
    end
    if self.selected_index == 2 and self.skin_index == 4 then
        preview = Assets.getTexture("party/kris/repainted/walk/down_1")
        love.graphics.draw(preview, 180, 150, 0, 2, 2)
    end
	
-- Noelle
	
    if self.selected_index == 3 then
        love.graphics.setColor(1, 1, 1)
		love.graphics.print(self.costumes[3].name, 100, 235, 0, 0.5, 1)
		love.graphics.print(self.costumes[3].skin1, 360, 95, 0, 1, 1)
		love.graphics.print(self.costumes[3].skin2, 360, 125, 0, 1, 1)
    end
    if self.selected_index == 3 and self.skin_index == 1 then
        preview = Assets.getTexture("party/noelle/dark/walk/down_1")
        love.graphics.draw(preview, 176, 132, 0, 2, 2)
    end
    if self.selected_index == 3 and self.skin_index == 2 then
        preview = Assets.getTexture("party/noelle/light/walk/down_1")
        love.graphics.draw(preview, 176, 132, 0, 2, 2)
    end
	
-- YOU
	
    if self.selected_index == 4 then
        love.graphics.setColor(1, 1, 1)
		love.graphics.print(self.costumes[4].name, 100, 235, 0, 0.5, 1)
		love.graphics.print(self.costumes[4].skin1, 360, 95, 0, 1, 1)
		love.graphics.print(self.costumes[4].skin2, 360, 125, 0, 1, 1)
		love.graphics.print(self.costumes[4].skin3, 360, 155, 0, 1, 1)
		love.graphics.print(self.costumes[4].skin4, 360, 185, 0, 1, 1)
    end
	
    if self.selected_index == 4 and self.skin_index == 1 then
        preview = Assets.getTexture("party/you/dark/walk/down_1")
        love.graphics.draw(preview, 180, 150, 0, 2, 2)
    end
    if self.selected_index == 4 and self.skin_index == 2 then
        preview = Assets.getTexture("party/you/light/walk/down_1")
        love.graphics.draw(preview, 180, 150, 0, 2, 2)
    end
    if self.selected_index == 4 and self.skin_index == 3 then
        preview = Assets.getTexture("party/you/new_dark/walk/down_1")
        love.graphics.draw(preview, 172, 144, 0, 2, 2)
    end
    if self.selected_index == 4 and self.skin_index == 4 then
        preview = Assets.getTexture("party/you/new_light/walk/down_1")
        love.graphics.draw(preview, 176, 144, 0, 2, 2)
    end
	
-- Dess
	
    if self.selected_index == 5 then
        love.graphics.setColor(1, 1, 1)
		love.graphics.print(self.costumes[5].name, 100, 235, 0, 0.5, 1)
		love.graphics.print(self.costumes[5].skin1, 360, 95, 0, 1, 1)
		love.graphics.print(self.costumes[5].skin2, 360, 125, 0, 1, 1)
    end
	
    if self.selected_index == 5 and self.skin_index == 1 then
        preview = Assets.getTexture("party/dess/walk/down_1")
        love.graphics.draw(preview, 168, 132, 0, 2, 2)
    end
end

function Costumes:close()
    Game.world.menu = nil
    self:remove()
end

function Costumes:update()
    -- up
    if Input.pressed("up") then
        Assets.playSound("ui_move")
        self.skin_index = self.skin_index - 1
    end
	
    -- down
    if Input.pressed("down") then
        Assets.playSound("ui_move")
        self.skin_index = self.skin_index + 1
    end
	
    --party select left
    if Input.pressed("left") then
        Assets.playSound("ui_move")
	    self.selected_index = self.selected_index - 1
        self.skin_index = 1
    end
	
    --party select right
    if Input.pressed("right") then
        Assets.playSound("ui_move")
	    self.selected_index = self.selected_index + 1
        self.skin_index = 1
    end
	
    -- close menu
    if Input.pressed("cancel") then
        Assets.playSound("ui_cancel_small")
        Game.world:closeMenu()
    end

	--soul positions
    if self.skin_index == 1 then
		self.heart:setPosition(self.heart_target_x, 112)
	end
	if self.skin_index == 2 then
		self.heart:setPosition(self.heart_target_x, 142)
	end
	if self.skin_index == 3 then
		self.heart:setPosition(self.heart_target_x, 172)
    end
	if self.skin_index == 4 then
		self.heart:setPosition(self.heart_target_x, 202)
    end
    if self.skin_index > 4 then
        self.skin_index = 1
    end
    if self.skin_index < 1 then
	    self.skin_index = 4
    end
	
    --change color
    if self.selected_index == 1 then
	    self.char_box.color = {0, 1, 1}
    end

    if self.selected_index == 2 then
	    self.char_box.color = {1, 0.3, 1}
    end
	
    if self.selected_index == 3 then
	    self.char_box.color = {1, 1, 0}
    end
	
    if self.selected_index == 4 then
	    self.char_box.color = {0, 0.5, 1}
    end

    if self.selected_index == 5 then
	    self.char_box.color = {1, 0, 0}
    end
	
	
	
    --party select right
    if self.selected_index > #self.costumes then
        self.selected_index = 1
    end

    --party select left
	if self.selected_index < 1 then
        self.selected_index = #self.costumes
    end
end

return Costumes