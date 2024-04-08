local EncounterZone, super = Class(Event, "encounterzone")

function EncounterZone:init(data)
    super.init(self)

    data = data or {}

    self.x = data.x
    self.y = data.y
    self.width = data.width
    self.height = data.height

    self.group = MagicalGlassLib:createRandomEncounter(data.properties["encgroup"])

    if MagicalGlassLib.steps_until_encounter == nil or MagicalGlassLib.steps_until_encounter < 0 then
        self.group:resetSteps()
    end

    local s = data.shape
    if s == "rectangle" or s == "circle" or s == "ellipse" or s == "polygon" or s == "polyline" then
        self.type = "zone"
        self.collider = Utils.colliderFromShape(self, data)
    else
        self.type = "map"
    end

    self.accepting = false
end

function EncounterZone:update()
    super.update(self)

    if Game.world.player and not Game.battle then
        if self.collider:collidesWith(Game.world.player) or self.type == "map" then
            self.accepting = true
        else
            self.accepting = false
        end
    end

    if MagicalGlassLib.steps_until_encounter <= 0 and self.accepting then
        self.group:resetSteps()
        self.group:start()
    end

end

function EncounterZone:onAddToStage(parent)
    MagicalGlassLib.encounters_enabled = true
    super.onAdd(self, parent)
end

function EncounterZone:onRemoveFromStage(stage)
    MagicalGlassLib.encounters_enabled = false
    super.onRemove(self, stage)
end

function EncounterZone:draw()
    super.draw(self)
    if DEBUG_RENDER and self.collider and Game.world.player and (self.collider:collidesWith(Game.world.player) or self.type == "map") then
        love.graphics.push()
        love.graphics.origin()

        love.graphics.print({{1,0,0},"Encounter Zone!",{1,1,0},"\nSteps Until Encounter: ",{1,1,1},MagicalGlassLib.steps_until_encounter}, 8, 0, 0, 1.25)

        love.graphics.pop()
    end
end

return EncounterZone