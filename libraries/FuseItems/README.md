# FuseItems Library for Kristal

This library adds a menu that recreates the capacity to fuse two items into one that Malius can do in Deltarune!

![Fusing Menu](https://media.discordapp.net/attachments/900166836958666752/1143350008901554227/image.png)

# Installation

Download the [latest version](https://github.com/Simbel0/FuseItems-Library/releases/latest) of the library and adds it into a folder called `libraries` in your mod's root folder. *(create the folder if it doesn't exist)*

![Your mod's root folder](https://media.discordapp.net/attachments/755844178474303538/1143575387578839061/image.png)

# Usage

## Basics

The library adds a menu called `FuseMenu` which can be used to open the menu using `Game.world:openMenu()`

To open the menu in a cutscene, here's the recommanded way to do it:
```lua
-- ..cutscene stuff, choicers, etc.
cutscene:after(function()
    Game.world:openMenu(FuseMenu())
end)
-- This code will only start the menu once the cutscene ends so try to put it where nothing more happens in the cutscene afterwards
```

The library also gives [two cutscenes](https://github.com/Simbel0/FuseItems-Library/blob/main/scripts/world/cutscenes/fusing.lua) that serves as both placeholders and examples of how you can acces this menu in cutscenes.

## Configuration

The library has the following values as part of its config that be changed in `mod.json`:

`cutscene`: The cutscene that starts when selecting the "Yes" option in the fusion menu. Can only be a cutscene name as a string. Defaults to [`fusing.placeholder`](https://github.com/Simbel0/FuseItems-Library/blob/main/scripts/world/cutscenes/fusing.lua#L13)

`autofuse`: A boolean that decides if the fusion should be done as soon as you press "Yes" in the menu if true or if you should do it yourself in the cutscene if false. Useful if you want to add more checks or have a specific event happen that would alter a fusion. Defaults to true.

`one_page_hide`: A string that hides some elements of the UI if there's only one page of recipes. `"pages"` will hide the "Pages Current/Total" indicator, `"arrows` will hide the arrows and `"all"` will hide both the pages and the arrows. Any other value will hide nothing. Defaults to an empty string. For people who would hate to see arrows when they don't have any page to go to or see an indicator like "Page 1/1"

`print_list_console`: If true, prints to the LÖVE console every recipe in the following format: "Index: item1 + item2 = result` upon starting the mod. Defaults to false.

## The list of items

To know each "recipe", the library uses a table of tables. Each recipe follows this order:

```lua
{
  "item1": "item_id",
  "item2": "item_id",
  "result": "item_id",
  "cutscene": "cutscene name or function",
  'autofuse": "boolean"
}
```

`item1`: The id of an item which will be used as the first ingredient for the fusion.

`item2`: The id the an item which will be used as the second ingredient for the fusion.

`result`: The id the an item which will be used as the result of the fusion.

`cutscene`: An optional option that allows a specific recipe to start a specific cutscene instead of the one defined by default. Can either be the name of a cutscene as a string or directly a function that will be run as a cutscene. Defaults to the cutscene set in the library's config.

`autofuse`: An optional boolean that decides if the fusion should be done as soon as you press "Yes" in the menu if true or if you should do it yourself in the cutscene if false. Useful if you want to add more checks or have a specific event happen that would alter a fusion. Default to the library's config.

Here's an example of 2 recipes together which can be used then with `setItemsList()`:

```lua
fuseItemsList = {
  {
    result = "dd_burger",
    item1 = "darkburger",
    item2 = "darkburger"
  },
  {
    result = "silver_card",
    item1 = "amber_card",
    item2 = "amber_card",
    cutscene = "fusing.alt_cutscene"
  },
  -- ..You can add as much as you want
}
```

## mod.lua

The library adds 3 new functions and a flag that can be used in mod.lua to customize the library's behavior. To call the functions, please use `Kristal.callEvent("function_name", arguments_if_any)`

### Functions

`setItemsList(items_list)`: Set the list of recipes to `items_list`. While you could just change the list already set in `lib.lua`, you might want to make your own list in `mod.lua` and set it with this function for organisation's sake.

`getItemsList()`: Returns the list of recipes.

`reloadItemsList()`: Because all items used in recipes are pre-loaded upon opening the menu to prevent creating items every frame, updating the list while the menu if open won't change what the menu displays. If you ever need it, this function will force the menu to reload all items and remake its list. While it shouldn't happen, note that this might cause an error if you call this function when a menu that isn't the fusing menu is open.

### Flag

`Game:getFlag("fuse_items_data")`: A flag set by the library that contains the data used for the recipe. Set to an empty table upon starting the mod and then set to the latest recipe data confirmed to be used in the fusion menu. This flag does not reset itself as long as the mod isn't restarted.
