% Vampires andWerewolves. Three vampires and three werewolves are on the
% east side of Rio Grande, along with a boat that can hold one or two people. Find
% a way to get everyone to the west side without ever leaving a group of vampires
% in one place outnumbered by werewolves in that place. (It is well known that
% vampires are more civilized, and therefore less likely to start a fight). 
% NOTE: the boat cannot cross without anyone in it.

% Define the initial and goal states
initial_state(state(3, 3, east, 0, 0)).
goal_state(state(0, 0, west, 3, 3)).

% Define valid state
valid_state(state(VE, WE, _, VW, WW)) :-
    (VE >= WE; VE = 0),
    (VW >= WW; VW = 0).

% East to west moves
% Move one werewolf from east to west
move(state(VE, WE, east, VW, WW), state(VE, WE1, west, VW, WW1)) :-
    WE >= 1,
    WE1 is WE - 1,
    WW1 is WW + 1,
    valid_state(state(VE, WE1, west, VW, WW1)).

% Move two werewolves from east to west
move(state(VE, WE, east, VW, WW), state(VE, WE2, west, VW, WW2)) :-
    WE >= 2,
    WE2 is WE - 2,
    WW2 is WW + 2,
    valid_state(state(VE, WE2, west, VW, WW2)).

% Move one vampire from east to west
move(state(VE, WE, east, VW, WW), state(VE1, WE, west, VW1, WW)) :-
    VE >= 1,
    VE1 is VE - 1,
    VW1 is VW + 1,
    valid_state(state(VE1, WE, west, VW1, WW)).

% Move two vampires from east to west
move(state(VE, WE, east, VW, WW), state(VE2, WE, west, VW2, WW)) :-
    VE >= 2,
    VE2 is VE - 2,
    VW2 is VW + 2,
    valid_state(state(VE2, WE, west, VW2, WW)).

% Move one vampire and one werewolf from east to west
move(state(VE, WE, east, VW, WW), state(VE1, WE1, west, VW1, WW1)) :-
    VE >= 1, WE >= 1,
    VE1 is VE - 1, WE1 is WE - 1,
    VW1 is VW + 1, WW1 is WW + 1,
    valid_state(state(VE1, WE1, west, VW1, WW1)).


% West to east moves
% Move one werewolf from west to east
move(state(VE, WE, west, VW, WW), state(VE, WE1, east, VW, WW1)) :-
    WW >= 1,
    WW1 is WW - 1,
    WE1 is WE + 1,
    valid_state(state(VE, WE1, east, VW, WW1)).

% Move two werewolves from west to east
move(state(VE, WE, west, VW, WW), state(VE, WE2, east, VW, WW2)) :-
    WW >= 2,
    WW2 is WW - 2,
    WE2 is WE + 2,
    valid_state(state(VE, WE2, east, VW, WW2)).

% Move one vampire from west to east
move(state(VE, WE, west, VW, WW), state(VE1, WE, east, VW1, WW)) :-
    VW >= 1,
    VW1 is VW - 1,
    VE1 is VE + 1,
    valid_state(state(VE1, WE, east, VW1, WW)).

% Move two vampires from west to east
move(state(VE, WE, west, VW, WW), state(VE2, WE, east, VW2, WW)) :-
    VW >= 2,
    VW2 is VW - 2,
    VE2 is VE + 2,
    valid_state(state(VE2, WE, east, VW2, WW)).

% Move one vampire and one werewolf from west to east
move(state(VE, WE, west, VW, WW), state(VE1, WE1, east, VW1, WW1)) :-
    VW >= 1, WW >= 1,
    VW1 is VW - 1, WW1 is WW - 1,
    VE1 is VE + 1, WE1 is WE + 1,
    valid_state(state(VE1, WE1, east, VW1, WW1)).

%Solve, many ways but I wanted to implement DFS in Prolog.  
dfs(Path, State, _, Path) :- 
    goal_state(State).

dfs(Path, State, Visited, FinalPath) :-
    move(State, NextState),
    \+ member(NextState, Visited), % Ensure the state is not already visited
    dfs([NextState|Path], NextState, [NextState|Visited], FinalPath).

solve :-
    initial_state(InitialState),
    dfs([InitialState], InitialState, [InitialState], Path),
    reverse(Path, OrderedPath),
    print_solution(OrderedPath).

% Utility to Print Solution
print_solution([]).
print_solution([State|Rest]) :-
    write(State), nl,
    print_solution(Rest).

% Start the program
start :- solve.





