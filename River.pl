% Vampires andWerewolves. Three vampires and three werewolves are on the
% east side of Rio Grande, along with a boat that can hold one or two people. Find
% a way to get everyone to the west side without ever leaving a group of vampires
% in one place outnumbered by werewolves in that place. (It is well known that
% vampires are more civilized, and therefore less likely to start a fight). 
% NOTE: the boat cannot cross without anyone in it.


% A state can be represented as west(WW,VW, Boat) and east (WE, VE, Boat) 
%     - WW/WE Number of werewolves, the W and E denote which side. 
%     - VW/VE Number of vampires, the W and E denote which side 
%     - Boat  A Boolean which can we true or false depending on where the boat is
% Define the initial and goal states


% Initial state is when everyone, including the boat is on the east
initState(state(west(0, 0, false), east(3, 3, true))).

% Goal state is when everyone is on the East, in most cases the boat will be on the East but techincally it does not matter so use _
goalState(state(west(3, 3, _), east(0, 0, _))).

% Define a safe transition
% From the text, Werewolves cannot outnumber Vampires, aka V>=W or W<=V

safeMove(state(west(WW, VW, _), east(WE, VE, _))) :-
    (VW >= WW; VW = 0),
    (VE >= WE; VE = 0).

% Define all moves, I will define 10 moves, 5 for east to west and 5 for west to east. 
% We can move 1 or 2 werewovles, 1 or 2 vampires, or 1 vamp and 1 werewolf. 
% I will define these moves based on the state denoted above. 
% This will be key for DFS, allowing us to find a solution to this problem. 
% We also need to check that after making a move, it is safe, otherwise we cannot make it. Use the function above. 


% East to west moves


% Move one werewolf from east to west
move(state(west(WW, VW, false), east(WE, VE, true)), state(west(WW1, VW, true), east(WE1, VE, false))) :-
    WE >= 1,
    WE1 is WE - 1,
    WW1 is WW + 1,
    safeMove(state(west(WW1, VW, true), east(WE1, VE, false))).

% Move two werewolves from east to west
move(state(west(WW, VW, false), east(WE, VE, true)), state(west(WW2, VW, true), east(WE2, VE, false))) :-
    WE >= 2,
    WE2 is WE - 2,
    WW2 is WW + 2,
    safeMove(state(west(WW2, VW, true), east(WE2, VE, false))).

% Move one vampire from east to west
move(state(west(WW, VW, false), east(WE, VE, true)), state(west(WW, VW1, true), east(WE, VE1, false))) :-
    VE >= 1,
    VE1 is VE - 1,
    VW1 is VW + 1,
    safeMove(state(west(WW, VW1, true), east(WE, VE1, false))).

% Move two vampires from east to west
move(state(west(WW, VW, false), east(WE, VE, true)), state(west(WW, VW2, true), east(WE, VE2, false))) :-
    VE >= 2,
    VE2 is VE - 2,
    VW2 is VW + 2,
    safeMove(state(west(WW, VW2, true), east(WE, VE2, false))).

% Move one vampire and one werewolf from east to west
move(state(west(WW, VW, false), east(WE, VE, true)), state(west(WW1, VW1, true), east(WE1, VE1, false))) :-
    WE >= 1, VE >= 1,
    WE1 is WE - 1, 
    VE1 is VE - 1,
    WW1 is WW + 1, 
    VW1 is VW + 1,
    safeMove(state(west(WW1, VW1, true), east(WE1, VE1, false))).


% We also may need to move people back from West to East, this will be similar to above, but with opposite directions. 
% West to east moves


% Move one werewolf from west to east
move(state(west(WW, VW, true), east(WE, VE, false)), state(west(WW1, VW, false), east(WE1, VE, true))) :-
    WW >= 1,
    WW1 is WW - 1,
    WE1 is WE + 1,
    safeMove(state(west(WW1, VW, false), east(WE1, VE, true))).

% Move two werewolves from west to east
move(state(west(WW, VW, true), east(WE, VE, false)), state(west(WW2, VW, false), east(WE2, VE, true))) :-
    WW >= 2,
    WW2 is WW - 2,
    WE2 is WE + 2,
    safeMove(state(west(WW2, VW, false), east(WE2, VE, true))).

% Move one vampire from west to east
move(state(west(WW, VW, true), east(WE, VE, false)), state(west(WW, VW1, false), east(WE, VE1, true))) :-
    VW >= 1,
    VW1 is VW - 1,
    VE1 is VE + 1,
    safeMove(state(west(WW, VW1, false), east(WE, VE1, true))).

% Move two vampires from west to east
move(state(west(WW, VW, true), east(WE, VE, false)), state(west(WW, VW2, false), east(WE, VE2, true))) :-
    VW >= 2,
    VW2 is VW - 2,
    VE2 is VE + 2,
    safeMove(state(west(WW, VW2, false), east(WE, VE2, true))).

% Move one vampire and one werewolf from west to east
move(state(west(WW, VW, true), east(WE, VE, false)), state(west(WW1, VW1, false), east(WE1, VE1, true))) :-
    WW >= 1, VW >= 1,
    WW1 is WW - 1, 
    VW1 is VW - 1,
    WE1 is WE + 1, 
    VE1 is VE + 1,
    safeMove(state(west(WW1, VW1, false), east(WE1, VE1, true))).


% We can search many ways but I wanted to implement DFS in Prolog.  

dfs(Path, State, _, Path) :- 
    goalState(State).

dfs(Path, State, Visited, FinalPath) :-
    move(State, NextState),
    \+ member(NextState, Visited),
    dfs([NextState|Path], NextState, [NextState|Visited], FinalPath).

% To solve we need to get our intitial state and use DFS to find valid moves to get everyone over. Then print the path
solve :-
    initState(InitialState),
    dfs([InitialState], InitialState, [InitialState], Path),

    % After using DFS, we want to reverse the path to print it in order to the console, this is common with DFS
    reverse(Path, OrderedPath),
    printMoveOrder(OrderedPath).


% Helpers for running the program and printing the solution 
printMoveOrder([]).
printMoveOrder([State|Rest]) :-
    write(State), nl,
    printMoveOrder(Rest).

% Start the program
start :- solve.




