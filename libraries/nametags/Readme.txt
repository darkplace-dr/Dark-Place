Nametags by AcousticJamm

You ever see those little name boxes in modern RPGs where the speaker's name goes? That's what this library adds.
Be sure that when you are adding your nametags, you use the cutscene functions listed below:

WorldCutscene:showNametag(text, options) shows a nametag and replaces the old one if one exists.
  - text is a string that prints in the nametag.
  - options is an optional array with various defined variables. The list of options is as follows:
    - top: Boolean value that determines if the nametag is on top or bottom (top is true). Defaults based on player location.
    - right: Boolean value that determines if the nametag is on left or right (right is true). Defaults based on player location.
    - color: 4-array that represents RGBA. Defaults to {1, 1, 1, 1}.
    - font: String value that determines the font that the name is printed in. Defaults to "main".
    - style: String value that determines the text style, including "none", "menu", "light", "dark", and "GONER". Defaults to "dark" in dark world and "none" in light world.

WorldCutscene:hideNametag() removes the nametag if one exists.