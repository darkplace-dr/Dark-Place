local Goner, super = Class(ActorSprite)

function Goner:init(actor)
    super:init(self, actor)

    --facing = facing or self.facing

    --player = Game.world.player

    --[[self.body_0 = GonerPart("party/goner/torsos/body_0/light/walk/down", 0, 0, 0, 0)
    self.body_0.id = "body_0"
    self.body_0.layer = 0
    self:addChild(self.body_0)

    self.leg_0 = GonerPart("party/goner/legs/0_leg/light/walk/down", 0, 0, 0, 0)
    self.leg_0.id = "0_leg"
    self.leg_0.layer = -1
    self:addChild(self.leg_0)

    if Game:getFlag("head_0") then
        self.head_0 = GonerPart("party/goner/heads/0_head/light/walk/down", 0, 0, 0, 0)
        self.head_0.id = "0_head"
        self.head_0.layer = -1
        self:addChild(self.head_0)
    end



    --Game.world.player:setSprite("run/"..Game.world.player.facing.."_ready")


    if actor.facing == "right" then
        self.head_0r = GonerPart("party/goner/heads/0_head/light/walk/right", 0, 0, 0, 0)
        self.head_0r.id = "0_headr"
        self.head_0r.layer = -1
        self:addChild(self.head_0r)
    end

    if Game:getFlag("head_1") then
        self.head_1 = GonerPart("party/goner/heads/1_head/light/walk/down", 0, 0, 0, 0)
        self.head_1.id = "1_head"
        self.head_1.layer = -1
        self:addChild(self.head_1)
    end

    self.battle_body = GonerPart("party/goner/legs/0_leg/light/walk/down", 0, 0, 0, 0)
    self.battle_body.id = "battle_body"
    self.battle_body.layer = -1
    self:addChild(self.battle_body)



    --[[self.leg_l = GonerPart("npcs/spamton/leg_l", 0, 0, 0, 0)
    self.leg_l.id = "leg_l"
    self.leg_l.layer = -10
    self:addChild(self.leg_l)

    self.leg_r = GonerPart("npcs/spamton/leg_r", 25, 48, 0.5, 0)
    self.leg_r.id = "leg_r"
    self.leg_r.layer = -10
    self:addChild(self.leg_r)

    self.arm_l = GonerPart("npcs/spamton/arm_l", 16, 27, 0, 0.5, math.pi/2)
    self.arm_l.id = "arm_l"
    self.arm_l.layer = -12
    self:addChild(self.arm_l)

    self.arm_r = GonerPart("npcs/spamton/arm_r", 33, 25, 0, 1, math.pi/2)
    self.arm_r.id = "arm_r"
    self.arm_r.layer = -4
    self:addChild(self.arm_r)

    self.wing_l = GonerPart("npcs/spamton/wing_l", 0, 4, 1, 0.5)
    self.wing_l.id = "wing_l"
    self.wing_l.layer = -15
    self:addChild(self.wing_l)

    self.wing_r = GonerPart("npcs/spamton/wing_r", 27, 0, 0, 0.5)
    self.wing_r.id = "wing_r"
    self.wing_r.layer = 5
    self:addChild(self.wing_r)]]



    -- deltarune adds these parts in a very specific order which apparently influences swing speed
    --[[self.parts = {
        self.body
    }]]




    self.timer = Timer()
    self:addChild(self.timer)
end

-- heck it, custom version
function Goner:setAnimation(anim, ...)
    if not ignore_actor then
        self.actor:onSetAnimation(self, anim, ...)
    end
end

function Goner:getPart(name)
    if isClass(name) then
        return name
    elseif self[name] then
        return self[name]
    else
        error("Part does not exist: "..name)
    end
end

function Goner:getPartIndex(part)
    if type(part) == "string" then
        part = self:getPart(part)
    end
    for i,other in ipairs(self.parts) do
        if other == part then
            return i
        end
    end
end

function Goner:setPartSprite(name, path)
    local part = self:getPart(name)
    part:setSprite(path)
end



return Goner