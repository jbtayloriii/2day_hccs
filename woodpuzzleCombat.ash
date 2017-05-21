print("imported woodpuzzleCombat.ash");

boolean verbose = true;

void determineFight(skill [int] skills) {

	foreach index in skills {
		print(skills[index]);
	}
}

int getNextHitDamage(monster opp){
	int monsterDiff = monster_attack(opp) - my_buffedstat($stat[moxie]);
	int monsterHit = monsterDiff + max(0, .25 * (monster_attack(opp) - damage_reduction()));
	if(verbose) {
		print("Next Hit: " + monsterHit);
	}
	return monsterHit;
}

boolean wpc_canTakeHit(monster opp) {
	int nextHit = getNextHitDamage(opp);
	if(nextHit < my_hp()) {
		return true;
	} else {
		return false;
	}
}


string combatNormal(int round, monster opp, string text) {
	print("normal combat script");
	if($item[Time-Spinner].available_amount() > 0) {
		return "item time-spinner";
	}
	
	if(wpc_canTakeHit(opp)) {
		if(have_skill($skill[Extract])) {
			print("trying to extract");
			return "skill extract";
		} else {
			return "skill saucestorm";
		}
	} else {
		return "skill saucestorm";
	}
}

