% Vampires andWerewolves. Three vampires and three werewolves are on the
% east side of Rio Grande, along with a boat that can hold one or two people. Find
% a way to get everyone to the west side without ever leaving a group of vampires
% in one place outnumbered by werewolves in that place. (It is well known that
% vampires are more civilized, and therefore less likely to start a fight). 
% NOTE: the boat cannot cross without anyone in it.

% Define the initial and goal states
% Define the initial and goal states
initial_state(state(west(0, 0, false), east(3, 3, true))).
goal_state(state(west(3, 3, _), east(0, 0, _))).

% Define valid state
valid_state(state(west(WW, VW, _), east(WE, VE, _))) :-
    (VW >= WW; VW = 0),
    (VE >= WE; VE = 0).


% East to west moves
% Move one werewolf from east to west
% Move one werewolf from east to west
move(state(west(WW, VW, false), east(WE, VE, true)), state(west(WW1, VW, true), east(WE1, VE, false))) :-
    WE >= 1,
    WE1 is WE - 1,
    WW1 is WW + 1,
    valid_state(state(west(WW1, VW, true), east(WE1, VE, false))).

% Move two werewolves from east to west
move(state(west(WW, VW, false), east(WE, VE, true)), state(west(WW2, VW, true), east(WE2, VE, false))) :-
    WE >= 2,
    WE2 is WE - 2,
    WW2 is WW + 2,
    valid_state(state(west(WW2, VW, true), east(WE2, VE, false))).

% Move one vampire from east to west
move(state(west(WW, VW, false), east(WE, VE, true)), state(west(WW, VW1, true), east(WE, VE1, false))) :-
    VE >= 1,
    VE1 is VE - 1,
    VW1 is VW + 1,
    valid_state(state(west(WW, VW1, true), east(WE, VE1, false))).

% Move two vampires from east to west
move(state(west(WW, VW, false), east(WE, VE, true)), state(west(WW, VW2, true), east(WE, VE2, false))) :-
    VE >= 2,
    VE2 is VE - 2,
    VW2 is VW + 2,
    valid_state(state(west(WW, VW2, true), east(WE, VE2, false))).

% Move one vampire and one werewolf from east to west
move(state(west(WW, VW, false), east(WE, VE, true)), state(west(WW1, VW1, true), east(WE1, VE1, false))) :-
    WE >= 1, VE >= 1,
    WE1 is WE - 1, VE1 is VE - 1,
    WW1 is WW + 1, VW1 is VW + 1,
    valid_state(state(west(WW1, VW1, true), east(WE1, VE1, false))).


% West to east moves
% Move one werewolf from west to east
% Move one werewolf from west to east
move(state(west(WW, VW, true), east(WE, VE, false)), state(west(WW1, VW, false), east(WE1, VE, true))) :-
    WW >= 1,
    WW1 is WW - 1,
    WE1 is WE + 1,
    valid_state(state(west(WW1, VW, false), east(WE1, VE, true))).

% Move two werewolves from west to east
move(state(west(WW, VW, true), east(WE, VE, false)), state(west(WW2, VW, false), east(WE2, VE, true))) :-
    WW >= 2,
    WW2 is WW - 2,
    WE2 is WE + 2,
    valid_state(state(west(WW2, VW, false), east(WE2, VE, true))).

% Move one vampire from west to east
move(state(west(WW, VW, true), east(WE, VE, false)), state(west(WW, VW1, false), east(WE, VE1, true))) :-
    VW >= 1,
    VW1 is VW - 1,
    VE1 is VE + 1,
    valid_state(state(west(WW, VW1, false), east(WE, VE1, true))).

% Move two vampires from west to east
move(state(west(WW, VW, true), east(WE, VE, false)), state(west(WW, VW2, false), east(WE, VE2, true))) :-
    VW >= 2,
    VW2 is VW - 2,
    VE2 is VE + 2,
    valid_state(state(west(WW, VW2, false), east(WE, VE2, true))).

% Move one vampire and one werewolf from west to east
move(state(west(WW, VW, true), east(WE, VE, false)), state(west(WW1, VW1, false), east(WE1, VE1, true))) :-
    WW >= 1, VW >= 1,
    WW1 is WW - 1, VW1 is VW - 1,
    WE1 is WE + 1, VE1 is VE + 1,
    valid_state(state(west(WW1, VW1, false), east(WE1, VE1, true))).


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




