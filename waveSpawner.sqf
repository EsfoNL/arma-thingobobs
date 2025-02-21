params [
    "_squads",
    "_waves",
    "_markers",
    "_min",
    "_target"
];

private _wave_index = 0;


private _groups = [];


while {count _waves > _wave_index} do {
    private _count = 0;
    
    {
        _count = _count + ({alive _x} count units _x);
    
        // Current result is saved in variable _x
        
    } forEach _groups;
    

    if (!(_count <= _min)) then {
        sleep 20;
        continue;
    };

    // [[small_squads, big_squads]; n]
    _current_wave = _waves select _wave_index;
    // squads
    for "_s" from 0 to (count _squads) - 1 do {
        for "_i" from 1 to (_current_wave select _s) do {
            private _marker = selectRandom _markers;
            private _group = createGroup opfor;
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
                    "NONE"
                ];
                if (_v isKindOf "Man") then {
                    private _unit = _group createUnit _args;                    
                } else {
                    private _unit = createVehicle _args;
                    _group createVehicleCrew _unit;
                };
            } forEach (_squads select _s);

           private _waypoint = _group addWaypoint [markerPos _target, 0];
           _waypoint setWaypointType "SAD";
           _groups pushBack _group;
        };
    };


    // increment and return index
    _wave_index = _wave_index + 1;
}