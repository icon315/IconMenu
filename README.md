# IconMenu

![menubar](https://raw.githubusercontent.com/GodLobsterFan/IconMenu/master/images/menubar.png)

IconMenu is a suite of tools and improvements for Kingdom of Loathing's menu bar. 

To install it, just type this into KoLMafia's CLI. 

<pre>svn checkout https://github.com/GodLobsterFan/IconMenu/branches/release/</pre>

To update the tool, just type...

<pre>svn update</pre>

# Aesthetic Tweaks

Within /relay/awesomemenu.php, you'll find options to hide or show various elements of the menu bar. By default, a few of these are hidden, but they can easily be replaced. For example, to hide the log out button, simply replace the line "boolean hide_logout = false;" with "boolean hide_logout = true;".

IconMenu also adds a text box to the layout editor, which allows you to select custom images for icons on the menu bar. While I hope to add more functionality to this feature soon, for now, if you simply enter the name of an item, skill, or familiar's image file, that image file will be used once you submit your changes. 

![rename](https://raw.githubusercontent.com/GodLobsterFan/IconMenu/master/images/rename.png)

For example, you could use "godlob" to set an icon's image to that of the God Lobster, or "godlob_egg" to set it as the God Lobster's hatchling. Image file names can be found by right clicking on them, and checking their URL, or else on the Wiki.

![godlob](https://raw.githubusercontent.com/GodLobsterFan/IconMenu/master/images/godlob.png)

# Saving & Loading

IconMenu allows the saving and loading of menu bar layouts, and can be invoked from KoLMafia's CLI, other ASH scripts, or even the relay browser itself.

Within Mafia, to save layouts, run...

<pre>IconMenu (save, filename)</pre> 

And to load them, run...

<pre>IconMenu (load, filename)</pre> 

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

# Examples

Two layouts have been provided as examples, namely "aftercore" and "hc_community_service". To load the latter, paste this into the CLI.

<pre>IconMenu (load, hc_community_service)</pre>

# Supporting Development

If you have any ideas for future features, or just want to show off your creations, I'd love to hear from you! Shoot me a message at Elliot#4310 on Discord!

I'm not quite as rich as Ezandora, so if you want to throw any meat or goodies my way to support development, I'd be absurdly grateful. In game, I'm at Hawkshaw (#3289932). 
