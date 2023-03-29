return function(cutscene, event, player)
	print(event, player)
	
    local kris = cutscene:getCharacter("kris")
    local susie = cutscene:getCharacter("susie")
    local ralsei = cutscene:getCharacter("ralsei")
	
	cutscene:walkTo(kris, event.x, event.y, 0.5)
	
	cutscene:wait(1)
end