params [
    "_squads",
    "_waves",
    "_markers",
    "_min",
    "_target"
];

private _wave_index = 0;

private _vehicle_group = createGroup [opfor, false];
private _infantry_group = createGroup [opfor, false];

hint str _infantry_group;



while {count _waves > _wave_index} do {
    private _count = ({alive _x} count units _infantry_group) +  ({alive _x} count units _vehicle_group);
    
    if (!(_count <= _min)) then {
        sleep 20;
        continue;
    };

    // _vehicle_group addWaypoint [markerPos _target, 0, 0];
    // _infantry_group addWaypoint [markerPos _target, 0, 0];
    // [[small_squads, big_squads]; n]
    _current_wave = _waves select _wave_index;
    // squads
    for "_s" from 0 to (count _squads) - 1 do {
        for "_i" from 1 to (_current_wave select _s) do {
            private _marker = selectRandom _markers;
            {
                private _v = _x;
                if (typeName _v == "ARRAY") then {
                    _v = selectRandom _x;
                };

                private _args = [
                    _v,
                    markerPos _marker,
                    [],
                    (markerSize _marker) select 0,
                    "NONE",
                ];
                if (_v isKindOf "AllVehicles") then {
                    private _unit = createVehicle _args;
                    _vehicle_group createVehicleCrew _unit;
                } else {
                    private _unit = _infantry_group createUnit _args;

                };
            } forEach (_squads select _s);
            
        };
    };


    // increment and return index
    _wave_index = _wave_index + 1;
}