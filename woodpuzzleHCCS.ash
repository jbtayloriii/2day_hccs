import woodpuzzleAdventure.ash
import woodpuzzleCombat.ash

item itemCurrentBadge = $item[plastic detective badge]; //switch to which badge you have, or none 
boolean debugPrint = true; //verbose printing

//helper functions
void printd(string str) {
	if(debugPrint) {
		print(str);
	}
}

int get_int(string prop) {
	return get_property(prop).to_int();
}

int get_progress() {
	return get_int("wp_progress");
}

void set_progress(int progress) {
	set_property("wp_progress", progress);
}

//Mr store items
boolean hasItemDeck = item_amount($item[8382]) > 0;
boolean hasItemVIPKey = item_amount($item[Clan VIP Lounge key]) > 0;

void chateau_rest() {
	int freeRests = total_free_rests() - get_int("timesRested");
	if(freeRests > 0) {
		printd("Resting at chateau");
		
		//test
		visit_url("place.php?whichplace=chateau&action=chateau_restbox");
	}
}

void castSkill(skill skillName) {
	printd("Casting skill " + skillName);
	if(!have_skill(skillName)) {
		printd("Cannot cast " + skillName + ", do not have skill");
		return;
	}
	int cost = mp_cost(skillName);
	if(my_mp() < cost) {
		chateau_rest();
	}
	
	use_skill(1, skillName);
}

//Initialization

void initializeRun() {
	set_property("wp_script_day", 0);
	set_property("wp_progress", 0);
	set_property("wp_current_run", get_property("knownAscensions"));
}

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

void drinkBooze(item it, int potency) {
	if(item_amount(it) == 0) {
		abort("Cannot drink " + it + ". You don't have the item.");
	}
	if(inebriety_limit() - my_inebriety() < potency) {
		abort("Can't drink " + it + ". You're going to overdrink.");
	}
	if(have_effect($effect[Ode to Booze]) == 0) {
		castSkill($skill[The Ode to Booze]);
	}
	
	drink(1, it);
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
}

void sellPorkElfGems() {
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

void setupDoghouse() {
	set_property("choiceAdventure1106","2");
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

//test
void witchessFight(string monsterName, string combatFunc) {
	if(monsterName == "bishop") {
		visit_url("campground.php?action=witchess"); //go to witchess fights
        run_choice(1);
		visit_url("choice.php?whichchoice=1182&option=1&piece=1942&pwd=" + my_hash(), false); //1942 piece: bishop
		if(combatFunc != "") {
			cb_initCombat();
			run_combat(combatFunc);
		} else {
			run_combat();
		}
	}
}

//implement
void dayTwoPrep() {
	printd("Day two breakfast");
	castSkill($skill[perfect freeze]);
	castSkill($skill[Advanced Saucecrafting]);
	castSkill($skill[Advanced Cocktailcrafting]);
	castSkill($skill[Summon Alice's Army Cards]);
	castSkill($skill[Pastamastery]);
	visit_url("campground.php?action=garden");
	visit_url("campground.php?action=workshed");
	visit_url("place.php?whichplace=chateau&action=chateau_desk2");
}

void dayOnePrep() {
	setupTerminalRollover("stats");
	setupTerminalCombatSkills("digitize", "extract");
	
	//Chateau juice bar
	visit_url("place.php?whichplace=chateau&action=chateau_desk2");
	visit_url("campground.php?action=garden");	
	
	cli_execute("buy toy accordion");
	cli_execute("buy dramatic™");
	use(1, $item[157]); //dramatic range
	if(item_amount($item[carton of astral energy drinks]) > 0) {
		use(1, $item[carton of astral energy drinks]);	
	}
	//todo: add other astral things

}

void unlockSkeletonStore() {
	visit_url("shop.php?whichshop=meatsmith&action=talk");
	visit_url("choice.php?pwd&whichchoice=1059&option=1&choiceform1=Sure%2C+I%27ll+go+check+it+out.");
	visit_url("choice.php?pwd&whichchoice=1059&option=3&choiceform1=Not+yet.+I%27ll+keep+looking.");
}

void dayOne() {
	if(get_progress() == 0) {
		init_equipment();
		setupDoghouse();

		cheatMyst();
		tootOriole();
		sellPorkElfGems();
		floundry();
		showerMp();
		
		dayOnePrep();
		
		chewingGumFish($item[turtle totem]);
		
		//take machine elf
		switchToFam($familiar[machine elf]);
		
		//radio
		cli_execute("buy detuned radio");
		change_mcd(10);
		
		set_progress(10);
	}
	
	if(get_progress() == 10) {
		unlockSkeletonStore();
		witchessFight("bishop", "combatNormal");
		witchessFight("bishop", "combatNormal");
		witchessFight("bishop", "combatNormal");
		witchessFight("bishop", "combatNormal");
		witchessFight("bishop", "combatNormal");
		drinkBooze($item[sacramento wine], 1);
		drinkBooze($item[sacramento wine], 1);
		drinkBooze($item[sacramento wine], 1);
		drinkBooze($item[sacramento wine], 1);
		drinkBooze($item[sacramento wine], 1);
	
		set_progress(20);
	}
	
	if(get_progress() == 20) {
		adv_betterAdv($location[Deep Machine Tunnels], "combatNormal");
	}
	
	return;
	//witchess bishop with digitize and extract
	
	//drink sacramento wine
	
	//buff up: init and fam weight, phat loot, use items.enh in terminal, vip table
	//terminalItemBuff();
	
	//5 free machine elf fights with extract, use abstraction: thought against a perceiver of sensations if available
}

void dayTwo() {
	dayTwoPrep();
	
	witchessFight("bishop", "combatNormal");
	
}

void main() {
	if(get_int("knownAscensions") != get_int("wp_current_run")) {
		initializeRun();
	}
	if(get_int("wp_progress") < 400) {
		//day one 0 - 400
		dayOne();
	} else {
		//day two 400 - 800
		dayTwo();
	}
}