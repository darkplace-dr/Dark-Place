HOW TO USE:

in Encounter:init(), use self.enemy_tension = StartValue, replacing StartValue with whatver amount of TP you want your enemies to start with.
This will create a TP bar on the right side of the screen that will display the enemy side's TP.
The TP is stored at Game.battle.encounter.enemy_tension, but four four functions are defined in the lib.lua to simplify utilizing it.
These are:

Mod:giveEnemyTension(TP)
adds TP to the bar

Mod:removeEnemyTension(TP)
removes TP from the bar

Mod:getEnemyTension()
returns the current TP value

Mod:setEnemyTension(TP)
sets TP to the defined value