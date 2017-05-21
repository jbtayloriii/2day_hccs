
//Constants
int BASE_SERVICE_TURN = 60;

int calculateStatForTest(stat currentStat) {
	//todo: implement
	return 1;
}

//final computations, hard coded stuff mostly

int calcDonateBlood() {
	return BASE_SERVICE_TURN;
}
int calcFeedChildren() {
	return BASE_SERVICE_TURN;
}
int calcBuildMazes() {
	return BASE_SERVICE_TURN;
}
int calcFeedConspirators() {
	return BASE_SERVICE_TURN;
}
int calcBreedCollies() {
	return BASE_SERVICE_TURN;
}
int calcReduceGazelles() {
	return BASE_SERVICE_TURN;
}
int calcMakeSausage() {
	return BASE_SERVICE_TURN;
}
int calcBeAStatue() {
	return BASE_SERVICE_TURN;
}
int calcMakeMargs() {

//todo: if we save too many turns, what do we do?
	int itemBonus = 45;
	int boozeBonus = 0;
	
	int itemTurnsSaved = floor(itemBonus / 30);
	int boozeTurnsSaved = floor(boozeBonus / 15);
	print("Total Item drops: " + itemBonus + " (" + itemTurnsSaved + " turns saved)");
	print("Total Booze drops: " + boozeBonus + " (" + boozeTurnsSaved + " turns saved)");
	return max(0, BASE_SERVICE_TURN - itemTurnsSaved);
}
int calcCleanSteamTunnels() {
	return BASE_SERVICE_TURN;
}

void printSingleLine(string task, int turns, string savings) {	
	print(task + ": " + turns + " (" + savings + ")");
	print("");
}

int printTurnCalcs() {
	int totalTurnCount = 0;
	
	int coilWire = BASE_SERVICE_TURN;
	totalTurnCount += coilWire;
	printSingleLine("Coil wire", coilWire, "Nothing");
	
	int donateBlood = calcDonateBlood();
	totalTurnCount += donateBlood;
	printSingleLine("Donate Blood", donateBlood, "HP");
	
	int feedChildren = calcFeedChildren();
	totalTurnCount += feedChildren;
	printSingleLine("Feed Children", feedChildren, "Muscle");
	
	int buildMazes = calcBuildMazes();
	totalTurnCount += buildMazes;
	printSingleLine("Build Mazes", buildMazes, "Myst");
	
	int feedConspirators = calcFeedConspirators();
	totalTurnCount += feedConspirators;
	printSingleLine("Feed Conspirators", feedConspirators, "Moxie");
	
	int breedCollies = calcBreedCollies();
	totalTurnCount += breedCollies;
	printSingleLine("Breed Collies", breedCollies, "Fam Weight");
	
	int reduceGazelles = calcReduceGazelles();
	totalTurnCount += reduceGazelles;
	printSingleLine("Reduce Gazelles", reduceGazelles, "Melee Damage");
	
	int makeSausage = calcMakeSausage();
	totalTurnCount += makeSausage;
	printSingleLine("Make Sausage", makeSausage, "Spell damage");
	
	int beStatue = calcBeAStatue();
	totalTurnCount += beStatue;
	printSingleLine("Be a Statue", beStatue, "Noncombat %");
	
	int makeMargs = calcMakeMargs();
	totalTurnCount += makeMargs;
	printSingleLine("Make Margs", makeMargs, "Item/booze drops");
	
	int cleanSteamTunnels = calcCleanSteamTunnels();
	totalTurnCount += cleanSteamTunnels;
	printSingleLine("Clean Steam Tunnels", cleanSteamTunnels, "Hot resistance");
	
	print("Total turns needed: " + totalTurnCount);
	return totalTurnCount;
}

void main() {
	printTurnCalcs();
}