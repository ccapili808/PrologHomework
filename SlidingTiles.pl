/*

Example State: 
There will always be an array of 7, with three white and black tiles each, ' _ ' for the empty square. 
[B,B,B,_,W,W,W]

Goal: 
All 'W' should be to the left of 'B', regardless of the position of the empty tile. 
  [W,W,W,_,B,B,B] and [W,W,W,B,_,B,B] are both valid solutions. 

Rules, Identifying children. 
Tiles can swap with the empty position in three ways: 
  swapping when adjacent to the empty tile [B,B,B,_,W,W,W] -> [B,B,_,B,W,W,W] Cost(1) 
  swapping by hopping over one tile (Cost 1)
  swapping by hopping over two tiles (Cost 2) 

Methods needed: 
  
predicate for goal state 

heuristic: 
sum of the number of B tiles to the left of each white tile. 
Chose heuristic values which lead us closer to 0, stop when this heursitic is zero. 
We have 140 possible states, so brute force may be possible!

search method: We have 140 possible states, so it 

a way to print each state that has been visited 

deciding which moves are valid
*/
% V1 % 
goal_state(State) :-
    append(_, ['_', B | _], State), B \= 'W'.

move(State, NewState, Cost) :-
    nth0(EmptyIndex, State, '_'),
    adjacent_move(State, EmptyIndex, NewState, Cost);
    hop_move(State, EmptyIndex, NewState, Cost).

adjacent_move(State, EmptyIndex, NewState, 1) :-
    AdjacentIndex is EmptyIndex - 1,
    swap_tiles(State, EmptyIndex, AdjacentIndex, NewState).

adjacent_move(State, EmptyIndex, NewState, 1) :-
    AdjacentIndex is EmptyIndex + 1,
    swap_tiles(State, EmptyIndex, AdjacentIndex, NewState).

hop_move(State, EmptyIndex, NewState, 1) :-
    HopIndex is EmptyIndex - 2,
    swap_tiles(State, EmptyIndex, HopIndex, NewState).

hop_move(State, EmptyIndex, NewState, 2) :-
    HopIndex is EmptyIndex + 2,
    swap_tiles(State, EmptyIndex, HopIndex, NewState).

swap_tiles(State, I, J, NewState) :-
    nth0(I, State, ItemI),
    nth0(J, State, ItemJ),
    replace(State, I, ItemJ, TempState),
    replace(TempState, J, ItemI, NewState).

replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]) :-
    I > 0,
    NI is I-1,
    replace(T, NI, X, R).


heuristic(State, Value) :-
    findall(Count, (nth1(IndexW, State, 'W'), count_b_left(State, IndexW, Count)), Counts),
    sum_list(Counts, Value).

count_b_left(State, IndexW, Count) :-
    sublist(State, 0, IndexW, SubState),
    include(=(B), SubState, Bs),
    length(Bs, Count).

solve(State, Solution) :-
    depth_first([], State, Solution).

depth_first(Path, State, [State|Path]) :-
    goal_state(State).

depth_first(Path, State, Sol) :-
    move(State, NewState, _),
    \+ member(NewState, Path),
    depth_first([State|Path], NewState, Sol).



print_solution([]).
print_solution([H|T]) :-
    writeln(H),
    print_solution(T).



main :-
    InitialState = ['B', 'B', 'B', '_', 'W', 'W', 'W'],
    solve(InitialState, Solution),
    reverse(Solution, OrderedSolution),
    print_solution(OrderedSolution).






    
