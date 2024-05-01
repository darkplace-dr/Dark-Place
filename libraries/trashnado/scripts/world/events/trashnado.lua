local Trashnado, super = Class(Event)

function Trashnado:init(x, y, w, h, properties)
    super.init(self, x, y, w, h)

    properties = properties or {}
	
    self.no_dog = properties["no_dog"] or false -- serves as a replacement for the "if (global.flag[497] < 2)" thing that was in the original code
	
    self.siner1 = 0
    self.siner2 = 120
    self.siner3 = 240
    self.siner4 = 0
    self.siner5 = 120
    self.sinerx = 0
	
    self.trash1 = {}
    self.trash2 = {}
    self.trash3 = {}
    self.trash4 = {}
    self.trash5 = {}
	
    self.tspr1 = {}
    self.tspr2 = {}
    self.tspr3 = {}
    self.tspr4 = {}
    self.tspr5 = {}

    for i = 0,4-1 do
        self.tspr1[i] = Utils.pick{"world/events/trashnado/trash_paperball", "world/events/trashnado/trash_dustorb"}
        self.trash1[i] = Sprite(self.tspr1[i])
        self.trash1[i]:setScale(2)
        self.trash1[i]:setOrigin(0.5, 0.5)
        self:addChild(self.trash1[i])
    end
    for i = 0,4-1 do
        self.tspr2[i] = Utils.pick{"world/events/trashnado/trash_paperball", "world/events/trashnado/trash_dustorb"}
        self.trash2[i] = Sprite(self.tspr2[i])
        self.trash2[i]:setScale(2)
        self.trash2[i]:setOrigin(0.5, 0.5)
        self:addChild(self.trash2[i])
    end
    for i = 0,4-1 do
        self.tspr3[i] = Utils.pick{"world/events/trashnado/trash_paperball", "world/events/trashnado/trash_dustorb", "world/events/trashnado/trash_paperball", "world/events/trashnado/notepaper"}
        self.trash3[i] = Sprite(self.tspr3[i])
        self.trash3[i]:setScale(2)
        self.trash3[i]:setOrigin(0.5, 0.5)
        self:addChild(self.trash3[i])
    end
    for i = 0,4-1 do
        self.tspr4[0] = "world/events/trashnado/trash_paperball"
        self.tspr4[1] = "world/events/trashnado/book"
        self.tspr4[2] = "world/events/trashnado/spaghettialone"
        self.trash4[i] = Sprite(self.tspr4[i])
        self.trash4[i]:setScale(2)
        self.trash4[i]:setOrigin(0.5, 0.5)
        self:addChild(self.trash4[i])
    end
    for i = 0,4-1 do
        if self.no_dog == true then
            self.tspr5[0] = "world/events/trashnado/trash_paperball"
            self.tspr5[1] = "world/events/trashnado/book"
            self.tspr5[2] = "world/events/trashnado/trash_takeout"
        else
            self.tspr5[0] = "world/events/trashnado/trash_paperball"
            self.tspr5[2] = "world/events/trashnado/trash_takeout"
            self.tspr5[1] = Utils.pick{"world/events/trashnado/trash_takeout", "world/events/trashnado/trash_paperball", "world/events/trashnado/book", "misc/dog_sleep"}
        end
        self.trash5[i] = Sprite(self.tspr5[i])
        self.trash5[i]:play(0.2, true)
        self.trash5[i]:setScale(2)
        self.trash5[i]:setOrigin(0.5, 0.5)
        self:addChild(self.trash5[i])
    end

    self:setHitbox(-20, 0, 40, 20)
    self.solid = true
end

function Trashnado:update()
    super.update(self)
	
    self.siner1 = self.siner1 + 20 * DTMULT
    self.siner2 = self.siner2 - 20 * DTMULT
    self.siner3 = self.siner3 + 20 * DTMULT
    self.siner4 = self.siner4 - 20 * DTMULT
    self.siner5 = self.siner5 + 20 * DTMULT
    self.sinerx = self.sinerx + DTMULT

    self.rr = 3
    for i = 0,4-1 do
        self.trash1[i].x = (((math.sin(math.rad((self.siner1 + (120 * i)))) * self.rr) * 2) + math.sin((self.sinerx / 2)))
        self.trash1[i].y = (((((math.cos(math.rad((self.siner1 + (120 * i)))) * self.rr) / 3)) * 2) + math.cos((self.sinerx / 2)))
    end

    self.rr = 6
    for i = 0,4-1 do
        self.trash2[i].x = (((math.sin(math.rad((self.siner2 + (120 * i)))) * self.rr) * 2) - math.sin((self.sinerx / 2)))
        self.trash2[i].y = ((((((math.cos(math.rad((self.siner2 + (120 * i)))) * self.rr) / 3)) - 12) * 2) - math.cos((self.sinerx / 2)))
    end

    self.rr = 10
    for i = 0,4-1 do
        self.trash3[i].x = (((math.sin(math.rad((self.siner3 + (120 * i)))) * self.rr) * 2) + math.sin((self.sinerx / 2)))
        self.trash3[i].y = ((((((math.cos(math.rad((self.siner3 + (120)))) * self.rr) / 3)) - 24) * 2) + math.cos((self.sinerx / 2)))
    end

    self.rr = 13
    for i = 0,4-1 do
        self.trash4[i].x = (((math.sin(math.rad((self.siner4 + (120 * i)))) * self.rr) * 2) - math.sin((self.sinerx / 2)))
        self.trash4[i].y = ((((((math.cos(math.rad((self.siner4 + (120 * i)))) * self.rr) / 3)) - 36) * 2) - math.cos((self.sinerx / 2)))
    end

    self.rr = 16
    for i = 0,4-1 do
        self.trash5[i].x = (((math.sin(math.rad((self.siner5 + (120 * i)))) * self.rr) * 2) + math.sin((self.sinerx / 2)))
        self.trash5[i].y = ((((((math.cos(math.rad((self.siner5 + (120 * i)))) * self.rr) / 3)) - 48) * 2)+ math.cos((self.sinerx / 2)))
    end
end

function Trashnado:onInteract(player, dir)
    Game.world:startCutscene(function(cutscene)
        cutscene:text("* (It appears to be a self-\nsustaining tornado made of\ntrash.)")
    end)
    return true
end

return Trashnado