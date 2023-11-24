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


sum_Bs_before_Ws(List, Total) :- sum_Bs_before_Ws(List, List, 0, Total).
sum_Bs_before_Ws([], _, Total, Total).
sum_Bs_before_Ws(['W'|Tail], FullList, CurrentSum, Total) :-
        count_Bs_before_W(FullList, Tail, 0, BsCount),
        NewSum is CurrentSum + BsCount,
        sum_Bs_before_Ws(Tail, FullList, NewSum, Total).

sum_Bs_before_Ws([_|Tail], FullList, CurrentSum, Total) :-
        sum_Bs_before_Ws(Tail, FullList, CurrentSum, Total).

count_Bs_before_W(FullList, Tail, CurrentCount, Count) :-
        append(Head, Tail, FullList),
        findall(X, (member(X, Head), X = 'B'), Bs),
        length(Bs, BsLength),
        Count is CurrentCount + BsLength.

% Time to generate the children of a state, using our valid moves.

generate_children(State, Children) :-
        findall(Child, (valid_move(State, Child), Child \= State), Children).

valid_move(State, Child) :-
        swap_adjacent(State, Child);
        swap_hop_one(State, Child);
        swap_hop_two(State, Child).

% Swap with adjacent tile (both directions)
swap_adjacent(State, Child) :-
        (append(Prefix, ['_', Tile | Suffix], State); append(Prefix, [Tile, '_' | Suffix], State)),
        member(Tile, ['B', 'W']),
        (append(Prefix, [Tile, '_' | Suffix], Child); append(Prefix, ['_', Tile | Suffix], Child)).

% Swap by hopping over one tile (both directions)
swap_hop_one(State, Child) :-
        (append(Prefix, ['_', X, Tile | Suffix], State); append(Prefix, [Tile, X, '_' | Suffix], State)),
        member(Tile, ['B', 'W']),
        member(X, ['B', 'W']),
        (append(Prefix, [Tile, X, '_' | Suffix], Child); append(Prefix, ['_', X, Tile | Suffix], Child)).

% Swap by hopping over two tiles (both directions)
swap_hop_two(State, Child) :-
        (append(Prefix, ['_', X, Y, Tile | Suffix], State); append(Prefix, [Tile, X, Y, '_' | Suffix], State)),
        member(Tile, ['B', 'W']),
        member(X, ['B', 'W']),
        member(Y, ['B', 'W']),
        (append(Prefix, [Tile, X, Y, '_' | Suffix], Child); append(Prefix, ['_', X, Y, Tile | Suffix], Child)).


% Test that these work, BBB_WWW should in theory have six children.
% Test passed: Print children with this command:
% generate_children(['B', 'B', 'B', '_', 'W', 'W', 'W'], Children), print_children(Children).

% Next step, Get the heuristic value of each child, choose the smallest and print it. This will be our new state.
% Repeat this process until we have a heuristic value of 0
% For tie breaking, just choose any value, won't matter.

find_best_child([Child], Child).
find_best_child([Child1, Child2 | Rest], BestChild) :-
        sum_Bs_before_Ws(Child1, Heuristic1),
        sum_Bs_before_Ws(Child2, Heuristic2),
        (Heuristic1 =< Heuristic2 -> BetterChild = Child1; BetterChild = Child2),
        find_best_child([BetterChild | Rest], BestChild).


% Recursively call the find best child method, printing the steps we take.
greedy_search(State) :-
        sum_Bs_before_Ws(State, Heuristic),
        (Heuristic = 0 -> print('Goal State Reached: '), print_list(State);
        generate_children(State, Children),
        find_best_child(Children, BestChild),
        print('Chosen Child: '), print_list(BestChild), nl,
        greedy_search(BestChild)).

%General Print statements
print_list([]) :- nl.
print_list([H|T]) :-
            write(H), write(' '),
            print_list(T).

print_children(Children) :-
        print_list(Children).






    
