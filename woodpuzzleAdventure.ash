import woodpuzzleCombat.ash

boolean ADV_VERBOSE = true;

void prep_printd(string text) {
	if(ADV_VERBOSE) {
		print(text);
	}
}

print("imported woodpuzzleAdventure.ash");

familiar DEFAULT_PREP_FAM = $familiar[none];
location DEFAULT_PREP_ADV_LOC = $location[none];
string MAX_ITEMS = "prep_max_items";

boolean [string] MAX_POSSIBILITIES = $strings[MAX_ITEMS];

record adventure_prep {
	familiar takenFam;
	location advLoc;
	boolean [string] statsToMax;
	boolean [skill] combatSkillsToCast;
	string combatFunction;
};

void prep_atLocation(adventure_prep prep, location loc) {
	prep_printd("Setting adv location: " + loc);
	prep.advLoc = loc;
}

void withFamiliar(adventure_prep prep, familiar fam) {
	prep_printd("Setting adv familiar: " + fam);
	prep.takenFam = fam;
}

void withMaxStats(adventure_prep prep, boolean [string] maxes) {
	string debug_max_string = "";
	foreach str in maxes {
		if (!(MAX_POSSIBILITIES contains str)) {
			abort("Incorrect max stats string:" + maxes + "; prep:" + prep);
		}
		debug_max_string += " " + str;
	}
	prep_printd("Setting adv maximizers:" + debug_max_string);
	prep.statsToMax = maxes;
}

void withCombatScript(adventure_prep prep, string scr) {
	prep_printd("Setting adv combat script: " + scr);
	prep.combatFunction = scr;
}

adventure_prep createAdvPrep() {
	adventure_prep newPrep;
	newPrep.takenFam = DEFAULT_PREP_FAM;
	return newPrep;
}

boolean adv_betterAdv(adventure_prep prep) {
	location loc = prep.advLoc;
	if(loc == DEFAULT_PREP_ADV_LOC) {
		abort("No adventure location set");
	}
	string page_text = to_url(loc).visit_url();
	if(page_text.contains_text("Combat")) {
		cb_initCombat();
		run_combat(prep.combatFunction);
	}
	return true;
}