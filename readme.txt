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

2) * how did you come up with your move rules? did you check if it is enough to cover the state space? did you come up with a clever trick to reduce the number of move rules?

3) * provide detailed instructions on how to run and evaluate your Prolog code; 


BLACK AND WHITE TILE PROBLEM: 
// Due next week 
