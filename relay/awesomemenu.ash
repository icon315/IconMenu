# Preferences

int scriptsoffset = 161;
int version = 3;

buffer override(buffer page)
{	
 	# Handle relay and CLI requests
 	if (form_field("pwd") == my_hash())
 	{
		if (form_field("relay") != "")
		{
			page.replace_string("</head>","<script>top.mainpane.location='"+form_field("relay")+"';</script></head>");
		}
		if (form_field("mafia") != "")
		{
			if (cli_execute(form_field("mafia"))) page = visit_url();
		}
	}
	
# Cosmetic Filters
	matcher fixed = create_matcher('<\\w*? class="noedit".*?>.*?<\\/div>', page);
	
	if (get_property("iconmenu_hide_edit_button").to_boolean())
	{
		page.replace_string('<a class="config"', '<a class="config" style="display: none;"');
		scriptsoffset-=15;
	}
	if (get_property("iconmenu_hide_moons").to_boolean())
	{
		page.replace_string('<div class="noedit"', '<div class="noedit" style="display: none;"');
		scriptsoffset-=86;
	}
	if (get_property("iconmenu_hide_help").to_boolean())
	{
		page.replace_string('<a class="noedit" onclick', '<a class="noedit" style="display: none;" onclick');
		scriptsoffset-=15;
	}
	if (get_property("iconmenu_hide_bug_report").to_boolean())
	{
		page.replace_string('<a class="noedit" href="adminmail.php"', '<a class="noedit" href="adminmail.php" style="display: none;"');
		scriptsoffset-=15;
	}
	if (get_property("iconmenu_hide_logout").to_boolean())
	{
		page.replace_string('<a class="noedit" href="/KoLmafia/', '<a class="noedit" style="display: none;" href="/KoLmafia/');
		scriptsoffset-=15;
	}

	matcher refresher = create_matcher('\\[<a href="(.*?)">re</a>\\]', page);
	while (refresher.find())
	{
		page.replace_string(group(refresher, 0), "");
	}
	
	if (get_property("iconmenu_hide_relay_scripts").to_boolean())
	{
		page.replace_string("<div style='position: absolute; z-index: 5; top: 40px; right: 0px;", "<div style='display: none;'");
	}
	else
	{
		page.replace_string("<div style='position: absolute; z-index: 5; top: 40px; right: 0px;", "<div style='position: absolute; z-index: 5; top: 10px; right: "+scriptsoffset+"px;");
	}
	page.replace_string('<i>(click to edit)</i>', "");
	page.replace_string('<div class="justedit">&laquo; Edit Mode, Click to Exit</div>', "");

# Icon selector
	page.replace_string('<input type="hidden" name="icon"', '<input type="visible" name="icon"');
 	page.replace_string("('#config .icon')", "('#config .icon img')");	

	# Set up CLI and Relay macros
	matcher relay = create_matcher('rel="\/relay (.*?)(?=" href="#")', page);
	while (relay.find())
	{
		page.replace_string('rel="/relay ' + group(relay,1) + '" href="#" class="macrocon"', 'rel="/" href="?relay=' + group(relay,1)+'&pwd='+my_hash()+'"');
	}
	matcher mafia = create_matcher('rel="\/mafia (.*?)(?=" href="#")', page);
	while (mafia.find())
	{
		page.replace_string('rel="/mafia ' + group(mafia,1) + '" href="#" class="macrocon"', 'rel="/" href="?mafia=' + group(mafia,1)+'&pwd='+my_hash()+'"');
	}
	
# Live Icons
	if (get_property("iconmenu_live_familiar") != "" && my_familiar().image != "debug.gif")
	{
		page.replace_string(get_property("iconmenu_live_familiar"), my_familiar().image);
	}
	if (get_property("iconmenu_live_campground") != "")
	{
		string tent = get_dwelling().image;
		
		if (my_path() == "Dark Gyftte")
		{
			tent = "coffinlid.gif";
		}
		else if (my_path() == "Actually Ed the Undying")
		{
			tent = "brickopyramid.gif";
		}
		page.replace_string(get_property("iconmenu_live_campground"), tent);
	}	

	return page;
}

void main()
{
	if (get_property("iconmenu_version") < version)
	{
		# First time set-up
		if (get_property("iconmenu_version") == "")
		{
			print ("Setting up IconMenu!");
			# Force auto-update
			print("To protect you from my programming, I'm enabling auto-update for all your scripts. You're welcome to disable this in Mafia's settings.", "blue");
			set_property("svnUpdateOnLogin", true);
			
			# Cosmetic Filters
			set_property("iconmenu_hide_edit_button", false);
			set_property("iconmenu_hide_moons", true);
			set_property("iconmenu_hide_help", true);
			set_property("iconmenu_hide_bug_report", true);
			set_property("iconmenu_hide_logout", true);
			set_property("iconmenu_hide_relay_scripts", false);
		
			# Live icons
			set_property("iconmenu_live_familiar", "terrarium.gif");	
			set_property("iconmenu_live_campground", "elevent.gif");
		}
		
		print("Backing up your old layout...");
		cli_execute("iconmenu save backup)");
		
		set_property("iconmenu_version", version);
		print("You're good to go!");
	}
	override(visit_url()).write();
}
