script "IconMenu.ash";

# Thanks to Icon314 for creating the base of this code, as well as letting me gut it!

# TODO:
# Add search field for items and skills (use $item[ text ].image)
# Add save and load buttons to the relay

string [int, int, string, string, string] awesomeicons;

boolean shoulddelete(int i, int j)
{
	foreach x, y in awesomeicons
	{
		if (i == x && j == y)
		{
			return false;
		}			
	}
	return true;
}

void usage()
{
	print("Usage:");
	print("\"iconmenu action savename);\"");
	print("action - save, load, clear");
	print("savename - the name of the setup to save/load, defaulted to 'backup'");
	abort();
}

void deleteicon(int x, int y)
{
	visit_url("/awesomemenu.php?pwd="+my_hash()+"&delete="+x+","+y,false);
}

void main(string input)
{
	string [int] arguments = input.split_string(" ");
	
	if(arguments.count() != 2)
	{
		usage();
	}

	string action = arguments[0];
	string savename = arguments[1];
		
	if (savename == "") savename = "backup";
	
	if(action == "save")
	{	
		string message;
		string topmenu = visit_url("/topmenu.php");
		matcher icons = create_matcher('<div class="ai" +data-xy="(\\d+),(\\d+)" +data-def="\\[&quot;(.+?)&quot;,&quot;(go|macro|popup)&quot;,&quot;(.+?)&quot;(,&quot;([a-zA-Z ]+)&quot;)?',topmenu);
		while(icons.find())
		{
			int x = to_int(icons.group(1));
			int y = to_int(icons.group(2));
			string img = icons.group(3);
			string type= icons.group(4);
			string content = icons.group(5);
			content = content.replace_string("\\/","/");
			content = content.replace_string("amp;", "");
			print(content);
			string Name = icons.group(7);
			awesomeicons[x, y, img, type, content] = name;
			message += img + " | " + content + "\n";
		}
		message.replace_string(" ", "+");
		#visit_url("sendmessage.php?action=send&pwd="+my_hash()+"&towho=hawkshaw&contact=0&message="+message+"&howmany1=1&whichitem1=0&sendmeat=");
		map_to_file(awesomeicons, "/IconMenu/"+savename+".txt");
		print("Saved to "+savename+".txt");
	}
	else if(action == "clear")
	{
		print("Deleting all icons");
		string topmenu = visit_url("/topmenu.php");
		matcher icons = create_matcher('<div class="ai" +data-xy="(\\d+),(\\d+)" +data-def="\\[&quot;(.+?)&quot;,&quot;(go|macro|popup)&quot;,&quot;(.+?)&quot;(,&quot;([a-zA-Z ]+)&quot;)?',topmenu);
		while(icons.find())
		{
			int x = to_int(icons.group(1));
			int y = to_int(icons.group(2));
			deleteicon(x,y);
		}
	}
	else if(action == "load")
	{
		print("Loading icons from " + savename + "...");
		string topmenu = visit_url("/awesomemenu.php");
		file_to_map("/IconMenu/"+savename+".txt", awesomeicons);

		print("Updating icons...");
		foreach x, y, img, type, content, name in awesomeicons
		{
			string check = replace_string('data-xy="'+x+','+y+'"  data-def="[&quot;'+img+'&quot;,&quot;'+type+'&quot;,&quot;'+content+'&quot;', "/", "\\/");
			
			if (contains_text(topmenu, check))
			{
				continue;
			}
			string xy = to_string(x) + "," + to_string(y);
			content = content.replace_string("|", "%7C");
			content = content.replace_string("&", "%26");
			content = content.replace_string(" ", "+");
			if(type == "go")
				visit_url("awesomemenu.php?existing="+xy+"&actiontype="+type+"&icon="+img+"&go="+content+"&macro=&name="+name, true, true);
			else if(type == "macro")
				visit_url("awesomemenu.php?existing="+xy+"&actiontype="+type+"&icon="+img+"&go=account.php&macro="+content+"&name="+name, true, true);
		}
		
		print("Removing old icons...");
		
		topmenu = visit_url("awesomemenu.php");
		string [int, int] icons = group_string(topmenu, 'div class="ai"  data-xy="(\\d{1,2}),(\\d{1,2})');
		
		foreach i in icons
		{
			if (shoulddelete(to_int(icons[i][1]), to_int(icons[i][2])))
			{
				visit_url("/awesomemenu.php?pwd="+my_hash()+"&delete="+icons[i][1]+","+icons[i][2],false);
			}
		}
		print("Done!");
	}
	else
	{
		usage();
	}
}
