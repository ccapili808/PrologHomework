WEREWOLVES AND VAMPIRES IN NEW MEXICO PROBLEM 

Question prompt: 
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

Approach to the problem / things to define. 
  1) Initial and Goal State
  2) Defining a safe move (safeMove) in River.pl impl. 
  3) Defining our transitions or moves we can make at the river
    3.1) Check that the resultant of a move is safe
    3.2) Do East to West moves as well as West to East moves
    3.3) There should be 10 transitions we can make
  4) Use DFS to find a path
  5) Be able to run and print in prolog


// Questions for River.pl implementation: 
1) * make sure to describe your state representation detail: how are you representing your states? what does each element represent? what values can those variables have?
      A state can be represented as west(WW,VW, Boat) and east (WE, VE, Boat) 
         - WW/WE Number of werewolves, the W and E denote which side. 
         - VW/VE Number of vampires, the W and E denote which side 
         - Boat  A Boolean which can we true or false depending on where the boat is
      Examples: 
          west(0,0,false), east(3,3,true)   // Three werewolves and vampires on the east as well as the boat
          west(2,2,true),  east(1,1,false)  // Two WW and Vampires on the west with the boat. One WW and One Vampire on the east without the boat 

      Variables: 
          VW, VE, WW, WE, are all integer values ranging from 0 -> 3. 
          Boat is a Boolean and will be written as true or false, in accordance to the boats current position at a state

2) * how did you come up with your move rules? did you check if it is enough to cover the state space? did you come up with a clever trick to reduce the number of move rules?
    Coming up with moves: 
        - A boat can take 1 or two people, *Never 3!
        - We have two types of people 
        - We have two ways to boat can travel
        - Therefore, there are five combinations of people who can be in a boat. (1 or 2 werewolves, 1 or 2 vampires, or 1 vampire and 1 werewolf) = 5 moves. 
        - We can travel in two directions so 5 moves * 2 directions = 10 possible moves to define. These moves are commented in my River.pl file :) 
        - I did not use a clever trick, in hindsight maybe I could have used some property of symmetry to only define five moves, but I defined all ten. 

3) * provide detailed instructions on how to run and evaluate your Prolog code; 
        - How I ran the code: 
            - Log into moons or another cs machine, make sure to have my River.pl file
            - Type 'swipl', this will open prolog
            - Type ['River.pl']. to access my prolog file
                  - on moons '[River].' didn't work for me and I had to use '['River.pl'].'
                  - If '['River.pl'].' doesn't work for some reason let me know, or try '[River].'
            - Type 'start.' to run the method, a path will be printed with the solution 
            - ** Note you can also type 'solve.' instead of 'start.' either works :) ** 

            - My assignment defines the initial state and goal states, it does not take inputs in. 
            - Once running you should get the output: 
            state(west(0,0,false),east(3,3,true))
            state(west(2,0,true),east(1,3,false))
            state(west(1,0,false),east(2,3,true))
            state(west(3,0,true),east(0,3,false))
            state(west(2,0,false),east(1,3,true))
            state(west(2,2,true),east(1,1,false))
            state(west(1,1,false),east(2,2,true))
            state(west(1,3,true),east(2,0,false))
            state(west(0,3,false),east(3,0,true))
            state(west(2,3,true),east(1,0,false))
            state(west(1,3,false),east(2,0,true))
            state(west(3,3,true),east(0,0,false))
--------------------------------------------------

BLACK AND WHITE TILE PROBLEM: 

State: 
    There will always be an array of 7, with three white and black tiles each, ' _ ' for the empty square. 
    
    
    Initial State for this implementation: [B,B,B,_,W,W,W] 

    Goal: 
    All 'W' should be to the left of 'B', regardless of the position of the empty tile. 
      [W,W,W,_,B,B,B] and [W,W,W,B,_,B,B] are both valid solutions. 

Methods needed / Notes when I approached the problem: 
  
  * predicate for goal state 

  * heuristic: 
  sum of the number of Black tiles 'B' to the left of each white tile 'W'. 
  Chose heuristic values which lead us closer to 0, stop when this heursitic is zero. 


  * Rules, Identifying children. 
    Tiles can swap with the empty position in three ways: 
      swapping when adjacent to the empty tile [B,B,B,_,W,W,W] -> [B,B,_,B,W,W,W] Cost(1) 
      swapping by hopping over one tile into the empty spot (empty tile swaps after)
      swapping by hopping over two tiles into the empty spot (empty tile swaps after)

    I got these transitions from the PDF, no tricks were used. 

    When writing this code, I first checked that a state could generate all children correctly, then I made sure that the heuristics matched.
    
  
  * search method: 
    At our current state, generate all moves (the children), generate each heuristic value for each move (children).

    GREEDY SEARCH, pick the lowest heuristic value, update state to this, repeat the steps until heuristic(State) = 0. 

    Tie Breaking won't matter, a random value is chosen when multiple children have the lowest heuristic value.
  
    We have 140 possible states, so brute force is possible, this is why I took a greedy approach. 
  
  * a way to print each state that has been visited 

How to Run: 

  - Log into moons or another cs machine, make sure to have my in your directory SlidingTiles.pl file 
            - Type 'swipl', this will open prolog
            - Type ['SlidingTiles.pl']. to access my prolog file
            - Type 'start.' to run the method, a path will be printed with the solution 
            - My assignment defines the initial state and goal states, it does not take inputs in. 

Expected output this is in black-white.txt: *** The initial state is always B B B _ W W W so this shows the path after this. 
'Chosen Child: 'B B B W _ W W

'Chosen Child: 'B B _ W B W W

'Chosen Child: 'B B W W B _ W

'Chosen Child: 'B B W W B W _

'Chosen Child: 'B B W W _ W B

'Chosen Child: 'B _ W W B W B

'Chosen Child: 'B W _ W B W B

'Chosen Child: '_ W B W B W B

'Chosen Child: 'W W B _ B W B

'Chosen Child: 'W W B W B _ B

'Chosen Child: 'W W _ W B B B

'Goal State Reached: 'W W _ W B B B
--------------------------------------------------






















