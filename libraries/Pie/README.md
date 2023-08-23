# Pie
 Pie (Passive Item Effects) is a small library for the Deltarune fangame engine, Kristal. Pie extends the default functionality of items to give them more functionality and make it easier to add custom item effects.
 
# Licensing
 Pie is licensed under the permissive BSD 3-Clause license. You can check out this repository's copy of this license (and its terms) [here](https://github.com/MrOinky/Pie/blob/main/LICENSE.md).

# Installation
 Using the Pie library in a mod is very easy! All it takes is three simple steps:
 - Go to the [Releases](https://github.com/MrOinky/Pie/releases) section of this GitHub repository.
 - On the latest release (the topmost one), download the Source code.
 - Place the downloaded Source code into the `libraries` folder of the target mod.
 
 Note: Not all versions of Pie may be compatible with all versions of Kristal. When a new release of Pie changes its intended Kristal version, this will be specified in the release.
 
 Additionally, the `pie_examples` library is also provided with each release to demonstrate the capabilities of Pie! To see the examples in action, place the downloaded library into the `libraries` folder and start experimenting! (Pie must also be inside of the libraries folder for the examples to work.)

# Usage and Features
 Pie comes with a handful of helpful additions to items from Kristal, including:
 - Lots of new callbacks, mostly inheriting from those found in the Encounter class, as well as a few custom ones.
 - Passive Item Effects for equipment such as auto-healing, damage over time and TP restoration. Perfect for mimicking functionality of items such as the Stained Apron!
 - Healing boost effects for when items just aren't strong enough! Great for mimicking the effect of the Burnt Pan!
 - Healing from the past with Future Heals for HealItems!
 - Start and end of battle boosts with Starting Tension and Victory Healing!
 
 The best way to learn how to utilize the different features offered by Pie is by checking the in-code documentation and looking at the examples provided inside `pie_examples`. There is also a [GitHub wiki](https://github.com/MrOinky/Pie/wiki) available for Pie.
 
# Feedback
 If you have a suggestion for the library, or have ran into a bug, please make an issue for this repository so it can be checked it out! Any pull requests for bug fixes or new features are also always welcome!
