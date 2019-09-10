I can't continue to support this game, given the reports of Zack Johnson's abuse. Due to the lack of response from the development team, this script has been modified in an attempt to spread information any way I can.

# IconMenu

![menubar](https://raw.githubusercontent.com/GodLobsterFan/IconMenu/master/images/menubar.png)

IconMenu is a suite of tools and improvements for Kingdom of Loathing's menu bar. 

To install it, just type this into KoLMafia's CLI. 

<pre>svn checkout https://github.com/GodLobsterFan/IconMenu/branches/release/</pre>

To update the tool, just type...

<pre>svn update</pre>

# Aesthetic Tweaks

IconMenu allows you to hide and show various elements of the menu bar. By default, a few of these are hidden, but they can easily be replaced. These, and all other settings, can be set using "set [preference] = [value]" in KoLMafia's CLI. 

For example,

<pre>set iconmenu_hide_moons = true</pre>

A full list of settings is available [here](https://github.com/GodLobsterFan/IconMenu/#reference).

IconMenu also adds a text box to the layout editor, which allows you to select custom images for icons on the menu bar. While I hope to add more functionality to this feature soon, for now, if you simply enter the name of an item, skill, or familiar's image file, that image file will be used once you submit your changes. 

![rename](https://raw.githubusercontent.com/GodLobsterFan/IconMenu/master/images/rename.png)

For example, you could use "godlob" to set an icon's image to that of the God Lobster, or "godlob_egg" to set it as the God Lobster's hatchling. Image file names can be found by right clicking on them, and checking their URL, or else on the Wiki.

![godlob](https://raw.githubusercontent.com/GodLobsterFan/IconMenu/master/images/godlob.png)

# Saving & Loading

IconMenu allows the saving and loading of menu bar layouts, and can be invoked from KoLMafia's CLI, other ASH scripts, or even the relay browser itself.

Within Mafia, to save layouts, run...

<pre>iconmenu save filename</pre> 

And to load them, run...

<pre>iconmenu load filename</pre> 

You can also switch between layouts in the relay browser, by using custom macros.

# Mafia Commands

![Guide](https://raw.githubusercontent.com/GodLobsterFan/IconMenu/master/images/guide.png)

In order to execute CLI commands or launch relay scripts from the menu bar, IconMenu will automatically override any macro in the form "/mafia command" or "/relay filename.ash", and run it either in the CLI or relay browser. 

For example, to create an icon that will equip your best available rollover gear, add a Custom Macro link, and set the macro to...

<pre>/mafia maximize advs</pre>

To create an icon that launches Ezandora's Guide, set the macro to...

<pre>/relay Relay_guide.ash</pre>

To create an icon that will switch to new menu bar layout, you can set the macro to...

<pre>/mafia iconmenu (load, filename)</pre>

Switching between two menu bar layouts can be almost-instant, or take a few seconds, depending on how similar the layouts are. 

# Live Icons
IconMenu now supports automatically updating images based on a limited number of criteria. Currently, by specifying an icon for either your familiar or your dwelling, IconMenu will override that image with the respective current item or familiar image file. 

You can specify a file to overwrite by changing the settings for iconmenu_live_familiar and iconmenu_live_campground.

<pre>set iconmenu_live_familiar = "terrarium.gif"</pre>
<pre>set iconmenu_live_campground = "elevent.gif"</pre>

To remove a live icon, simply set its value to "". 

# Examples

Two layouts have been provided as examples, namely "demo_aftercore" and "demo_hccs". To load the latter, paste this into the CLI.

<pre>iconmenu load demo_hccs</pre>

# Reference

| Cosmetic Tweaks  | Default Value |
| ------------- | ------------- |
| iconmenu_hide_edit_button | false
| iconmenu_hide_moons | true
| iconmenu_hide_help | true
| iconmenu_hide_bug_report | true
| iconmenu_hide_logout | true
| iconmenu_hide_relay_scripts | false

| Live Icons  | Default Value |
| ------------- | ------------- |
| iconmenu_live_familiar | "terrarium.gif"
| iconmenu_live_campground | "elevent.gif"

# Supporting Development

If you have any ideas for future features, or just want to show off your creations, I'd love to hear from you! Shoot me a message at Elliot#4310 on Discord!

I'm not quite as rich as Ezandora, so if you want to throw any meat or goodies my way to support development, I'd be absurdly grateful. In game, I'm at Hawkshaw (#3289932). 

# Changelog

__0.2__

Fixed a few bugs, messed with your settings, and added early support for live icons!

__0.1.1__

Added a security check to the /mafia and /relay commands. Now no one can trick you into clicking on a malicious link and hijack your CLI!

Also, IconMenu will kmail me your creations once you deem them worth saving. If you're feeling shy, you're welcome to comment those lines out!

__0.1__

Alpha release. There's good things to come!
