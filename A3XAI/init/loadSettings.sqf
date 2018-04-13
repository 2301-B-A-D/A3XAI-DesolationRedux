_startTime = diag_tickTime;

A3XAI_pushedHCVariables = [];

_fnc_getConfigValue = {
	private ["_variableName", "_defaultValue", "_configValue", "_returnValue", "_type", "_string"];
	
	_variableName 	= _x select 0;
	_defaultValue 	= _x select 1;
	
	_returnValue = _defaultValue;
	if (isClass (configFile >> "CfgA3XAISettings")) then {
		_configValue = configFile >> "CfgA3XAISettings" >> _variableName;
		_returnValue = call {
			_type = (typeName _defaultValue);
			
			if (_type isEqualTo "SCALAR") exitWith {
				if (isNumber _configValue) then {
					getNumber _configValue
				} else {
					diag_log format ["[A3XAI] Error found in setting %1, resetting to default value.",_variableName];
					_defaultValue
				};
			};
			
			if ((_type isEqualTo "BOOL") && {isNumber _configValue}) exitWith {
				if (isNumber _configValue) then {
					(getNumber _configValue) isEqualTo 1
				} else {
					diag_log format ["[A3XAI] Error found in setting %1, resetting to default value.",_variableName];
					_defaultValue
				};
			};
			
			if ((_type isEqualTo "ARRAY") && {isArray _configValue}) exitWith {
				if (isArray _configValue) then {
					getArray _configValue
				} else {
					diag_log format ["[A3XAI] Error found in setting %1, resetting to default value.",_variableName];
					_defaultValue
				};
			};
			
			if ((_type isEqualTo "STRING") && {isText _configValue}) exitWith {
				if (isText _configValue) then {
					getText _configValue
				} else {
					diag_log format ["[A3XAI] Error found in setting %1, resetting to default value.",_variableName];
					_defaultValue
				};
			};
			
			if ((_type isEqualTo "SIDE") && {isText _configValue}) exitWith {
				_string = getText _configValue;
				call {
					if (_string == "east") exitWith {east};
					if (_string == "west") exitWith {west};
					if (_string == "resistance") exitWith {resistance};
					if (_string == "civilian") exitWith {civilian};
					diag_log format ["[A3XAI] Error found in setting %1, resetting to default value.",_variableName];
					_defaultValue
				};
			};

			_defaultValue
		};
	};
	_returnValue
};

