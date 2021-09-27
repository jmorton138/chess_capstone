require_relative '../lib/main.rb'
require 'colorize'

p1 = Player.new("white")
p2 = Player.new("black")
board = Gameboard.new
puts ""
puts ""
puts "***************CHESS****************".light_cyan
puts ""

puts "How to Play:"
puts ""
puts "To enter a move type in two sets of coordinates on the board when prompted.
For example, if you want to move your pawn from a2 to a3, you simply type a2a3."

puts "A move will be invalid if the move doesn't exist on the board or is against the rules of chess."
puts ""
puts "This includes: "
puts "Moves that put your King into check i.e., into a position where your opponent could take your King."
puts "Moves that are not allowed for the type of chess piece at the starting coordinates."
puts "Moves that are occupied by the player's own piece."
puts ""
puts "How to win: "
puts ""
puts "When a player has no possible moves that would prevent their King from being put into check,
that is checkmate. That player loses the game."
puts "Let's get started. Press 1 to begin the game."
puts ""
start = gets.chomp.to_i
until start == 1 do
    puts "Please press 1 to begin the game."
    start = gets.chomp.to_i
end
puts ""

# render board with players
board.update_board(p1, p2)
board.display_grid
while true do
    #arrays of each player's positions
    p1_moves = p1.return_positions_array
    p2_moves = p2.return_positions_array
    # prompt player 1
    puts ""
    puts "Enter move Player 1:"
    puts ""
    # receive player 1 input
    move = gets.chomp.to_s
    # Loop until p1 user input valid
    until p1.validate_player_input(move, p2) == true
        puts "Invalid input. Please enter a valid move."
        move = gets.chomp.to_s
    end
    puts ""
    puts ""
    p2.capture(move)
    #update Player instance and gameboard
    p1.update_player_moves(move)
    board.refresh_board
    board.update_board(p1, p2)
    board.display_grid
    puts ""
    #check if last move put's opp(p2) in check
    puts "Player 2 now in check" if p2.king_in_check?(p1) == true
    #check if last move put's opp(p2) into checkmate
    if p2.checkmate?(p1) == true
        puts "Checkmate. Player 1 wins!"
        return false
    end
    #check for p2 checkmate
    p1_moves = p1.return_positions_array
    p2_moves = p2.return_positions_array
    # prompt player 2
    puts ""
    puts "Enter move Player 2:"
    puts ""
    # receive player 1 input
    move = gets.chomp.to_s
    # Loop until p2 user input valid
    until p2.validate_player_input(move, p1) == true
        puts "Invalid input. Please enter a valid move."
        move = gets.chomp.to_s
    end
    puts ""
    puts ""
    p1.capture(move)
    #update Player instance and gameboard
    p2.update_player_moves(move)
    board.refresh_board
    board.update_board(p1, p2)
    board.display_grid
    puts ""
    #check if last move put's opp(p2) in check
    puts "Player 1 now in check" if p1.king_in_check?(p2) == true
    #check if last move put's p1 into checkmate
    if p1.checkmate?(p2) == true
        puts "Checkmate. Player 2 wins!"
        return false
    end

end

