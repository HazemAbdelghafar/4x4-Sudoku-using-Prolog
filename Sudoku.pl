% Libraries Used
:- use_module(library(apply)).
:- use_module(library(clpfd)).


% General Use Functions


    % Used as a loop on the numbers.


    num(1).
    num(2).
    num(3).
    num(4).



    % Gets the index of Element in a list


    index_of([H | _], H, 0):-
      var(H),!.
    index_of([_ | T], H, I):-
      index_of(T, H, I1),
      I is I1+1.



    % Makes a list into a matrix


    part([], _, []).
    part(L, N, [DL | DLTail]):-
      length(DL, N),
      append(DL, LTail, L),
      part(LTail, N, DLTail).



    % Add Element on Index


    replace([H | T], 0, X, [X | T]):-
      var(H),
      !.
    replace([H | T], I, X, [H | R]):-
      I >= 0,
      NI is I-1,
      replace(T, NI, X, R),!.

    replace(L, _, _, L).



    % Not Same Function


    not_same(L):-
      L = [L1, L2, L3, L4],
      dif(L1, L2),
      dif(L1, L3),
      dif(L1, L4),
      dif(L2, L3),
      dif(L2, L4),
      dif(L3, L4),
      !.



    % Not Same Function for goal


    not_same_goal(L):-
      L = [L1, L2, L3, L4],
      dif(L1, L2),
      dif(L1, L3),
      dif(L1, L4),
      dif(L2, L3),
      dif(L2, L4),
      dif(L3, L4),
      nonvar(L1),
      nonvar(L2),
      nonvar(L3),
      nonvar(L4).



    % Base condition for Goal finding


    done(Board):-
      part(Board, 4, X),
      X = [X1, X2, X3, X4],
      not_same_goal(X1),
      not_same_goal(X2),
      not_same_goal(X3),
      not_same_goal(X4),
      transpose(X, Columns),
      Columns = [C1, C2, C3, C4],
      not_same_goal(C1),
      not_same_goal(C2),
      not_same_goal(C3),
      not_same_goal(C4).



    % Validation for heuristic


    valid_heuristic(Board):-
      part(Board, 4, Mt),
      length(Mt, 4),
      maplist(same_length(Mt), Mt),
      append(Mt, Vars),
      Vars ins 1..4,
      maplist(all_different, Mt),
      transpose(Mt, Columns),
      maplist(all_different, Columns).



% Valid board function


valid(Board):-
      part(Board, 4, X),
      X = [X1, X2, X3, X4],
      not_same(X1),
      not_same(X2),
      not_same(X3),
      not_same(X4),
      transpose(X, Columns),
      Columns = [C1, C2, C3, C4],
      not_same(C1),
      not_same(C2),
      not_same(C3),
      not_same(C4),
      !.



% First empty tile function


first_empty(Board, X):-
  index_of(Board, _, X).



% Place digit on board function


place(Board, I, D, X):-
  replace(Board, I, D, X),
  I =< 15,
  I >= 0,
  \+(Board == X).



% Next Move Function


next_move(Board, L):-
      first_empty(Board, I),!,
      num(P),
      place(Board, I, P, L),
      valid(L).



% Reach goal using Breadth First Search
% BFS works with Queue Data Structure
% First I find the next possible moves on the given board and add them
% to the Queue.
% The front is then dequeued and then i get the possible moves of the
% list and the output is added to the rear of the queue.
% When the queue is empty, all results are outputted.


goal_bfs(Board):-
      bfs_function([Board], _).

bfs_function([Board|_], Board):-
      done(Board),
      write(Board).

bfs_function([Board | Rest], R):-
      findall(L, next_move(Board, L), X),
      append(Rest, X, All),
      bfs_function(All,R).



% Reach goal using Depth First Search
% DFS works with Stack Data structure.
% First I find the next possible moves on the given Board and add them
% to the stack.
% Then pop the top and find the next possible moves on the top and so on
% Until the stack is empty, All the results are outputted.


goal_dfs(Board):-
      done(Board),
      write(Board).

goal_dfs(Board):-
      next_move(Board, L),
      goal_dfs(L).



% Reach goal Using Heuristic Search
% I am implementing Heuristic Search algorithm by variable ordering.
% I search for the tile with minimum remaining values ex.(A tile that
% has only one possible solution is solved first).
% If the number of minimum remaining values is equal at multiple tiles
% I solve the first empty tile.


heuristic(Board):-
      done(Board),
      write(Board).


heuristic(Board):-
      first_empty(Board, I),
      num(P),
      place(Board, I, P, X),
      valid_heuristic(X),
      heuristic(X).
