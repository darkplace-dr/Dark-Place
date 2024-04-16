local VoidWanderer, super = Class(EnemyBattler)

function VoidWanderer:init()
    super.init(self)

    self.name = "Void Wanderer"
    self:setActor("voidwanderer")

    self.path = "battle/enemies/voidwanderer"
    self.default = "battle"
    self:setAnimation("battle")

    self.max_health = 1500
    self.health = 1500
    self.attack = 10
    self.defense = 2
    self.money = 100
    self.experience = 35

    self.spare_points = 0

    self.disable_mercy = true
    self.service_mercy = 0

    self.tired_percentage = 0.25

    self.waves = {
        "void_starstorm",
        "void_goopspray"
    }

    self.dialogue = {
        "..."
    }

    self.check = "AT 10 DF 2\n* Otherworldly foe that cannot be spared."

    self.text = {
        "* Void Wanderer floats about.",
        "* The air feels thick.",
        "* Smells like cosmic microwaves.",
    }
    self.low_health_text = "* Void Wanderer starts to dissipate"

    self:registerAct("Entrance")
end

function VoidWanderer:onAct(battler, name)
    if name == "Entrance" then
        self:addTired(20)
        return "* You spun your weapon around.\n* Void Wanderer got more tired."
    elseif name == "Standard" then --X-Action
        self:addTired(20)
        if battler.chara.id == "dess" then
            return "* Dess spun her bat around.\n* Void Wanderer got more tired."
		elseif battler.chara.id == "jamm" then
            return "* Jam spun his sling around.\n* Void Wanderer got more tired."
        else
            return "* "..battler.chara:getName().." spun their weapon around.\n* Void Wanderer got more tired."
        end
    end

    return super.onAct(self, battler, name)
end

function VoidWanderer:update()
    super.update(self)

    if self.tired == true and self.tired_animation ~= true then
        self:setAnimation("tired")
        self.tired_animation = true
    end
end

return VoidWanderer