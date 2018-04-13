#include "\A3XAI\globaldefines.hpp"

private ["_unit", "_unitLevel", "_weaponLoot", "_toolLoot", "_pistol", "_magazine", "_toolsArray", "_item", "_loadout", "_primaryWeapon"];

_unit = _this select 0;
_unitLevel = _this select 1;

if (_unit getVariable ["LootGenerated",false]) exitWith {};
_unit setVariable ["LootGenerated",true];

if !(local _unit) then {
	waitUntil {uiSleep 1; local _unit};
};

if (A3XAI_debugLevel > 1) then {diag_log format["A3XAI Debug: Generating loot for AI unit with unitLevel %2.",_unit,_unitLevel];};

_weaponLoot = [];
_toolLoot = [];

_loadout = _unit getVariable ["loadout",[[],[]]];
_primaryWeapon = [_loadout select 0,0,""] call A3XAI_param;

	// A-A-ron add start
    _drop = createVehicle [
        "Land_Sleeping_bag_brown_folded_F",
        _this select 0,
        [],
        0, 
        "NONE"
    ];
	
	_cargo = "Supply500" createVehicle [0,0,0];
	_cargo attachTo [_drop, [0,0,0.85]];
	_drop attachTo [_unit, [0,0.25,0.5]];
	detach _drop;
	
	_drop enableRopeAttach false;
	_drop setVariable ["permaLoot",true];
	_drop allowDamage false;
	
// A-A-ron end

//Generate a pistol if one wasn't assigned with loadout script.
if ((getNumber (configFile >> "CfgWeapons" >> _primaryWeapon >> "type")) != 2) then {
	_pistol = A3XAI_pistolList call A3XAI_selectRandom;
	_magazine = getArray (configFile >> "CfgWeapons" >> _pistol >> "magazines") select 0;
	_unit addMagazine _magazine;	
	_unit addWeapon _pistol;
	// A-A-ron add
	_cargo addItemCargoGlobal [_magazine,1];
	_cargo addItemCargoGlobal [_pistol,1];
	if (A3XAI_debugLevel > 1) then {
		_weaponLoot pushBack _pistol;
		_weaponLoot pushBack _magazine
	};
};

//Add tool items
_toolsArray = missionNamespace getVariable ["A3XAI_toolsList"+str(_unitLevel),[]];
{
	_item = _x select 0;
	if (((_x select 1) call A3XAI_chance) && {[_item,"weapon"] call A3XAI_checkClassname}) then {
		_unit addWeapon _item;
		// A-A-ron add
		_cargo addItemCargoGlobal [_item,1];
		if (A3XAI_debugLevel > 1) then {
			_toolLoot pushBack _item;
		};
	}
} forEach _toolsArray;

// A-A-ron add
// copy all weapons attachments
	// _array = primaryWeaponItems _unit;
	// if(count(_array)>0) then {
		// {
			// _item = _x select 0;
			// _cargo addItemCargoGlobal [_item,1];
		// } forEach _array;
	// };
	// _array = secondaryWeaponItems _unit;
	// if(count(_array)>0) then {
		// {
			// _item = _x select 0;
			// _cargo addItemCargoGlobal [_item,1];
		// } forEach _array;
	// };
// copy all items from all of unit's storage positions and add them in
_array = getItemCargo uniformContainer _unit;
if(count(_array)>0) then {
	{
		for[{_i=0},{_i<((_array) select 1) select _forEachIndex},{_i=_i+1}] do {
			_cargo addItemCargoGlobal [_x,1];
		};
	} foreach ((_array) select 0);
};
_array = getWeaponCargo uniformContainer _unit;
if(count(_array)>0) then {
	{
		for[{_i=0},{_i<((_array) select 1) select _forEachIndex},{_i=_i+1}] do {
			_cargo addItemCargoGlobal [_x,1];
		};
	} foreach ((_array) select 0);
};
_array = getItemCargo vestContainer _unit;
if(count(_array)>0) then {
	{
		for[{_i=0},{_i<((_array) select 1) select _forEachIndex},{_i=_i+1}] do {
			_cargo addItemCargoGlobal [_x,1];
		};
	} foreach ((_array) select 0);
};
_array = getMagazineCargo vestContainer _unit;
if(count(_array)>0) then {
	{
		for[{_i=0},{_i<((_array) select 1) select _forEachIndex},{_i=_i+1}] do {
			_cargo addItemCargoGlobal [_x,1];
		};
	} foreach ((_array) select 0);
};
_array = getWeaponCargo vestContainer _unit;
if(count(_array)>0) then {
	{
		for[{_i=0},{_i<((_array) select 1) select _forEachIndex},{_i=_i+1}] do {
			_cargo addItemCargoGlobal [_x,1];
		};
	} foreach ((_array) select 0);
};
_array = getItemCargo backpackContainer _unit;
if(count(_array)>0) then {
	{
		for[{_i=0},{_i<((_array) select 1) select _forEachIndex},{_i=_i+1}] do {
			_cargo addItemCargoGlobal [_x,1];
		};
	} foreach ((_array) select 0);
};
_array = getMagazineCargo backpackContainer _unit;
if(count(_array)>0) then {
	{
		for[{_i=0},{_i<((_array) select 1) select _forEachIndex},{_i=_i+1}] do {
			_cargo addItemCargoGlobal [_x,1];
		};
	} foreach ((_array) select 0);
};
_array = getWeaponCargo backpackContainer _unit;
if(count(_array)>0) then {
	{
		for[{_i=0},{_i<((_array) select 1) select _forEachIndex},{_i=_i+1}] do {
			_cargo addItemCargoGlobal [_x,1];
		};
	} foreach ((_array) select 0);
};
// copy loadout (the rest of the AI's inventory)
{
	_item = _x select 0;
	_cargo addItemCargoGlobal [_item,1];
} forEach _loadoutArray;
_array = getUnitLoadout _unit;
if(count(_array)>0) then {
	{
		_cargo addItemCargoGlobal [_x,1];
	} foreach ((_array) select 0);
};
_loadoutArray = getUnitLoadout _unit;
// copy the rest of it
if((headgear _unit)!="") then {
	_cargo addItemCargoGlobal [(headgear _unit),1];
};
if((goggles _unit)!="") then {
	_cargo addItemCargoGlobal [(goggles _unit),1];
};
if((uniform _unit)!="") then {
	_cargo addItemCargoGlobal [(uniform _unit),1];
};
if((vest _unit)!="") then {
	_cargo addItemCargoGlobal [(vest _unit),1];
};
if((backpack _unit)!="") then {
	_cargo addItemCargoGlobal [(backpack _unit),1];
};
	
if (A3XAI_debugLevel > 1) then {diag_log format ["A3XAI Debug: Generated loot for AI death: %1,%2,%3.",_weaponLoot,_toolLoot];};
