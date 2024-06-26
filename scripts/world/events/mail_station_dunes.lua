local MailStation, super = Class(Event)

function MailStation:init(data)
    super.init(self, data.center_x, data.center_y, data.width, data.height)

    self.solid = true
    self:setOrigin(0.5, 1)
    self:setSprite("world/events/mail_station/dunes_1")
end

function MailStation:onInteract(chara, dir)
    Game.world:startCutscene(function(cutscene)
        Assets.playSound("mail_jingle_dunes")
        self:setSprite("world/events/mail_station/dunes", 0.1)
        cutscene:wait(0.8)
        self:setSprite("world/events/mail_station/dunes_1")
        cutscene:text("* But nobody came.")
    end)
    return true
end

return MailStation