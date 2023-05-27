local LadderArea, super = Class(Event, "ladderarea")

function LadderArea:init(data)
    super:init(self, data.x, data.y, data.width, data.height)
	self.inside = {}
	
	self:setHitbox(0, 0, data.width, data.height)
end

function LadderArea:onEnter(chara)
	self.inside[chara] = true
	if Assets.getTexture(chara.actor.path .. "/climb") ~= nil or Assets.getTexture(chara.actor.path .. "/climb_1") ~= nil then
		chara.sprite:setWalkSprite("climb")
	elseif Assets.getTexture(chara.actor.path .. "/" .. chara.actor.default .. "/up") ~= nil or Assets.getTexture(chara.actor.path .. "/" .. chara.actor.default .. "/up_1") ~= nil then
		chara.sprite:setWalkSprite("walk/up")
	end
end

function LadderArea:onExit(chara)
	local precol = false
	for k,v in ipairs(self.world.map:getEvents("ladderarea")) do
		if v:collidesWith(chara) and v ~= self then
			precol = true
		end
	end
	if precol == false then
		chara.sprite:resetSprite()
	end
	self.inside[chara] = false
end

function LadderArea:update()
	super:update(self)
	for chara, is_inside in pairs(self.inside) do
		if is_inside then
			
		end
	end
end

return LadderArea