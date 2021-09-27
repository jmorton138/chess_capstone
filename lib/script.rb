require_relative '../lib/main.rb'

p1 = Player.new("white")
p2 = Player.new("black")
board = Gameboard.new
#p1.next_turn_potential_moves("a2a3", p2)
# render board with players
board.update_board(p1, p2)
board.display_grid
# #p1.checkmate?(p2)
while true do
    #check for p2 checkmate
    #arrays of each player's positions
    p1_moves = p1.return_positions_array
    p2_moves = p2.return_positions_array
    # prompt player 1
    puts "Enter move p1"
    # receive player 1 input
    move = gets.chomp.to_s
    # Loop until p1 user input valid
    until p1.validate_player_input(move, p2) == true
        puts "Invalid. Try again"
        move = gets.chomp.to_s
    end
    p2.capture(move)
    #update Player instance and gameboard
    p1.update_player_moves(move)
    board.refresh_board
    board.update_board(p1, p2)
    board.display_grid
    #check if last move put's opp(p2) in check
    puts "check" if p2.king_in_check?(p1) == true
    #check if last move put's opp(p2) into checkmate
    if p2.checkmate?(p1) == true
        puts "Checkmate. Player 1 wins"
        return false
    end
    #check for p2 checkmate
    p1_moves = p1.return_positions_array
    p2_moves = p2.return_positions_array
    # prompt player 2
    puts "Enter move p2"
    # receive player 1 input
    move = gets.chomp.to_s
    # Loop until p2 user input valid
    until p2.validate_player_input(move, p1) == true
        puts "Invalid. Try again"
        move = gets.chomp.to_s
    end
    p1.capture(move)
    #update Player instance and gameboard
    p2.update_player_moves(move)
    board.refresh_board
    board.update_board(p1, p2)
    board.display_grid
    #check if last move put's opp(p2) in check
    puts "check" if p1.king_in_check?(p2) == true
    #check if last move put's p1 into checkmate
    if p1.checkmate?(p2) == true
        puts "Checkmate. Player 2 wins"
        return false
    end

end










# 8  Ro     Kn     c8     d8     Ki     Bi     Kn     Ro   
#   ----------------------------------------------------
# 7  Pa     Pa     Pa     d7     Pa     Pa     Pa     Pa   
#   ----------------------------------------------------
# 6  a6     b6     c6     Qu     e6     f6     g6     h6   
#   ----------------------------------------------------
# 5  a5     b5     c5     Pa     e5     f5     g5     h5   
#   ----------------------------------------------------
# 4  a4     b4     c4     d4     Pa     f4     Bi     h4   
#   ----------------------------------------------------
# 3  a3     b3     c3     Ki     e3     f3     g3     h3   
#   ----------------------------------------------------
# 2  Pa     Pa     Pa     Pa     e2     Pa     Pa     Pa   
#   ----------------------------------------------------
# 1  Ro     Kn     Bi     Qu     e1     Bi     Kn     Ro   
#   ----------------------------------------------------
#    a      b      c      d      e      f      g      h   












# a8  b8  c8  d8  e8  f8  g8  h8 
# --------------------------------
# a7  b7  c7  d7  e7  f7  g7  h7 
# --------------------------------
# a6  b6  c6  d6  e6  f6  g6  h6 
# --------------------------------
# a5  b5  c5  d5  e5  f5  g5  h5 
# --------------------------------
# a4  b4  c4  d4  e4  f4  g4  h4 
# --------------------------------
# a3  b3  c3  d3  e3  f3  g3  h3 
# --------------------------------
# a2  xb2  c2  d2  e2  f2x  g2  h2 
# --------------------------------
# a1  b1  c1  xd1  e1  xf1  g1  h1 
