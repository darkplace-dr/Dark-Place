local Chair, super = Class(Event)

function Chair:init(data)
    super.init(self, data)

    self.sprite = Sprite("world/events/dark_chair/normal")
    self.sprite:setScale(2)
	self.sprite:setOrigin(0, 0)
    self:addChild(self.sprite)

    self.custom_cutscene = data.properties["cutscene"]

    self.solid = data.properties["solid"] or false
    self.darker = false
end

function Chair:onInteract(player, dir)
    if self.custom_cutscene then
        Game.world:startCutscene(self.custom_cutscene, self, player, dir)
    else
        Game.world:startCutscene(function(cutscene)
            if not self.darker then
                cutscene:text("* (But what if it could...)")
                self:setDarker(true)
                cutscene:text("* (get darker than dark?)")
            else
                self:setDarker(false)
            end
        end)
    end
    return true
end

function Chair:setDarker(bool, music)
    if music == nil then music = true end
    self.darker = bool
    if bool then
        self.sprite:setAnimation({"world/events/dark_chair/dark", 1/10, true})
        if music then
            Game.world.music:play("water")
        end
    else
        self.sprite:setSprite("world/events/dark_chair/normal")
        if music then
            Game.world.music:stop()
        end
    end
end

return Chair