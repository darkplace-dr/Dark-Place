function Mod:addWrongWrapResuceHooks()
    --[[
    Utils.hook(World, "setupMap", function(orig, self, map, ...)
        for _,child in ipairs(self.children) do
            if not child.persistent then
                self:removeChild(child)
            end
        end
        for _,child in ipairs(self.controller_parent.children) do
            if not child.persistent then
                self.controller_parent:removeChild(child)
            end
        end

        self:updateChildList()

        self.healthbar = nil
        self.followers = {}

        self.camera:resetModifiers(true)
        self.camera:setAttached(true)

        if isClass(map) then
            self.map = map
        elseif type(map) == "string" then
            if not Registry.getMap(map) and not Registry.getMapData(map) then
                error("fuck")
            else
                self.map = Registry.createMap(map, self, ...)
            end
        elseif type(map) == "table" then
            self.map = Map(self, map, ...)
        else
            self.map = Map(self, nil, ...)
        end

        self.map:load()

        local dark_transitioned = self.map.light ~= Game:isLight()

        Game:setLight(self.map.light)

        self.width = self.map.width * self.map.tile_width
        self.height = self.map.height * self.map.tile_height

        --self.camera:setBounds(0, 0, self.map.width * self.map.tile_width, self.map.height * self.map.tile_height)

        self.battle_fader = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
        self.battle_fader:setParallax(0, 0)
        self.battle_fader:setColor(0, 0, 0)
        self.battle_fader.alpha = 0
        self.battle_fader.layer = self.map.battle_fader_layer
        self.battle_fader.debug_select = false
        self:addChild(self.battle_fader)

        self.in_battle = false
        self.in_battle_area = false
        self.battle_alpha = 0

        local map_border = self.map:getBorder(dark_transitioned)
        if map_border then
            Game:setBorder(map_border)
        end

        if not self.map.keep_music then
            self:transitionMusic(Kristal.callEvent("onMapMusic", self.map, self.map.music) or self.map.music)
        end
    end)

    Utils.hook(World, "mapTransition", function(orig, self, ...)
        local args = {...}
        local map = args[1]
        if type(map) == "string" then
            if not Registry.getMap(map) and not Registry.getMapData(map) then
                local xp = XPWindow()
                if Game.world.cutscene then
                    Game.world:stopCutscene()
                end
                Game.lock_movement = false
                Game.world:loadMap("warphub")
                return
            else
                local map = Registry.createMap(map)
                if not map.keep_music then
                    self:transitionMusic(Kristal.callEvent("onMapMusic", self.map, self.map.music) or map.music, true)
                end
                local dark_transition = map.light ~= Game:isLight()
                local map_border = map:getBorder(dark_transition)
                if map_border then
                    Game:setBorder(map_border, 1)
                end
            end
        end
        self:fadeInto(function()
            self:loadMap(Utils.unpack(args))
        end)
    end)
    ]]
end