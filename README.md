# Chess Capstone

## About this project
The project is a full 2 player chess game written in Ruby played on the command line. All the standard rules of chess apply. 

This is the final project of The Odin Project's Full Stack Ruby on Rails Path, Ruby Programming Course. You can see the full project specifications here: https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-programming/lessons/ruby-final-project.

## How to play
To enter a move type in two sets of coordinates on the board when prompted.
For example, if you want to move your pawn from a2 to a3, you simply type a2a3.

A move will be invalid if the move doesn't exist on the board or is against the rules of chess.

This includes: 

Moves that put your King into check i.e., into a position where your opponent could take your King.

Moves that are not allowed for the type of chess piece at the starting coordinates.

Moves that are occupied by the player's own piece.

### How to win: 

When a player has no possible moves that would prevent their King from being put into check,
that is checkmate. That player loses the game.


## Get started

Clone the repo to your local machine:

`$ git clone https://github.com/jmorton138/chess_capstone`

Run game on the console with:

`ruby lib/script.rb`


