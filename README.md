# 4x4-Sudoku-using-Prolog
This is a Prolog code that solves a 4x4 Sudoku, using BFS, DFS, and Heuristic searching Algorithms. A 4x4 board is given to the predicates to find the needed info. Empty tiles in the board is given as a "_"(anonymous variable).  The code also includes different predicates that are needed to obtain our goal.

Predicates:

  First_empty:
  This predicate is used to find the first empty tile(_) in your board and returns its index.
  
  Valid:
  A board is given to the predicate and returns True or False depending on if the board is either valid and can be solved, or not.
  
  Place:
  This predicate places a valid digit in the choosen index. If the index given have a number already placed, no changes will happen and it will return false. If the digit placed in the row/column is already there, it returns false. If the index is out of range, it also returns false.
  
  Next_move:
  This predicate is used to show all the possible digits that can be placed in the first empty tile.
  
Searching Algorithms:

  DFS(Depth First Search):
  A dfs algorithm is exectued using the next_move predicate and then recalling the dfs predicate. A base condition is there to ensure that the board has finally been solved.
  
  BFS(Breadth First Search):
  A bfs algorithm is executed using the findall function and the next_move predicate to get all the possible moves, and then enqueue them to a list that acts as a queue. Each list in this queue is then sent to the bfs predicate to get all the possible moves and enqueue them to the queue, until there are no more boards in the queue. A base condition is also there to terminate the searching after all the boards are solved.
  
  Heuristic: 
  The heuristic algorithm is solved using the maplist function that works on the minimum remaining values in each row/column. If a tile has only one possible value to be placed in it, it places the value and searchs for the remaining tiles accordingly. A base condition is there to guarantee that all the possible boards have been solved.
