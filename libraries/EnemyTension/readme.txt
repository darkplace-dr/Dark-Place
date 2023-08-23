HOW TO USE:

in Encounter:init(), use self.enemy_tension = StartValue, replacing StartValue with whatver amount of TP you want your enemies to start with.
This will create a TP bar on the right side of the screen that will display the enemy side's TP.
The TP is stored at Game.battle.encounter.enemy_tension, but four functions are added to Battle to simplify utilizing it.
(The old APIs are still usable)
These are:

Game.battle:giveEnemyTension(TP)
adds TP to the bar

Game.battle:removeEnemyTension(TP)
removes TP from the bar

Game.battle:getEnemyTension()
returns the current TP value

Game.battle:setEnemyTension(TP)
sets TP to the defined value