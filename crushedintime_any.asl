// Created by Bitowsky (https://bitowsky.com)
// Made for Crushed In Time 

// Autosplitter Version: 1.0
// Updated on: 04.07.2026

state("CrushedInTime")
{
	int currChapter : "UnityPlayer.dll", 0x02195FA8, 0x8, 0x18, 0x60, 0x548, 0x60, 0x188, 0x48;
	int currStep : "GameAssembly.dll", 0x54DDA90, 0xB8, 0x8, 0x178, 0x90, 0x140, 0x278, 0x4C;
	int isCutscene : "UnityPlayer.dll", 0x20FB500, 0x368, 0x8, 0x50, 0x8, 0x8, 0x8, 0x7C;
	string128 lastDialogueOLD : "UnityPlayer.dll", 0x215FFB8, 0x18, 0x0, 0x1C;
	string256 lastDialogue : "UnityPlayer.dll", 0x2218AE0, 0x8, 0x0;
	bool inMainMenu : "GameAssembly.dll", 0x54D9AF0, 0x40, 0xB8, 0x10, 0xD8, 0x3D8, 0x10, 0x28;
}

startup {
	vars.finalListen = false;
	
	settings.Add("chapSplits", true, "Chapter Splits");
	settings.SetToolTip("chapSplits", "Splits everytime you enter a new chapter (This includes the prologue as well)");
}

start {
	
	if (old.inMainMenu == true && current.inMainMenu == false) {
		return true;
	};
	
	vars.finalListen = false;
}

split {
	//normal
	if (settings["chapSplits"]) {
		if (current.currChapter - old.currChapter == 1) {
			return true;
		};
	};
	
	//end
	if (vars.finalListen) {
		print("FINAL LISTEN...");
		print("FINAL LISTEN - IS CUTSCENE: " + current.isCutscene.ToString());
		if (current.isCutscene == 1) {
			print("--- !!!FINISH SPEEDRUN!!! ---");
			vars.finalListen = false;
			return true;
		};
	};
}

update {
	if (current.lastDialogue != null && current.lastDialogue.Contains("VortexFall_ProtoCatch")) {
		vars.finalListen = true;
	}
	
	if (current.isCutscene != old.isCutscene) {
        print("IS CUTSCENE: " + current.isCutscene.ToString());
    }
	
	if (current.lastDialogue != old.lastDialogue) {
        print("LAST DIALOGUE: " + current.lastDialogue);
    }
	
	if (current.lastDialogue == null) {
		print("lastDialogue is NULL");
	}
}