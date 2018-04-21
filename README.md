A3XAI - Adapted files for **[Desolation Redux]** mod (*NOT Exile Mod*)
=====

Important
---
This is a modified version of @SnarkIndustries (Face)'s A3XAI-DesolationRedux 3.0 version. This AI has been updated to work with **[Desolation Redux]** mod. There is absolutely no guarantee that this version of A3XAI is bug or issue-free.

Introduction
---
A3XAI is a roaming/ambient AI spawning addon for ArmA 3 **[Desolation Redux]** mod (http://desolationredux.com/).

Prerequisite tools:
* PBO Manager: http://www.armaholic.com/page.php?id=16369

Prerequisite: Editing Desolation Redux mission file (if you do not do these steps, AI will not shoot at players):
---
1. UnPBO the **[Desolation Redux]** mission files
2. Edit mission.sqm with a text editor (Recommended to use Notepad++: https://notepad-plus-plus.org/).
	- 1. Find: CIVILIAN
		- Replace: INDEPENDENT
	- 2. Find: C_man_p_beggar_F
		- Replace: I_G_Survivor_F
3. Re pack the mission PBO (Recommended to use PBO Manager: http://www.armaholic.com/page.php?id=16369)
4. Use the following MySQL script to update/back-fill your database. This is necessary, for current living players to be shot at by AI.

```
	UPDATE `desolationredux`.`charactershareables` 
	SET `classname` = 'I_G_Survivor_F' 
	WHERE `classname` = 'C_man_p_beggar_F';​`
```

* Known Issues:
	- Some uniforms spawned by the Desolation Redux loot manager may not be wearable by players
		- This has to do with BIS Arma's code.
		- There is a research task ongoing for a workaround, aside from forcing a new mod both client and server side: "Unlocked Uniforms" mod (by Haleks).

Installing A3XAI under Server "addons" folder
---
1. Download the latest A3XAI release from the A3XAI Releases page: https://github.com/SirFrostingham/A3XAI-DesolationRedux
2. Locate the .zip file you downloaded and extract it to a folder.
3. Open the extracted folder and open the Installation Package folder. 
4. Copy the 2 PBO files (A3XAI.pbo & A3XAI_config.pbo) from this folder
5. Navigate to your server's Arma 3 folder and open the @DesolationServer\addons\ folder.
6. Paste the contents copied from Step 4 into this folder. Note: No **[Desolation Redux]** files are being replaced or modified.
7. (Optional) Configure A3XAI settings by editing A3XAI_config.sqf.

Installing A3XAI as "-serverMod" method
---
1. Download the latest A3XAI release from the A3XAI Releases page: https://github.com/SirFrostingham/A3XAI-DesolationRedux
2. Locate the .zip file you downloaded and extract it to a folder.
3. Open the extracted folder and open the Installation Package folder. 
4. Copy the 2 PBO files (A3XAI.pbo & A3XAI_config.pbo) from this folder
5. Create @A3XAI folder under your server's Arma 3 folder.
6. Create addons folder inside of @A3XAI (should end up looking like this: @A3XAI\addons)
7. Paste the contents copied from Step 4 into this folder (something like: C:\Program Files (x86)\Steam\SteamApps\common\Arma 3 Server\@A3XAI\addons).
8. Modify your server's startup parameters to include @A3XAI. For example: -serverMod=@DesolationServer;@A3XAI;

To configure A3XAI:
---
1. Unpack A3XAI_config.pbo (Recommended to use PBO Manager: http://www.armaholic.com/page.php?id=16369)
2. Edit config.cpp with a text editor (Recommended to use Notepad++: https://notepad-plus-plus.org/). Make your configuration changes.
3. Repack A3XAI_config.pbo
	- Note: The current configuration checked in here can be viewed on the Moosemilker Desolation Redux server (Details at: http://moosemilker.com)

A3XAI Features
---
* Automatically-generated static AI spawns: A3XAI will spawn an AI group at various named locations on the map if players are nearby.
* Dynamic AI spawns: A3XAI will create ambient threat in the area for each player by periodically spawning AI to create unexpected ambush encounters. These AI may occasionally seek out and hunt a player.
* Random AI spawns: A3XAI will create spawns that are randomly placed around the map and are periodically relocated. These spawns are preferentially created in named locations, but may be also created anywhere in the world.
* Air and land vehicle AI patrols: AI patrol in vehicles around the map, looking for players to hunt down. Cars and trucks may roam the road, and helicopters (or jets) search the skies for players. Helicopters with available cargo space may also occasionally deploy an AI group by parachute.
* **Loot drops from AI via a sleeping bag container** (*Look for sleeping bag drops from AI*) - This was done to work around [Desolation Redux] garbage collection system without modifying the mod's server files.
* UAV and UGV patrols: Currently an experimental feature in testing. UAVs and UGVs patrol around the map, and if armed, will engage detected players. UAVs and UGVs may also call for AI reinforcements.
* Custom AI spawns: Users may also define custom infantry and vehicle AI spawns at specified locations.
* ~~Exile-style Respect rewards: Players gain Respect rewards for killing AI, along with bonus points for "special" kills such as long-distance kills or kill-streaks.~~
* ~~Adaptive classname system: A3XAI reads Exile's trader tables to find items that AI can use, such as weapons and equipment. Users may also choose to manually specify classnames to use instead.~~
* Error-checking ability: A3XAI checks config files for errors upon startup. If errors are found, A3XAI will use backup settings and continue operating as normal.
* Classname verification: A3XAI filters out invalid or banned classnames and prevents them from being used by AI.
* Universal map support: A3XAI supports any and every map for Arma 3 without changing any settings.
* Plug-and-play installation: Installing and upgrading A3XAI is a simple copy and paste job and does not require modifying any **[Desolation Redux]** files, except editing the mission.sqm ask stated above so the AI shoot at you.
* Easy configuration: A single configuration file contains all settings for A3XAI. This config file is external to the A3XAI pbo, so configuration changes can be made without ever having to unpack or repack the pbo file.
* Headless Client support: Offload AI calculations from your dedicated server to a headless client to improve server performance. The A3XAI HC can be started/stopped/restarted any time without causing problems.

Note: Headless clients are currently bugged in ArmA 3 1.50. It is recommended to only attempt using a headless client setup in ArmA 3 1.52+.
	
Support the developer
---
If you would like to support development of this software, you can contribute with a donation by clicking on the Donate Icon below. Thank you for your support!

[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=PXV8MLB5KR5WG)

This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
