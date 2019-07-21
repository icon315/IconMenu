# Preferences

boolean hide_edit_button = false;
boolean hide_moons = true;
boolean hide_help = true;
boolean hide_bug_report = false;
boolean hide_logout = false;
boolean hide_relay_scripts = false;

int scriptsoffset = 161;

buffer override(buffer page)
{	
 	# Handle relay and CLI requests
	if (form_field("relay") != "")
	{
    	page.replace_string("</head>","<script>top.mainpane.location='"+form_field("relay")+"';</script></head>");
	}
	if (form_field("mafia") != "")
	{
		if (cli_execute(form_field("mafia"))) page = visit_url();
	}
	
# Cosmetic Filters
	matcher fixed = create_matcher('<\\w*? class="noedit".*?>.*?<\\/div>', page);
	
	if (hide_edit_button)
	{
		page.replace_string('<a class="config"', '<a class="config" style="display: none;"');
		scriptsoffset-=15;
	}
	if (hide_moons)
	{
		page.replace_string('<div class="noedit"', '<div class="noedit" style="display: none;"');
		scriptsoffset-=86;
	}
	if (hide_help)
	{
		page.replace_string('<a class="noedit" onclick', '<a class="noedit" style="display: none;" onclick');
		scriptsoffset-=15;
	}
	if (hide_bug_report)
	{
		page.replace_string('<a class="noedit" href="adminmail.php"', '<a class="noedit" href="adminmail.php" style="display: none;"');
		scriptsoffset-=15;
	}
	if (hide_logout)
	{
		page.replace_string('<a class="noedit" href="/KoLmafia/', '<a class="noedit" style="display: none;" href="/KoLmafia/');
		scriptsoffset-=15;
	}

	matcher refresher = create_matcher('\\[<a href="(.*?)">re</a>\\]', page);
	while (refresher.find())
	{
		page.replace_string(group(refresher, 0), "");
	}
	
	if (hide_relay_scripts)
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
		page.replace_string('rel="/relay ' + group(relay,1) + '" href="#" class="macrocon"', 'rel="/" href="?relay=' + group(relay,1)+'"');
	}
	matcher mafia = create_matcher('rel="\/mafia (.*?)(?=" href="#")', page);
	while (mafia.find())
	{
		page.replace_string('rel="/mafia ' + group(mafia,1) + '" href="#" class="macrocon"', 'rel="/" href="?mafia=' + group(mafia,1)+'"');
	}
	return page;
}

void main()
{
	override(visit_url()).write();
}