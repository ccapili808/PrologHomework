% Vampires andWerewolves. Three vampires and three werewolves are on the
% east side of Rio Grande, along with a boat that can hold one or two people. Find
% a way to get everyone to the west side without ever leaving a group of vampires
% in one place outnumbered by werewolves in that place. (It is well known that
% vampires are more civilized, and therefore less likely to start a fight). 
% NOTE: the boat cannot cross without anyone in it.

% State representation: (west(W,V,B), east(W,V,B)) 
%                       W- Number of Werewolves, V - Number of vampires, B - boolean for if the boat is on that side 
%                       Initial State would be: ((0, 0, 0), (3, 3, 1))     where the first index represents west and the 2nd is east. 
