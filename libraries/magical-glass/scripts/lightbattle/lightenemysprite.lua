local LightEnemySprite, super = Class(Object)

function LightEnemySprite:init(actor)
    if type(actor) == "string" then
        actor = Registry.createActor(actor)
    end

    super.init(self)

    self.actor = actor
    self.parts = self.actor.light_battler_parts
    
    for _,part in pairs(self.parts) do
        if part.init then
            part:init(part)
        end
    end

    if actor then
        actor:onSpriteInit(self)
    end

    self:resetSprite()
end

function LightEnemySprite:setActor(actor)
    if type(actor) == "string" then
        actor = Registry.createActor(actor)
    end

    if self.actor and self.actor.id == actor.id then
        return
    end

    for _,child in ipairs(self.children) do
        self:removeChild(child)
    end

    self.actor = actor
    self.parts = self.actor.light_battler_parts

    self.width = actor:getWidth()
    self.height = actor:getHeight()
    self.path = actor:getSpritePath()

    actor:onSpriteInit(self)
    self:resetSprite()

end

function LightEnemySprite:resetSprite(ignore_actor_callback)
    if not ignore_actor_callback and self.actor:preResetSprite(self) then
        return
    end

    for _,child in ipairs(self.children) do
        self:removeChild(child)
    end

    for _,part in pairs(self.parts) do
        if part.sprite and type(part.sprite) == "function" then
            error("LightEnemyBattler sprite parts are now created in \"create_sprite\" instead of \"sprite.\"")
        end
        part.sprite = nil

        if part.create_sprite then
            if type(part.create_sprite) == "string" then
                part.sprite = Sprite(part.create_sprite)
            elseif type(part.create_sprite) == "function" then
                if type(part.create_sprite()) == "string" then
                    part.sprite = Sprite(part.create_sprite())
                elseif part.create_sprite():includes(Sprite) then
                    part.sprite = part:create_sprite()
                end
            end
            self:addChild(part.sprite)
        else
            if self.actor:getDefaultAnim() then
                part.sprite = Sprite(self.actor.path .. "/" .. self.actor:getDefaultAnim())
            elseif self.actor:getDefaultSprite() then
                part.sprite = Sprite(self.actor.path .. "/" .. self.actor:getDefaultSprite())
            else
                part.sprite = Sprite(self.actor.path .. "/" .. self.actor:getDefault())
            end
            self:addChild(part.sprite)
        end
    end

    self.actor:onResetSprite(self)
end

function LightEnemySprite:getPart(part_id)
    return self.parts[part_id]
end

function LightEnemySprite:update()
    for _,part in pairs(self.parts) do
        if part.update then
            part:update(part)
        end
    end

    super.update(self)

    self.actor:onSpriteUpdate(self)
end

return LightEnemySprite