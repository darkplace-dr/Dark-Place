---@class Map
local Map, super = Class("Map", true)

function Map:init(world, data)
    self.world = world or Game.world

    self.data = data

    if data and data.full_path then
        local map_path = data.full_path
        map_path = Utils.split(map_path, "/")
        map_path = table.concat(map_path, "/", 1, #map_path - 1)
        self.full_map_path = map_path
    else
        self.full_map_path = Mod and Mod.info.path or ""
    end

    self.tile_width = data and data.tilewidth or 40
    self.tile_height = data and data.tileheight or 40
    self.width = data and data.width or 16
    self.height = data and data.height or 12

    self.name = data and data.properties and data.properties["name"]

    self.music = data and data.properties and data.properties["music"]
    self.keep_music = data and data.properties and data.properties["keepmusic"]

    self.light = data and data.properties and data.properties["light"] or false

    self.border = data and data.properties and data.properties["border"]

    if data and data.backgroundcolor then
        local bgc = data.backgroundcolor
        self.bg_color = {bgc[1]/255, bgc[2]/255, bgc[3]/255, (bgc[4] or 255)/255}
    else
        self.bg_color = {0, 0, 0, 0}
    end

    self.tilesets = {}
    self.tileset_gids = {}
    self.max_gid = 0

    self.collision = {}
    self.enemy_collision = {}
    self.block_collision = {}
	self.stone_collision = {}
    self.tile_layers = {}
    self.image_layers = {}
    self.shape_layers = {}
    self.markers = {}
    self.battle_areas = {}
    self.battle_borders = {}
    self.paths = {}

    self.events = {}
    self.events_by_name = {}
    self.events_by_id = {}
	self.events_by_layer = {}

    self.shapes_by_id = {}
    self.shapes_by_name = {}

    self.hitboxes_by_id = {}
    self.hitboxes_by_name = {}

    if data then
        self:populateTilesets(data.tilesets or {})
    end

    self.depth_per_layer = 0.1 -- its not perfect, but i doubt anyone will have 1000 layers
    self.next_layer = self.depth_per_layer

    self.next_object_id = 0

    self.object_layer = 1
    self.battle_fader_layer = 0.5
    self.tile_layer = 0
    self.layers = {}

    self.timer = Timer()

    self.omori = data and data.properties and data.properties["omori"] or false
    self.use_footstep_sounds = data and data.properties and data.properties["use_footstep_sounds"] or false
end

function Map:onEnter()
    super.onEnter(self)
    if Game.world.map.id:find("archives/") then
        self.voidbg = Game.world:spawnObject(VoidBGUT2())
        self.voidbg.layer = -9999
    elseif Game.world.map.id:find("cloudwebs/_ch1/") then
        self.fog = Game.world:spawnObject(TrueLabFog())
        self.fog.layer = WORLD_LAYERS["below_ui"]
    end
end

function Map:onExit()
    super.onExit(self)
    if Game.world.map.id:find("archives/") then
        self.voidbg:remove()
    elseif Game.world.map.id:find("cloudwebs/_ch1/") then
        self.fog:remove()
    end
end

function Map:loadLayer(layer, depth)
    if layer.type == "tilelayer" then
        self:loadTiles(layer, depth)
    elseif layer.type == "imagelayer" then
        self:loadImage(layer, depth)
    elseif layer.type == "objectgroup" then
        if Utils.startsWith(layer.name:lower(), "objects") then
            self:loadObjects(layer, depth, "events")
        elseif Utils.startsWith(layer.name:lower(), "controllers") then
            self:loadObjects(layer, depth, "controllers")
        elseif Utils.startsWith(layer.name:lower(), "markers") then
            self:loadMarkers(layer)
        elseif Utils.startsWith(layer.name:lower(), "collision") then
            self:loadCollision(layer)
        elseif Utils.startsWith(layer.name:lower(), "enemycollision") then
            self:loadEnemyCollision(layer)
        elseif Utils.startsWith(layer.name:lower(), "blockcollision") then
            self:loadBlockCollision(layer)
        elseif Utils.startsWith(layer.name:lower(), "stonecollision") then
            self:loadStoneCollision(layer)
        elseif Utils.startsWith(layer.name:lower(), "paths") then
            self:loadPaths(layer)
        elseif Utils.startsWith(layer.name:lower(), "battleareas") then
            self:loadBattleAreas(layer)
        end
        self:loadShapes(layer)
    end
end

function Map:loadStoneCollision(layer)
    Utils.merge(self.stone_collision, self:loadHitboxes(layer))
end

return Map
