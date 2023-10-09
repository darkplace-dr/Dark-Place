local RefundTxt, super = Class(Object)

function RefundTxt:init()
    super.init(self)

    self.text = Text("REFUND", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, {
        --align = "center",
        --font = "name",
        font_size = 8,
        style = "dark"
    })
    self.text.x = 20
    self.text.y = -10
    self.text.color = COLORS.yellow
    --self:addChild(self.text)
    self.sprite = Sprite("effects/refund")
    self:addChild(self.sprite)


    self:setScale(0.5)
    self.sprite.x = 20
    self.sprite.y = -10
    Assets.playSound("smrpg_coin")

    Game.battle.timer:after(2, function ()
        self:remove()
    end)
    Game.battle.timer:every(0.5, function ()
        self.visible = not self.visible
    end)

end


return RefundTxt