local Costumes, super = Class(Object)

function Costumes:init()
    super.init(self, 0,0, SCREEN_WIDTH, SCREEN_HEIGHT)

    self.parallax_x = 0
    self.parallax_y = 0
    self.layer = WORLD_LAYERS["ui"]

    self.box = UIBox(80, 60, 480, 320)
    self.box.layer = -1
    self.box.debug_select = false
    self:addChild(self.box)

	self.font = Assets.getFont("main")
    self.char_gradient = Assets.getTexture("ui/char_gradient")

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

    self.costumes = {
        {
            name = "Kris",
            icon = Assets.getTexture("ui/partyselect/kris"),
            gradient_color = {0, 1, 1},
            sprite_base_path = "party/kris",
            skins = {
                {"DEFAULT", "dark", {0, 0}},
                {"LIGHT", "light", {0, 0}},
                {"MTT", "repainted", {0, 0}},
                {"RODEO", "rodeo", {-8, -8}}
            }
        },
        {
            name = "Susie",
            icon = Assets.getTexture("ui/partyselect/susie"),
            gradient_color = {1, 0.3, 1},
            sprite_base_path = "party/susie",
            skins = {
                {"DEFAULT", "dark", {-6, -12}},
                {"LIGHT", "light", {-6, -16}},
                {"DIO", "repainted", {-6, -12}},
                {"BANGS", "dark_ch1", {-6, -16}}
            }
        },
        {
            name = "Noelle",
            icon = Assets.getTexture("ui/partyselect/noelle"),
            gradient_color = {1, 1, 0},
            sprite_base_path = "party/noelle",
            skins = {
                {"DEFAULT", "dark", {-4, -18}},
                {"LIGHT", "light", {-4, -18}},
                {"ANTONYMPH", "antonymph", {-6, -18}}
            }
        },
        {
            name = "YOU",
            icon = Assets.getTexture("ui/partyselect/you"),
            gradient_color = {0, 1, 0},
            sprite_base_path = "party/you",
            skins = {
                {"DEFAULT", "dark", {-8, -6}},
                {"LIGHT", "light", {-4, -6}},
                {"DARK (OLD)", "old_dark", {0, 0}},
                {"LIGHT (OLD)", "old_light", {0, 0}},
                {"ALCHEMY", "alchemy", {-4, -6}}
            }
        },
        {
            name = "Dess",
            icon = Assets.getTexture("ui/partyselect/dess_lol"),
            gradient_color = {1, 0, 0},
            sprite_base_path = "party/dess",
            skins = {
                {"DEFAULT", "", {-12, -18}},
                {"FLIMBO", "", {-12, -18}},
                {"ELF", "elf", {-12, -16}}
            }
        },
        {
            name = "Brenda",
            icon = Assets.getTexture("ui/partyselect/brenda"),
            gradient_color = {0, 0, 1},
            sprite_base_path = "party/brenda",
            skins = {
                {"DEFAULT", "dark", {-4, -5}},
                {"BRENDA", "dark", {-4, -5}},
                {"LIGHT", "light", {-4, -5}},
            }
        },
        {
            name = "Bor",
            icon = Assets.getTexture("ui/partyselect/bor"),
            gradient_color = {113/255, 113/255, 231/255},
            sprite_base_path = "party/bor",
            skins = {
                {"DEFAULT", "dark", {-4, 40}},
                {"OLD", "dark_old", {-4, 40}}
            }
        },
        {
            name = "iPhone 7 Plus",
            icon = Assets.getTexture("ui/partyselect/iphone"),
            gradient_color = {198/255, 136/255, 132/255},
            sprite_base_path = "party/iphone",
            skins = {
                {"DEFAULT", "dark", {-8, -28}}
            }
        }
    }
end

function Costumes:draw()
    super.draw(self)

	love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(self.font)
    love.graphics.printf("COSTUMES", self.box.x, 50, self.box.width, "center")

	love.graphics.setColor(self.costumes[self.selected_index].gradient_color)
    love.graphics.draw(self.char_gradient, 100, 100)
	love.graphics.setColor(1, 1, 1)
	love.graphics.setLineWidth(2)
    love.graphics.rectangle("line", 100, 100, 200, 140)

    local cos = self.costumes[self.selected_index]

    local name_scale_x = math.min(200 / self.font:getWidth(cos.name), 1)
    love.graphics.print(cos.name, 100, 240, 0, name_scale_x, 1)

    for i, v in ipairs(cos.skins) do
        local skin_text_y = 95 + (i - 1) * 30
		love.graphics.print(v[1], 360, skin_text_y, 0, 1, 1)
    end

    local skin = cos.skins[self.skin_index]
    if skin then
        local type_name = skin[2]
        local type_path = type_name ~= "" and type_name.."/" or type_name
        local preview = Assets.getTexture(cos.sprite_base_path.."/"..type_path.."walk/down_1")
        love.graphics.draw(preview, 180 + skin[3][1], 150 + skin[3][2], 0, 2, 2)
    end

    for i, char in ipairs(self.costumes) do
        local icon_x = 125 + (i - 1) * 50
        love.graphics.setColor(1, 1, 1)
        if i ~= self.selected_index then
            love.graphics.setColor(1, 1, 1, 0.25)
        end
        love.graphics.draw(char.icon, icon_x, 330, 0, 1, 1)
    end
	love.graphics.setColor(1, 1, 1)
end

function Costumes:close()
    Game.world.menu = nil
    Game.world:startCutscene(function (cutscene)
    for _, party in ipairs(Game.party) do
        local pc = cutscene:getCharacter(party.actor.id)
        if cutscene:getCharacter(party.actor.id, 2) then -- compensate for duplicate actors in the party room
            pc = cutscene:getCharacter(party.actor.id, 2)
        end
        pc:resetSprite()
    end
    end) -- Does this need to be done in a cutscene? probably not, but resetSprite is a cutscene function, so I'm playing it safe.
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

    if Input.pressed("up") then
        Assets.playSound("ui_move")
        self.skin_index = self.skin_index - 1
    end
    if Input.pressed("down") then
        Assets.playSound("ui_move")
        self.skin_index = self.skin_index + 1
    end

    if Input.pressed("confirm") then
        Assets.playSound("ui_select")
        local cos = self.costumes[self.selected_index]
        local skin = cos.skins[self.skin_index]
        if cos.name == "YOU" then
            Game:setFlag(cos.name .. "_costume", self.skin_index - 1)
            local selmember = Game:getPartyMember(cos.name)
            selmember.actor.path = "party/you/" .. skin[2]:lower()
        else
            Game:setFlag(cos.name:lower() .. "_costume", self.skin_index - 1)
            local selmember = Game:getPartyMember(cos.name:lower())
            selmember.actor.path = "party/" .. selmember.actor.id .. "/" .. skin[2]:lower()

        end
    end
    self.skin_index = Utils.clamp(self.skin_index, 1, #self.costumes[self.selected_index].skins)

    self.heart_target_y = 112 + (self.skin_index - 1) * 30
    self.heart:setPosition(self.heart_target_x, self.heart_target_y)
end

return Costumes