{
	private ["_variableName", "_defaultValue", "_HCPushable", "_variableValue"];
	_variableName 	= _x select 0;
	_defaultValue 	= _x select 1;
	_HCPushable 	= [_x,2,false] call A3XAI_param;
	
	_variableValue = [_variableName,_defaultValue] call _fnc_getConfigValue;
	missionNamespace setVariable [format ["A3XAI_%1",_variableName],_variableValue];
	diag_log format ["Debug: %1 = %2",_variableName,_variableValue];
	if (_HCPushable) then {
		A3XAI_pushedHCVariables pushBack [_variableName,_variableValue];
		//diag_log format ["Debug: Found HC variable %1:%2",_variableName,_variableValue];
	};
} forEach [
	["debugLevel",0,true],
	["monitorReportRate",300,true],
	["verifyClassnames",true],
	["verifySettings",true],
	["cleanupDelay",900],
	["loadCustomFile",true],
	["minFPS",0],
	["groupManageMode",0],
	["enableHC",false,true],
	["waitForHC",false],
	["itemPriceLimit",2000],
	["generateDynamicWeapons",true],
	["dynamicWeaponBlacklist",[]],
	["generateDynamicOptics",true],
	["dynamicOpticsBlacklist",[]],
	["generateDynamicUniforms",true],
	["dynamicUniformBlacklist",[]],
	["generateDynamicBackpacks",true],
	["dynamicBackpackBlacklist",[]],
	["generateDynamicVests",true],
	["dynamicVestBlacklist",[]],
	["generateDynamicHeadgear",true],
	["dynamicHeadgearBlacklist",[]],
	["generateDynamicFood",true],
	["dynamicFoodBlacklist",[]],
	["generateDynamicMedical",true],
	["dynamicMedicalBlacklist",[]],
	["generateDynamicLoot",true],
	["dynamicLootBlacklist",[]],
	["enableRadioMessages",false,true],
	["side",east],
	["playerCountThreshold",10],
	["upwardsChanceScaling",true],
	["chanceScalingThreshold",0.50],
	["minAI_village",1],
	["addAI_village",1],
	["unitLevel_village",0],
	["spawnChance_village",0.40],
	["minAI_city",1],
	["addAI_city",2],
	["unitLevel_city",1],
	["spawnChance_city",0.60],
	["minAI_capitalCity",2],
	["addAI_capitalCity",1],
	["unitLevel_capitalCity",1],
	["spawnChance_capitalCity",0.70],
	["minAI_remoteArea",1],
	["addAI_remoteArea",2],
	["unitLevel_remoteArea",2],
	["spawnChance_remoteArea",0.80],
	["minAI_wilderness",1],
	["addAI_wilderness",1],
	["unitLevel_wilderness",2],
	["spawnChance_wilderness",0.50],
	["tempBlacklistTime",1200],
	["enableDeathMessages",false,true],
	["enableFindKiller",true,true],
	["enableTempNVGs",false],
	["levelRequiredGL",2,true],
	["levelRequiredLauncher",-1,true],
	["launcherTypes",[],true],
	["launchersPerGroup",1,true],
	["enableHealing",true],
	["removeExplosiveAmmo",true],
	["noCollisionDamage",true,true],
	["roadKillPenalty",true,true],
	["traderAreaLocations",[],true],
	["enableStaticSpawns",true],
	["enableExtraStaticSpawns",true],
	["useManualStaticSpawns",false],
	["manualStaticSpawnLocations",[]],
	["respawnTimeMin",300],
	["respawnTimeMax",600],
	["despawnWait",60],
	["staticLockoutTime",300],
	["respawnLimit_village",-1],
	["respawnLimit_city",-1],
	["respawnLimit_capitalCity",-1],
	["respawnLimit_remoteArea",-1],
	["maxDynamicSpawns",15],
	["timePerDynamicSpawn",900],
	["purgeLastDynamicSpawnTime",3600],
	["spawnHunterChance",0.60],
	["despawnDynamicSpawnTime",60],
	["maxRandomSpawns",-1],
	["despawnRandomSpawnTime",60],
	["distanceBetweenRandomSpawns",600],
	["vehicleDespawnTime",600],
	["vehiclesAllowedForPlayers",false],
	["waypointBlacklistAir",[],true],
	["waypointBlacklistLand",[],true],
	["maxAirPatrols",0],
	["levelChancesAir",[0.00,0.50,0.35,0.15]],
	["respawnAirMinTime",600],
	["respawnAirMaxTime",900],
	["airVehicleList",[
		["B_Heli_Light_01_armed_F",5],
		["B_Heli_Attack_01_F",2]
	]],
	["airGunnerUnits",2],
	["airDetectChance",0.80,true],
	["paradropChance",0.50,true],
	["paradropCooldown",1800,true],
	["paradropAmount",3,true],
	["maxLandPatrols",0],
	["levelChancesLand",[0.00,0.50,0.35,0.15]],
	["respawnLandMinTime",600],
	["respawnLandMaxTime",900],
	["landVehicleList",[
		["C_Hatchback_01_F",5],
		["C_Hatchback_01_sport_F",5],
		["C_Hatchback_01_grey_F",5],
		["C_Hatchback_01_green_F",5],
		["C_Hatchback_01_blue_F",5],
		["C_Hatchback_01_bluecustom_F",5],
		["C_Hatchback_01_beigecustom_F",5],
		["C_Offroad_01_F",5],
		["C_Offroad_01_repair_F",5],
		["B_G_Offroad_01_repair_F",5],
		["O_G_Offroad_01_repair_F",5],
		["I_G_Offroad_01_repair_F",5],
		["I_G_Offroad_01_F",5],
		["C_Hatchback_01_sport_white_F",5],
		["C_Hatchback_01_sport_grey_F",5],
		["C_Hatchback_01_sport_green_F",5],
		["C_SUV_01_F",5],
		["SUV_01_base_red_F",5],
		["SUV_01_base_black_F",5],
		["SUV_01_base_grey_F",5],
		["SUV_01_base_orange_F",5],
		["C_Van_01_transport_F",5],
		["I_G_Van_01_transport_F",5],
		["C_Van_01_box_F",5],
		["C_Van_01_fuel_F",5],
		["I_G_Van_01_fuel_F",5],
		["B_G_Van_01_transport_F",5],
		["O_G_Van_01_transport_F",5],
		["B_G_Van_01_fuel_F",5],
		["O_G_Van_01_fuel_F",5],
		["C_Van_01_transport_white_F",5],
		["C_Van_01_transport_red_F",5],
		["C_Van_01_box_white_F",5],
		["C_Van_01_box_red_F",5],
		["C_Van_01_fuel_white_F",5],
		["C_Van_01_fuel_red_F",5],
		["C_Van_01_fuel_white_v2_F",5],
		["C_Van_01_fuel_red_v2_F",5],
		["I_C_Van_01_transport_F",5],
		["I_C_Van_01_transport_brown_F",5],
		["I_C_Van_01_transport_olive_F",5],
		["C_Offroad_01_F",5],
		["C_Offroad_01_repair_F",5],
		["B_G_Offroad_01_repair_F",5],
		["O_G_Offroad_01_repair_F",5],
		["I_G_Offroad_01_repair_F",5],
		["I_G_Offroad_01_F",5]
	]],
	["landGunnerUnits",2],
	["landCargoUnits",3],
	["maxAirReinforcements",5],
	["airReinforcementVehicles",[
		"B_Heli_Transport_01_F",
		"B_Heli_Light_01_armed_F"
	]],
	["airReinforcementSpawnChance0",0.00],
	["airReinforcementSpawnChance1",0.10],
	["airReinforcementSpawnChance2",0.20],
	["airReinforcementSpawnChance3",0.30],
	["airReinforcementAllowedFor",["static","dynamic","random"]],
	["airReinforceDeployChance0",0.60],
	["airReinforceDeployChance1",0.70],
	["airReinforceDeployChance2",0.80],
	["airReinforceDeployChance3",0.90],
	["airReinforcementDuration0",120],
	["airReinforcementDuration1",180],
	["airReinforcementDuration2",240],
	["airReinforcementDuration3",300],
	["maxUAVPatrols",0],
	["UAVList",[
		["I_UAV_02_CAS_F",5],
		["I_UAV_02_F",5],
		["B_UAV_02_CAS_F",5],
		["B_UAV_02_F",5],
		["O_UAV_02_CAS_F",5],
		["O_UAV_02_F",5]
	]],
	["levelChancesUAV",[0.35,0.50,0.15,0.00]],
	["respawnUAVMinTime",600],
	["respawnUAVMaxTime",900],
	["UAVCallReinforceCooldown",1800,true],
	["UAVDetectChance",0.80,true],
	["maxUGVPatrols",0],
	["UGVList",[
		["I_UGV_01_rcws_F",5],
		["B_UGV_01_rcws_F",5],
		["O_UGV_01_rcws_F",5]
	]],
	["levelChancesUGV",[0.35,0.50,0.15,0.00]],
	["respawnUGVMinTime",600],
	["respawnUGVMaxTime",900],
	["UGVCallReinforceCooldown",1800,true],
	["UGVDetectChance",0.80,true],	
	["skill0",[	
		["aimingAccuracy",0.05,0.10],
		["aimingShake",0.30,0.50],
		["aimingSpeed",0.30,0.50],
		["spotDistance",0.30,0.50],
		["spotTime",0.30,0.50],
		["courage",0.30,0.50],
		["reloadSpeed",0.30,0.50],
		["commanding",0.30,0.50],
		["general",0.30,0.50]
	]],
	["skill1",[	
		["aimingAccuracy",0.05,0.10],
		["aimingShake",0.40,0.60],
		["aimingSpeed",0.40,0.60],
		["spotDistance",0.40,0.60],
		["spotTime",0.40,0.60],
		["courage",0.40,0.60],
		["reloadSpeed",0.40,0.60],
		["commanding",0.40,0.60],
		["general",0.40,0.60]
	]],
	["skill2",[	
		["aimingAccuracy",0.15,0.20],
		["aimingShake",0.50,0.70],
		["aimingSpeed",0.50,0.70],
		["spotDistance",0.50,0.70],
		["spotTime",0.50,0.70],
		["courage",0.50,0.70],
		["reloadSpeed",0.50,0.70],
		["commanding",0.50,0.70],
		["general",0.50,0.70]
	]],
	["skill3",[	
		["aimingAccuracy",0.20,0.25],
		["aimingShake",0.60,0.80],
		["aimingSpeed",0.60,0.80],
		["spotDistance",0.60,0.80],
		["spotTime",0.60,0.80],
		["courage",0.60,0.80],
		["reloadSpeed",0.60,0.80],
		["commanding",0.60,0.80],
		["general",0.60,0.80]
	]],
	["addBackpackChance0",0.60],
	["addBackpackChance1",0.70],
	["addBackpackChance2",0.80],
	["addBackpackChance3",0.90],
	["addVestChance0",0.60],
	["addVestChance1",0.70],
	["addVestChance2",0.80],
	["addVestChance3",0.90],
	["addHeadgearChance0",0.60],
	["addHeadgearChance1",0.70],
	["addHeadgearChance2",0.80],
	["addHeadgearChance3",0.90],
	["useWeaponChance0",[0.20,0.80,0.00,0.00]],
	["useWeaponChance1",[0.00,0.90,0.05,0.05]],
	["useWeaponChance2",[0.00,0.80,0.10,0.10]],
	["useWeaponChance3",[0.00,0.70,0.15,0.15]],
	["opticsChance0",0.00],
	["opticsChance1",0.30],
	["opticsChance2",0.60],
	["opticsChance3",0.90],
	["pointerChance0",0.00],
	["pointerChance1",0.30],
	["pointerChance2",0.60],
	["pointerChance3",0.90],
	["muzzleChance0",0.00],
	["muzzleChance1",0.30],
	["muzzleChance2",0.60],
	["muzzleChance3",0.90],
	["underbarrelChance0",0.00],
	["underbarrelChance1",0.30],
	["underbarrelChance2",0.60],
	["underbarrelChance3",0.90],
	["foodLootCount",2],
	["miscLootCount",2],
	["medicalLootCount",1],
	["weaponLootVehicleCount",6],
	["ammoLootPerWeapon",3],
	["foodLootVehicleCount",6],
	["miscLootVehicleCount",6],
	["medicalLootVehicleCount",3],
	["lootPullChance0",0.20,true],
	["lootPullChance1",0.40,true],
	["lootPullChance2",0.60,true],
	["lootPullChance3",0.80,true],
	["enableRespectRewards",true],
	["respectHumiliation",300],
	["respectFragged",100],
	["respectChute",600],
	["respectBigBird",600],
	["respectRoadkill",500],
	["respectLetItRain",150],
	["respectKillstreak",50],
	["respectPer100m",10],
	["uniformTypes0",["U_C_Journalist","U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_salmon","U_C_Poloshirt_stripped","U_C_Poloshirt_tricolour","U_C_Poor_1","U_C_Poor_2","U_C_Poor_shorts_1","U_C_Scientist","U_OrestesBody","U_Rangemaster","U_NikosAgedBody","U_NikosBody","U_Competitor","U_B_CombatUniform_mcam","U_B_CombatUniform_mcam_tshirt","U_B_CombatUniform_mcam_vest","U_B_CombatUniform_mcam_worn","U_B_CTRG_1","U_B_CTRG_2","U_B_CTRG_3","U_I_CombatUniform","U_I_CombatUniform_shortsleeve","U_I_CombatUniform_tshirt","U_I_OfficerUniform","U_O_CombatUniform_ocamo","U_O_CombatUniform_oucamo","U_O_OfficerUniform_ocamo","U_B_SpecopsUniform_sgg","U_O_SpecopsUniform_blk","U_O_SpecopsUniform_ocamo","U_I_G_Story_Protagonist_F","U_C_HunterBody_grn","U_IG_Guerilla1_1","U_IG_Guerilla2_1","U_IG_Guerilla2_2","U_IG_Guerilla2_3","U_IG_Guerilla3_1","U_BG_Guerilla2_1","U_IG_Guerilla3_2","U_BG_Guerrilla_6_1","U_BG_Guerilla1_1","U_BG_Guerilla2_2","U_BG_Guerilla2_3","U_BG_Guerilla3_1"]],
	["uniformTypes1",["U_C_Journalist","U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_salmon","U_C_Poloshirt_stripped","U_C_Poloshirt_tricolour","U_C_Poor_1","U_C_Poor_2","U_C_Poor_shorts_1","U_C_Scientist","U_OrestesBody","U_Rangemaster","U_NikosAgedBody","U_NikosBody","U_Competitor","U_B_CombatUniform_mcam","U_B_CombatUniform_mcam_tshirt","U_B_CombatUniform_mcam_vest","U_B_CombatUniform_mcam_worn","U_B_CTRG_1","U_B_CTRG_2","U_B_CTRG_3","U_I_CombatUniform","U_I_CombatUniform_shortsleeve","U_I_CombatUniform_tshirt","U_I_OfficerUniform","U_O_CombatUniform_ocamo","U_O_CombatUniform_oucamo","U_O_OfficerUniform_ocamo","U_B_SpecopsUniform_sgg","U_O_SpecopsUniform_blk","U_O_SpecopsUniform_ocamo","U_I_G_Story_Protagonist_F","U_C_HunterBody_grn","U_IG_Guerilla1_1","U_IG_Guerilla2_1","U_IG_Guerilla2_2","U_IG_Guerilla2_3","U_IG_Guerilla3_1","U_BG_Guerilla2_1","U_IG_Guerilla3_2","U_BG_Guerrilla_6_1","U_BG_Guerilla1_1","U_BG_Guerilla2_2","U_BG_Guerilla2_3","U_BG_Guerilla3_1"]],
	["uniformTypes2",["U_C_Journalist","U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_salmon","U_C_Poloshirt_stripped","U_C_Poloshirt_tricolour","U_C_Poor_1","U_C_Poor_2","U_C_Poor_shorts_1","U_C_Scientist","U_OrestesBody","U_Rangemaster","U_NikosAgedBody","U_NikosBody","U_Competitor","U_B_CombatUniform_mcam","U_B_CombatUniform_mcam_tshirt","U_B_CombatUniform_mcam_vest","U_B_CombatUniform_mcam_worn","U_B_CTRG_1","U_B_CTRG_2","U_B_CTRG_3","U_I_CombatUniform","U_I_CombatUniform_shortsleeve","U_I_CombatUniform_tshirt","U_I_OfficerUniform","U_O_CombatUniform_ocamo","U_O_CombatUniform_oucamo","U_O_OfficerUniform_ocamo","U_B_SpecopsUniform_sgg","U_O_SpecopsUniform_blk","U_O_SpecopsUniform_ocamo","U_I_G_Story_Protagonist_F","U_C_HunterBody_grn","U_IG_Guerilla1_1","U_IG_Guerilla2_1","U_IG_Guerilla2_2","U_IG_Guerilla2_3","U_IG_Guerilla3_1","U_BG_Guerilla2_1","U_IG_Guerilla3_2","U_BG_Guerrilla_6_1","U_BG_Guerilla1_1","U_BG_Guerilla2_2","U_BG_Guerilla2_3","U_BG_Guerilla3_1"]],
	["uniformTypes3",["U_C_Journalist","U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_salmon","U_C_Poloshirt_stripped","U_C_Poloshirt_tricolour","U_C_Poor_1","U_C_Poor_2","U_C_Poor_shorts_1","U_C_Scientist","U_OrestesBody","U_Rangemaster","U_NikosAgedBody","U_NikosBody","U_Competitor","U_B_CombatUniform_mcam","U_B_CombatUniform_mcam_tshirt","U_B_CombatUniform_mcam_vest","U_B_CombatUniform_mcam_worn","U_B_CTRG_1","U_B_CTRG_2","U_B_CTRG_3","U_I_CombatUniform","U_I_CombatUniform_shortsleeve","U_I_CombatUniform_tshirt","U_I_OfficerUniform","U_O_CombatUniform_ocamo","U_O_CombatUniform_oucamo","U_O_OfficerUniform_ocamo","U_B_SpecopsUniform_sgg","U_O_SpecopsUniform_blk","U_O_SpecopsUniform_ocamo","U_I_G_Story_Protagonist_F","U_C_HunterBody_grn","U_IG_Guerilla1_1","U_IG_Guerilla2_1","U_IG_Guerilla2_2","U_IG_Guerilla2_3","U_IG_Guerilla3_1","U_BG_Guerilla2_1","U_IG_Guerilla3_2","U_BG_Guerrilla_6_1","U_BG_Guerilla1_1","U_BG_Guerilla2_2","U_BG_Guerilla2_3","U_BG_Guerilla3_1"]],
	["pistolList",["hgun_ACPC2_F","hgun_P07_F","hgun_Pistol_heavy_01_F","hgun_Pistol_heavy_02_F","hgun_Rook40_F"]],
	["rifleList",["arifle_Katiba_C_F","arifle_Katiba_F","arifle_Katiba_GL_F","arifle_Mk20_F","arifle_Mk20_GL_F","arifle_Mk20_GL_plain_F","arifle_Mk20_plain_F","arifle_Mk20C_F","arifle_Mk20C_plain_F","arifle_MX_Black_F","arifle_MX_F","arifle_MX_GL_Black_F","arifle_MX_GL_F","arifle_MXC_Black_F","arifle_MXC_F","arifle_SDAR_F","arifle_TRG20_F","arifle_TRG21_F","arifle_TRG21_GL_F"]],
	["machinegunList",["arifle_MX_SW_Black_F","arifle_MX_SW_F","LMG_Mk200_F","LMG_Zafir_F","MMG_01_hex_F","MMG_01_tan_F","MMG_02_black_F","MMG_02_camo_F","MMG_02_sand_F"]],
	["sniperList",["arifle_MXM_Black_F","arifle_MXM_F","srifle_DMR_01_F","srifle_DMR_02_camo_F","srifle_DMR_02_F","srifle_DMR_02_sniper_F","srifle_DMR_03_F","srifle_DMR_03_khaki_F","srifle_DMR_03_multicam_F","srifle_DMR_03_tan_F","srifle_DMR_03_woodland_F","srifle_DMR_04_F","srifle_DMR_04_Tan_F","srifle_DMR_05_blk_F","srifle_DMR_05_hex_F","srifle_DMR_05_tan_f","srifle_DMR_06_camo_F","srifle_DMR_06_olive_F","srifle_EBR_F","srifle_GM6_camo_F","srifle_GM6_F","srifle_LRR_camo_F","srifle_LRR_F"]],
	["weaponOpticsList",["optic_NVS","optic_SOS","optic_LRPS","optic_AMS","optic_AMS_khk","optic_AMS_snd","optic_KHS_blk","optic_KHS_hex","optic_KHS_old","optic_KHS_tan","optic_DMS","optic_Arco","optic_Hamr","optic_MRCO","optic_Holosight","optic_Holosight_smg","optic_Aco","optic_ACO_grn","optic_Aco_smg","optic_ACO_grn_smg","optic_Yorris","optic_MRD"]],
	["backpackTypes0",["B_AssaultPack_blk","B_AssaultPack_cbr","B_AssaultPack_dgtl","B_AssaultPack_khk","B_AssaultPack_mcamo","B_AssaultPack_rgr","B_AssaultPack_sgg","B_Bergen_blk","B_Bergen_mcamo","B_Bergen_rgr","B_Bergen_sgg","B_Carryall_cbr","B_Carryall_khk","B_Carryall_mcamo","B_Carryall_ocamo","B_Carryall_oli","B_Carryall_oucamo","B_FieldPack_blk","B_FieldPack_cbr","B_FieldPack_ocamo","B_FieldPack_oucamo","B_HuntingBackpack","B_Kitbag_cbr","B_Kitbag_mcamo","B_Kitbag_sgg","B_OutdoorPack_blk","B_OutdoorPack_blu","B_OutdoorPack_tan","B_TacticalPack_blk","B_TacticalPack_mcamo","B_TacticalPack_ocamo","B_TacticalPack_oli","B_TacticalPack_rgr"]],
	["backpackTypes1",["B_AssaultPack_blk","B_AssaultPack_cbr","B_AssaultPack_dgtl","B_AssaultPack_khk","B_AssaultPack_mcamo","B_AssaultPack_rgr","B_AssaultPack_sgg","B_Bergen_blk","B_Bergen_mcamo","B_Bergen_rgr","B_Bergen_sgg","B_Carryall_cbr","B_Carryall_khk","B_Carryall_mcamo","B_Carryall_ocamo","B_Carryall_oli","B_Carryall_oucamo","B_FieldPack_blk","B_FieldPack_cbr","B_FieldPack_ocamo","B_FieldPack_oucamo","B_HuntingBackpack","B_Kitbag_cbr","B_Kitbag_mcamo","B_Kitbag_sgg","B_OutdoorPack_blk","B_OutdoorPack_blu","B_OutdoorPack_tan","B_TacticalPack_blk","B_TacticalPack_mcamo","B_TacticalPack_ocamo","B_TacticalPack_oli","B_TacticalPack_rgr"]],
	["backpackTypes2",["B_AssaultPack_blk","B_AssaultPack_cbr","B_AssaultPack_dgtl","B_AssaultPack_khk","B_AssaultPack_mcamo","B_AssaultPack_rgr","B_AssaultPack_sgg","B_Bergen_blk","B_Bergen_mcamo","B_Bergen_rgr","B_Bergen_sgg","B_Carryall_cbr","B_Carryall_khk","B_Carryall_mcamo","B_Carryall_ocamo","B_Carryall_oli","B_Carryall_oucamo","B_FieldPack_blk","B_FieldPack_cbr","B_FieldPack_ocamo","B_FieldPack_oucamo","B_HuntingBackpack","B_Kitbag_cbr","B_Kitbag_mcamo","B_Kitbag_sgg","B_OutdoorPack_blk","B_OutdoorPack_blu","B_OutdoorPack_tan","B_TacticalPack_blk","B_TacticalPack_mcamo","B_TacticalPack_ocamo","B_TacticalPack_oli","B_TacticalPack_rgr"]],
	["backpackTypes3",["B_AssaultPack_blk","B_AssaultPack_cbr","B_AssaultPack_dgtl","B_AssaultPack_khk","B_AssaultPack_mcamo","B_AssaultPack_rgr","B_AssaultPack_sgg","B_Bergen_blk","B_Bergen_mcamo","B_Bergen_rgr","B_Bergen_sgg","B_Carryall_cbr","B_Carryall_khk","B_Carryall_mcamo","B_Carryall_ocamo","B_Carryall_oli","B_Carryall_oucamo","B_FieldPack_blk","B_FieldPack_cbr","B_FieldPack_ocamo","B_FieldPack_oucamo","B_HuntingBackpack","B_Kitbag_cbr","B_Kitbag_mcamo","B_Kitbag_sgg","B_OutdoorPack_blk","B_OutdoorPack_blu","B_OutdoorPack_tan","B_TacticalPack_blk","B_TacticalPack_mcamo","B_TacticalPack_ocamo","B_TacticalPack_oli","B_TacticalPack_rgr"]],
	["vestTypes0",["V_Press_F","V_Rangemaster_belt","V_TacVest_blk","V_TacVest_blk_POLICE","V_TacVest_brn","V_TacVest_camo","V_TacVest_khk","V_TacVest_oli","V_TacVestCamo_khk","V_TacVestIR_blk","V_I_G_resistanceLeader_F","V_BandollierB_blk","V_BandollierB_cbr","V_BandollierB_khk","V_BandollierB_oli","V_BandollierB_rgr","V_Chestrig_blk","V_Chestrig_khk","V_Chestrig_oli","V_Chestrig_rgr","V_HarnessO_brn","V_HarnessO_gry","V_HarnessOGL_brn","V_HarnessOGL_gry","V_HarnessOSpec_brn","V_HarnessOSpec_gry","V_PlateCarrier1_blk","V_PlateCarrier1_rgr","V_PlateCarrier2_rgr","V_PlateCarrier3_rgr","V_PlateCarrierGL_blk","V_PlateCarrierGL_mtp","V_PlateCarrierGL_rgr","V_PlateCarrierH_CTRG","V_PlateCarrierIA1_dgtl","V_PlateCarrierIA2_dgtl","V_PlateCarrierIAGL_dgtl","V_PlateCarrierIAGL_oli","V_PlateCarrierL_CTRG","V_PlateCarrierSpec_blk","V_PlateCarrierSpec_mtp","V_PlateCarrierSpec_rgr"]],
	["vestTypes1",["V_Press_F","V_Rangemaster_belt","V_TacVest_blk","V_TacVest_blk_POLICE","V_TacVest_brn","V_TacVest_camo","V_TacVest_khk","V_TacVest_oli","V_TacVestCamo_khk","V_TacVestIR_blk","V_I_G_resistanceLeader_F","V_BandollierB_blk","V_BandollierB_cbr","V_BandollierB_khk","V_BandollierB_oli","V_BandollierB_rgr","V_Chestrig_blk","V_Chestrig_khk","V_Chestrig_oli","V_Chestrig_rgr","V_HarnessO_brn","V_HarnessO_gry","V_HarnessOGL_brn","V_HarnessOGL_gry","V_HarnessOSpec_brn","V_HarnessOSpec_gry","V_PlateCarrier1_blk","V_PlateCarrier1_rgr","V_PlateCarrier2_rgr","V_PlateCarrier3_rgr","V_PlateCarrierGL_blk","V_PlateCarrierGL_mtp","V_PlateCarrierGL_rgr","V_PlateCarrierH_CTRG","V_PlateCarrierIA1_dgtl","V_PlateCarrierIA2_dgtl","V_PlateCarrierIAGL_dgtl","V_PlateCarrierIAGL_oli","V_PlateCarrierL_CTRG","V_PlateCarrierSpec_blk","V_PlateCarrierSpec_mtp","V_PlateCarrierSpec_rgr"]],
	["vestTypes2",["V_Press_F","V_Rangemaster_belt","V_TacVest_blk","V_TacVest_blk_POLICE","V_TacVest_brn","V_TacVest_camo","V_TacVest_khk","V_TacVest_oli","V_TacVestCamo_khk","V_TacVestIR_blk","V_I_G_resistanceLeader_F","V_BandollierB_blk","V_BandollierB_cbr","V_BandollierB_khk","V_BandollierB_oli","V_BandollierB_rgr","V_Chestrig_blk","V_Chestrig_khk","V_Chestrig_oli","V_Chestrig_rgr","V_HarnessO_brn","V_HarnessO_gry","V_HarnessOGL_brn","V_HarnessOGL_gry","V_HarnessOSpec_brn","V_HarnessOSpec_gry","V_PlateCarrier1_blk","V_PlateCarrier1_rgr","V_PlateCarrier2_rgr","V_PlateCarrier3_rgr","V_PlateCarrierGL_blk","V_PlateCarrierGL_mtp","V_PlateCarrierGL_rgr","V_PlateCarrierH_CTRG","V_PlateCarrierIA1_dgtl","V_PlateCarrierIA2_dgtl","V_PlateCarrierIAGL_dgtl","V_PlateCarrierIAGL_oli","V_PlateCarrierL_CTRG","V_PlateCarrierSpec_blk","V_PlateCarrierSpec_mtp","V_PlateCarrierSpec_rgr"]],
	["vestTypes3",["V_Press_F","V_Rangemaster_belt","V_TacVest_blk","V_TacVest_blk_POLICE","V_TacVest_brn","V_TacVest_camo","V_TacVest_khk","V_TacVest_oli","V_TacVestCamo_khk","V_TacVestIR_blk","V_I_G_resistanceLeader_F","V_BandollierB_blk","V_BandollierB_cbr","V_BandollierB_khk","V_BandollierB_oli","V_BandollierB_rgr","V_Chestrig_blk","V_Chestrig_khk","V_Chestrig_oli","V_Chestrig_rgr","V_HarnessO_brn","V_HarnessO_gry","V_HarnessOGL_brn","V_HarnessOGL_gry","V_HarnessOSpec_brn","V_HarnessOSpec_gry","V_PlateCarrier1_blk","V_PlateCarrier1_rgr","V_PlateCarrier2_rgr","V_PlateCarrier3_rgr","V_PlateCarrierGL_blk","V_PlateCarrierGL_mtp","V_PlateCarrierGL_rgr","V_PlateCarrierH_CTRG","V_PlateCarrierIA1_dgtl","V_PlateCarrierIA2_dgtl","V_PlateCarrierIAGL_dgtl","V_PlateCarrierIAGL_oli","V_PlateCarrierL_CTRG","V_PlateCarrierSpec_blk","V_PlateCarrierSpec_mtp","V_PlateCarrierSpec_rgr"]],
	["headgearTypes0",["H_Cap_blk","H_Cap_blk_Raven","H_Cap_blu","H_Cap_brn_SPECOPS","H_Cap_grn","H_Cap_headphones","H_Cap_khaki_specops_UK","H_Cap_oli","H_Cap_press","H_Cap_red","H_Cap_tan","H_Cap_tan_specops_US","H_Watchcap_blk","H_Watchcap_camo","H_Watchcap_khk","H_Watchcap_sgg","H_MilCap_blue","H_MilCap_dgtl","H_MilCap_mcamo","H_MilCap_ocamo","H_MilCap_oucamo","H_MilCap_rucamo","H_Bandanna_camo","H_Bandanna_cbr","H_Bandanna_gry","H_Bandanna_khk","H_Bandanna_khk_hs","H_Bandanna_mcamo","H_Bandanna_sgg","H_Bandanna_surfer","H_Booniehat_dgtl","H_Booniehat_dirty","H_Booniehat_grn","H_Booniehat_indp","H_Booniehat_khk","H_Booniehat_khk_hs","H_Booniehat_mcamo","H_Booniehat_tan","H_Hat_blue","H_Hat_brown","H_Hat_camo","H_Hat_checker","H_Hat_grey","H_Hat_tan","H_StrawHat","H_StrawHat_dark","H_Beret_02","H_Beret_blk","H_Beret_blk_POLICE","H_Beret_brn_SF","H_Beret_Colonel","H_Beret_grn","H_Beret_grn_SF","H_Beret_ocamo","H_Beret_red","H_Shemag_khk","H_Shemag_olive","H_Shemag_olive_hs"]],
	["headgearTypes1",["H_Cap_blk","H_Cap_blk_Raven","H_Cap_blu","H_Cap_brn_SPECOPS","H_Cap_grn","H_Cap_headphones","H_Cap_khaki_specops_UK","H_Cap_oli","H_Cap_press","H_Cap_red","H_Cap_tan","H_Cap_tan_specops_US","H_Watchcap_blk","H_Watchcap_camo","H_Watchcap_khk","H_Watchcap_sgg","H_MilCap_blue","H_MilCap_dgtl","H_MilCap_mcamo","H_MilCap_ocamo","H_MilCap_oucamo","H_MilCap_rucamo","H_Bandanna_camo","H_Bandanna_cbr","H_Bandanna_gry","H_Bandanna_khk","H_Bandanna_khk_hs","H_Bandanna_mcamo","H_Bandanna_sgg","H_Bandanna_surfer","H_Booniehat_dgtl","H_Booniehat_dirty","H_Booniehat_grn","H_Booniehat_indp","H_Booniehat_khk","H_Booniehat_khk_hs","H_Booniehat_mcamo","H_Booniehat_tan","H_Hat_blue","H_Hat_brown","H_Hat_camo","H_Hat_checker","H_Hat_grey","H_Hat_tan","H_StrawHat","H_StrawHat_dark","H_Beret_02","H_Beret_blk","H_Beret_blk_POLICE","H_Beret_brn_SF","H_Beret_Colonel","H_Beret_grn","H_Beret_grn_SF","H_Beret_ocamo","H_Beret_red","H_Shemag_khk","H_Shemag_olive","H_Shemag_olive_hs"]],
	["headgearTypes2",["H_Cap_blk","H_Cap_blk_Raven","H_Cap_blu","H_Cap_brn_SPECOPS","H_Cap_grn","H_Cap_headphones","H_Cap_khaki_specops_UK","H_Cap_oli","H_Cap_press","H_Cap_red","H_Cap_tan","H_Cap_tan_specops_US","H_Watchcap_blk","H_Watchcap_camo","H_Watchcap_khk","H_Watchcap_sgg","H_MilCap_blue","H_MilCap_dgtl","H_MilCap_mcamo","H_MilCap_ocamo","H_MilCap_oucamo","H_MilCap_rucamo","H_Bandanna_camo","H_Bandanna_cbr","H_Bandanna_gry","H_Bandanna_khk","H_Bandanna_khk_hs","H_Bandanna_mcamo","H_Bandanna_sgg","H_Bandanna_surfer","H_Booniehat_dgtl","H_Booniehat_dirty","H_Booniehat_grn","H_Booniehat_indp","H_Booniehat_khk","H_Booniehat_khk_hs","H_Booniehat_mcamo","H_Booniehat_tan","H_Hat_blue","H_Hat_brown","H_Hat_camo","H_Hat_checker","H_Hat_grey","H_Hat_tan","H_StrawHat","H_StrawHat_dark","H_Beret_02","H_Beret_blk","H_Beret_blk_POLICE","H_Beret_brn_SF","H_Beret_Colonel","H_Beret_grn","H_Beret_grn_SF","H_Beret_ocamo","H_Beret_red","H_Shemag_khk","H_Shemag_olive","H_Shemag_olive_hs"]],
	["headgearTypes3",["H_Cap_blk","H_Cap_blk_Raven","H_Cap_blu","H_Cap_brn_SPECOPS","H_Cap_grn","H_Cap_headphones","H_Cap_khaki_specops_UK","H_Cap_oli","H_Cap_press","H_Cap_red","H_Cap_tan","H_Cap_tan_specops_US","H_Watchcap_blk","H_Watchcap_camo","H_Watchcap_khk","H_Watchcap_sgg","H_MilCap_blue","H_MilCap_dgtl","H_MilCap_mcamo","H_MilCap_ocamo","H_MilCap_oucamo","H_MilCap_rucamo","H_Bandanna_camo","H_Bandanna_cbr","H_Bandanna_gry","H_Bandanna_khk","H_Bandanna_khk_hs","H_Bandanna_mcamo","H_Bandanna_sgg","H_Bandanna_surfer","H_Booniehat_dgtl","H_Booniehat_dirty","H_Booniehat_grn","H_Booniehat_indp","H_Booniehat_khk","H_Booniehat_khk_hs","H_Booniehat_mcamo","H_Booniehat_tan","H_Hat_blue","H_Hat_brown","H_Hat_camo","H_Hat_checker","H_Hat_grey","H_Hat_tan","H_StrawHat","H_StrawHat_dark","H_Beret_02","H_Beret_blk","H_Beret_blk_POLICE","H_Beret_brn_SF","H_Beret_Colonel","H_Beret_grn","H_Beret_grn_SF","H_Beret_ocamo","H_Beret_red","H_Shemag_khk","H_Shemag_olive","H_Shemag_olive_hs"]],
	["foodLoot",["DSR_Item_Bacon","DSR_Item_Beans","DSR_Item_Cereal","DSR_Item_Deviled_Ham","DSR_Item_Rice","DSR_Item_tuna","DSR_Item_MRE","DSR_Item_Can_Chicken","DSR_Item_Can_Clams","DSR_Item_Powdered_Milk","DSR_Item_Instant_Coffee","DSR_Item_Ration","DSR_Item_Bacon","DSR_Item_Beans","DSR_Item_Cereal","DSR_Item_Deviled_Ham","DSR_Item_Rice","DSR_Item_tuna","DSR_Item_MRE","DSR_Item_Can_Chicken","DSR_Item_Can_Clams","DSR_Item_Powdered_Milk","DSR_Item_Instant_Coffee","DSR_Item_Ration","DSR_Item_Bacon","DSR_Item_Beans","DSR_Item_Cereal","DSR_Item_Deviled_Ham","DSR_Item_Rice","DSR_Item_tuna"]],
	["miscLoot",["20Rnd_762x51_Mag","20Rnd_762x51_Mag","20Rnd_762x51_Mag","6Rnd_12g_Buck","6Rnd_12g_Buck","DSR_Item_MRE","20Rnd_762x51_Mag","20Rnd_762x51_Mag","20Rnd_762x51_Mag","7Rnd_308win_mag","7Rnd_308win_mag","7Rnd_308win_mag","DSR_Item_Bloodbag_Full","DSR_Item_Bandage","DSR_Item_MRE","7Rnd_408_Mag","7Rnd_408_Mag","7Rnd_408_Mag","ItemMap","DSR_Item_Bloodbag_Full","DSR_Item_Bandage","DSR_Item_MRE","20Rnd_762x51_Mag","20Rnd_762x51_Mag","20Rnd_762x51_Mag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","DSR_Item_MRE","DSR_Item_Bloodbag_Full","DSR_Item_Bloodbag_Full","DSR_Item_Morphine","DSR_Item_Morphine","DSR_Item_Morphine","DSR_Item_Bandage","DSR_Item_Bandage","DSR_Item_Bandage","DSR_Item_Painkillers","DSR_Item_Painkillers","DSR_Item_Painkillers","DSR_Item_Antibiotic","DSR_Item_Bloodbag_Full","DSR_Item_Bloodbag_Full","DSR_Item_Bloodbag_Full","DSR_Item_Bandage","DSR_Item_Bandage","DSR_Item_Bandage","DSR_Item_Disinfectant","DSR_Item_Painkillers","DSR_Item_Painkillers","FirstAidKit","7Rnd_308win_mag","7Rnd_308win_mag","10Rnd_762x54_Mag","6Rnd_12g_Buck","6Rnd_44_Mag","6Rnd_44_Mag","30Rnd_545x39_Mag_F","30Rnd_545x39_Mag_F","30Rnd_545x39_Mag_F","30Rnd_762x39_Mag_F","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","32Rnd_9x19mm_Mag","30Rnd_9x21_Mag","30Rnd_9x21_Mag","20Rnd_762x51_Mag","20Rnd_762x51_Mag","20Rnd_762x51_Mag","DSR_Melee_Axe","DSR_Melee_Axe","DSR_Melee_Pickaxe","DSR_Item_Bricks","DSR_Item_Bricks","DSR_Item_Toolbox","DSR_Item_Saw","DSR_Item_Hardware","DSR_Item_Hardware","DSR_Item_Hardware","DSR_Item_Hardware","DSR_Item_Scrap_Metal","DSR_Item_Scrap_Metal","DSR_Item_Padlock","DSR_Item_Tarp","DSR_Item_Tarp","DSR_Item_Duct_Tape","DSR_Item_Fabric_Scraps","DSR_Item_Fabric_Scraps","DSR_Item_Electrical_Comp","DSR_Item_Engine_Block","DSR_Item_Tire_RepairKit","DSR_Item_Tire_RepairKit","DSR_Item_Gascan_Small_Full","DSR_Item_Wrench","DSR_Item_Glass_Part","DSR_Item_Glass_Part","DSR_Item_Beans","DSR_Item_Cereal","DSR_Item_Powdered_Milk","DSR_Item_Rice","DSR_Item_Bacon","DSR_Item_Waterbottle_Full","DSR_Item_Canteen_Full","DSR_Item_Spirit","DSR_Item_Franta","DSR_Item_Can_Opener","DSR_Item_Water_Purification_Tablets","DSR_Item_Vitamins","20Rnd_762x51_Mag","20Rnd_762x51_Mag","20Rnd_762x51_Mag","6Rnd_12g_Buck","6Rnd_12g_Buck","DSR_Item_MRE"]],
	["medicalLoot",["DSR_Item_Bandage","DSR_Item_Painkillers","DSR_Item_Antibiotic","DSR_Item_Bloodbag_Full","DSR_Item_Disinfectant"]],
	["toolsList0",[["ItemGPS",0.90],["ItemCompass",0.50],["ItemMap",0.50],["ItemGPS",0.05],["ItemRadio",0.05]]],
	["toolsList1",[["ItemGPS",0.90],["ItemCompass",0.60],["ItemMap",0.60],["ItemGPS",0.10],["ItemRadio",0.10]]],
	["toolsList2",[["ItemGPS",0.90],["ItemCompass",0.70],["ItemMap",0.70],["ItemGPS",0.15],["ItemRadio",0.15]]],
	["toolsList3",[["ItemGPS",0.90],["ItemCompass",0.80],["ItemMap",0.80],["ItemGPS",0.20],["ItemRadio",0.20]]],
	["gadgetsList0",[["binocular",0.40],["NVGoggles",0.05]]],
	["gadgetsList1",[["binocular",0.50],["NVGoggles",0.10]]],
	["gadgetsList2",[["binocular",0.60],["NVGoggles",0.15]]],
	["gadgetsList3",[["binocular",0.70],["NVGoggles",0.20]]]
];

