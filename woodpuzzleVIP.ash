
boolean [item] VIP_FLOUNDRY_ITEMS = $items[Carpe, Codpiece, Troutsers, Bass Clarinet, Fish Hatchet, Tunac];

int VIP_DECK_MYST_SUBSTAT = 14;
int VIP_DECK_FOREST = 33;
int VIP_DECK_GIANT_GROWTH = 38;
int VIP_DECK_AUTOSELL = 64;

//todo: new you club

//todo spacegate

//todo: robortender

//todo: heart-shaped crate

//todo:space planula

//todo: gingerbread

//todo: thanksgarden

//todo: lil' orphan

//todo: time-spinner

//todo: protonic

boolean vip_cheat_deck(int deckCheat) {
	if(deckCheat == VIP_DECK_MYST_SUBSTAT) {
		cli_execute("cheat stat mysticality");
	} else if(deckCheat == VIP_DECK_FOREST) {
		cli_execute("cheat Forest");
	} else if(deckCheat == VIP_DECK_AUTOSELL) {
		cli_execute("cheat 1952 Mickey Mantle");
		autosell(1, $item[1952 Mickey Mantle card]);
	}
	return true;
}

boolean vip_floundry(item fishItem) {
	int itemNumber = 0;
	
	if(VIP_FLOUNDRY_ITEMS contains fishItem) {
		itemNumber = to_int(fishItem);
	}
	
	if(itemNumber == 0) {
		return false;
	}
	//todo:check that we can get a floundry item
	visit_url("clan_viplounge.php?preaction=buyfloundryitem&whichitem=" + itemNumber);
	return true;
}