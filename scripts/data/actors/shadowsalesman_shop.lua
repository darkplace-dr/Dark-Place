local actor, super = Class(Actor, "shadowsalesman_shop")

function actor:init()
    super.init(self)

    self.name = "Shadow Salesman"

    self.width = 123
    self.height = 120

    self.path = "shopkeepers/shadow_salesman"
    self.default = "idle"

    self.voice = "shadowsalesman"

    self.animations = {
        ["idle"] = {"idle", function(sprite, wait)
            while true do
                sprite:setFrame(1)
                wait(2)
                for i = 2, 6 do
                    sprite:setFrame(i)
                    wait(5/30)
                end
            end
        end},
        ["annoyed"] = {"annoyed", 1, true},
        ["eyebrow_raise"] = {"eyebrow_raise", 1, true},
    }

    self.talk_sprites = {
        ["talk"] = 0.2,
        ["happy"] = 0.2
    }
end

function actor:onTalkStart(text, sprite)
    if sprite.sprite == "idle" then
        sprite:setSprite("talk")
    end
end

function actor:onTalkEnd(text, sprite)
    if sprite.sprite == "talk" then
        sprite:setAnimation("idle")
    end
end

return actor