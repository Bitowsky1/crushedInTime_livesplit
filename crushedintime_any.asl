// Autosplitter for Crushed In Time 
// Created by Bitowsky (https://bitowsky.com)
// More info: https://github.com/Bitowsky1/crushedInTime_livesplit

// Autosplitter Version: 1.1
// Up with game version v1.0.6037
// Updated on: 28.07.2026


state("CrushedInTime")
{
	int currChapter : "GameAssembly.dll", 0x05EA3B98, 0xB8, 0x8, 0xD0, 0xC0, 0xB0, 0x98, 0x48;
	int canSkip : "GameAssembly.dll", 0x5F49A68, 0xB8, 0x10, 0x198, 0x30, 0x108, 0x0, 0xF18;
	// int canSkip : "UnityPlayer.dll", 0x21F5A98, 0x8, 0x168, 0x30, 0x40, 0x20, 0x298; (there were multiple addresses to this, but this one broke around chapter 7-8, and it returned an invalid value, so I replaced it with the one above)
	string256 lastDialogue : "UnityPlayer.dll", 0x2218AE0, 0x8, 0x0;
	bool inMainMenu: "GameAssembly.dll", 0x5ED44D8, 0x78, 0xB8, 0x80, 0x18, 0x3F0, 0x10, 0xA8;
	
	
	// (Broken, as of version v1.0.6037 [July 17th 2026])
	// int isCutscene : "UnityPlayer.dll", 0x20FB500, 0x368, 0x8, 0x50, 0x8, 0x8, 0x8, 0x7C; (replacing this with canSkip, since finding the new isCutscene address seem to be difficult for some reason)
	// int currChapter : "UnityPlayer.dll", 0x02195FA8, 0x8, 0x18, 0x60, 0x548, 0x60, 0x188, 0x48;
	// bool inMainMenu : "GameAssembly.dll", 0x54D9AF0, 0x40, 0xB8, 0x10, 0xD8, 0x3D8, 0x10, 0x28;
	
	// Unused
	// int currStep : "GameAssembly.dll", 0x54DDA90, 0xB8, 0x8, 0x178, 0x90, 0x140, 0x278, 0x4C;
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
		//print("FINAL LISTEN - IS CUTSCENE: " + current.isCutscene.ToString());
		print("FINAL LISTEN - CAN SKIP: " + current.canSkip.ToString());
		if (current.canSkip == 1) {
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
	
	//if (current.isCutscene != old.isCutscene) {
    //    print("IS CUTSCENE: " + current.isCutscene.ToString());
    //}
	
	if (current.canSkip != old.canSkip) {
		print("CAN SKIP: " + current.canSkip.ToString());
	}
	
	if (current.lastDialogue != old.lastDialogue) {
        print("LAST DIALOGUE: " + current.lastDialogue);
    }
	
	if (current.lastDialogue == null) {
		print("lastDialogue is NULL");
	}
}
