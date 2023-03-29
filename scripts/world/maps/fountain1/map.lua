local Fountain1, super = Class(Map)

function Fountain1:load()
  super:load(self)
  
  --local flag = Game:getFlag("hasSealedFirstFountain", default)
  
  --if flag == false or flag == default then

	--Game.world:startCutscene("room_prefountain.fountain1")
	

  --end

end

function Fountain1:onEnter()
	print("what")
  	Game.world:startCutscene("room_prefountain.fountain1")
end

return Fountain1