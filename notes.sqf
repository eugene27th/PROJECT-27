{  
    if (str _x find ": t_poplar2f_dead_f" > -1) then {  
        hideObjectGlobal _x; 
    };  
} forEach nearestObjects [[worldSize / 2,worldSize / 2,0], [], worldSize * 2];