if (A3XAI_verifySettings) then {
	if !(A3XAI_unitLevel_capitalCity in [0,1,2,3]) then {diag_log format ["[A3XAI] Error found in variable A3XAI_unitLevel_capitalCity, resetting to default value."]; A3XAI_unitLevel_capitalCity = 1};
	if !(A3XAI_unitLevel_city in [0,1,2,3]) then {diag_log format ["[A3XAI] Error found in variable A3XAI_unitLevel_city, resetting to default value."]; A3XAI_unitLevel_city = 1};
	if !(A3XAI_unitLevel_village in [0,1,2,3]) then {diag_log format ["[A3XAI] Error found in variable A3XAI_unitLevel_village, resetting to default value."]; A3XAI_unitLevel_village = 0};
	if !(A3XAI_unitLevel_remoteArea in [0,1,2,3]) then {diag_log format ["[A3XAI] Error found in variable A3XAI_unitLevel_remoteArea, resetting to default value."]; A3XAI_unitLevel_remoteArea = 2};
	if !(A3XAI_unitLevel_wilderness in [0,1,2,3]) then {diag_log format ["[A3XAI] Error found in variable A3XAI_unitLevel_remoteArea, resetting to default value."]; A3XAI_unitLevel_wilderness = 2};
	if !((count A3XAI_levelChancesAir) isEqualTo 4) then {diag_log format ["[A3XAI] Error found in variable A3XAI_levelChancesAir, resetting to default value."]; A3XAI_levelChancesAir = [0.00,0.50,0.35,0.15]};
	if !((count A3XAI_levelChancesLand) isEqualTo 4) then {diag_log format ["[A3XAI] Error found in variable A3XAI_levelChancesLand, resetting to default value."]; A3XAI_levelChancesAir = [0.00,0.50,0.35,0.15]};
	if !((count A3XAI_useWeaponChance0) isEqualTo 4) then {diag_log format ["[A3XAI] Error found in variable A3XAI_useWeaponChance0, resetting to default value."]; A3XAI_useWeaponChance0 = [0.20,0.80,0.00,0.00]};
	if !((count A3XAI_useWeaponChance1) isEqualTo 4) then {diag_log format ["[A3XAI] Error found in variable A3XAI_useWeaponChance1, resetting to default value."]; A3XAI_useWeaponChance1 = [0.00,0.90,0.05,0.05]};
	if !((count A3XAI_useWeaponChance2) isEqualTo 4) then {diag_log format ["[A3XAI] Error found in variable A3XAI_useWeaponChance2, resetting to default value."]; A3XAI_useWeaponChance2 = [0.00,0.80,0.10,0.10]};
	if !((count A3XAI_useWeaponChance3) isEqualTo 4) then {diag_log format ["[A3XAI] Error found in variable A3XAI_useWeaponChance3, resetting to default value."]; A3XAI_useWeaponChance3 = [0.00,0.70,0.15,0.15]};
	if ("air_reinforce" in A3XAI_airReinforcementAllowedFor) then {A3XAI_airReinforcementAllowedFor = A3XAI_airReinforcementAllowedFor - ["air_reinforce"]};
	if ("uav" in A3XAI_airReinforcementAllowedFor) then {A3XAI_airReinforcementAllowedFor = A3XAI_airReinforcementAllowedFor - ["uav"]};
	if ("ugv" in A3XAI_airReinforcementAllowedFor) then {A3XAI_airReinforcementAllowedFor = A3XAI_airReinforcementAllowedFor - ["ugv"]};
	if !(A3XAI_side in [east,west]) then {diag_log format ["[A3XAI] Error found in variable A3XAI_side. User defined value: %1. Acceptable values: east, west",A3XAI_side]; A3XAI_side = east;};
};

diag_log format ["[A3XAI] Loaded all A3XAI settings in %1 seconds.",(diag_tickTime - _startTime)];

true
