import woodpuzzleCombat.ash

print("imported woodpuzzleAdventure.ash");



boolean adv_betterAdv(location loc, string combatFunc) {
	string page_text = to_url(loc).visit_url();
	
	if(page_text.contains_text("Combat")) {
		cb_initCombat();
		run_combat(combatFunc);
	}
	return true;
}