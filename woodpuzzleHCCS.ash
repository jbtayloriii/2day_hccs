
item itemCurrentBadge = $item[plastic detective badge]; //switch to which badge you have, or none 


//Mr store items
boolean hasItemDeck = item_amount($item[8382]) > 0;
boolean hasItemVIPKey = item_amount($item[Clan VIP Lounge key]) > 0;


//Let's equip some random IotMs that can give us free stats
void init_equipment() {
	visit_url("place.php?whichplace=town_wrong&action=townwrong_precinct");
	visit_url("place.php?whichplace=town_right&action=townright_ltt");
	if (item_amount(itemCurrentBadge) > 0) {
		equip($slot[acc1], itemCurrentBadge);
	}
	
	if (item_amount($item[your cowboy boots]) > 0) {
		equip($slot[acc2], $item[your cowboy boots]);
	}
	
	if (item_amount($item[protonic accelerator pack]) > 0) {
		equip($slot[back], $item[protonic accelerator pack]);
	}
}

boolean switchToFam(familiar fam) {
	if (!have_familiar(fam)) {
		return false;
	}
	
	if (equipped_amount($item[astral pet sweater]) == 1) {
		equip($slot[familiar], $item[none] );
	}
	
	use_familiar(fam);
	if (item_amount($item[astral pet sweater]) == 1) {
		equip($slot[familiar], $item[astral pet sweater] );
	}
	return true;
}

void test() {
	cli_execute("/terminal educate digitize");
}

void setupTerminalCombatSkills(string skill1, string skill2) {
	cli_execute("terminal educate " + skill1);
	cli_execute("terminal educate " + skill2);
}

void setupTerminalRollover(string rolloverBuff) {
	cli_execute("terminal enquiry " + rolloverBuff);
}

void cheatMyst() {
		print("Cheating Queen", "purple");
		cli_execute("cheat stat mysticality");
}

void tootOriole() {
	print("Toot Oriole, letter from king, pork elf stones", "purple");
    visit_url("tutorial.php?action=toot");
    if (item_amount($item[letter from King Ralph XI]) > 0) use(1, $item[letter from King Ralph XI]);
	if (item_amount($item[pork elf goodies sack]) > 0) use(1, $item[pork elf goodies sack]);
	foreach stone in $items[hamethyst, baconstone, porquoise] autosell(item_amount(stone), stone);
}

void floundry() {
	if(hasItemVIPKey) {
		visit_url("clan_viplounge.php?preaction=buyfloundryitem&whichitem=9002");
		equip($slot[acc3], $item[codpiece]);
	} else {
		print("No VIP key, skipping codpiece", "red");	
	}
}

void showerMp() {
	if (hasItemVIPKey) {
		if (get_property("_aprilShower") == "false") {
			cli_execute("shower mp");
		} else {
			print("Already used shower", "red");			
		}
	} else {
		print("No VIP key, skipping MP shower", "red");	
	}
}

void terminalItemBuff() {
	visit_url("choice.php?pwd&whichchoice=1191&option=1&input=enhance items.enh&pwd=" + my_hash());
}

void odeDrink(item drink) {
	
}

void chewingGumFish(item itemName) {
	//todo: add catches to make sure we're fishing for right items
	while (item_amount(itemName) < 1) {
		cli_execute("buy chewing gum on a string");
		use(1, $item[chewing gum on a string]);
	}
}

void witchessFight(string monsterName) {
	if(monsterName == "bishop") {
		visit_url("campground.php?action=witchess"); //go to witchess fights
            run_choice(1);
		visit_url("choice.php?whichchoice=1182&option=1&piece=1942&pwd=" + my_hash(), false); //1942 piece: bishop
	}
}

void mainWrapper() {

	init_equipment();

	cheatMyst();
	tootOriole();
	floundry();
	showerMp();

	
	setupTerminalRollover("stats");
	setupTerminalCombatSkills("digitize", "extract");
	
	//Chateau juice bar
	visit_url("place.php?whichplace=chateau&action=chateau_desk2");
	
	//harvest garden
	visit_url("campground.php?action=garden");	
	
	//buy toy accordion, dramatic range, use carton of astral energy drinks
	cli_execute("buy toy accordion");
	cli_execute("buy dramatic™");
	use(1, $item[157]); //dramatic range
	use(1, $item[carton of astral energy drinks]);
	
	chewingGumFish($item[turtle totem]);
	
	//Cast ode, drink ice island long tea
	
	//take machine elf
	switchToFam($familiar[machine elf]);
	
	//radio
	cli_execute("buy detuned radio");
	change_mcd(10);
	
	//witchess bishop with digitize and extract
	
	//drink sacramento wine
	
	//buff up: init and fam weight, phat loot, use items.enh in terminal, vip table
	terminalItemBuff();
	
	//5 free machine elf fights with extract, use abstraction: thought against a perceiver of sensations if available
}

void main() {
	witchessFight("bishop");
	//mainWrapper();
}