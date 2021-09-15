require_relative '../lib/main.rb'

board = Gameboard.new
p1 = Player.new("white")
p board.find_rook_moves("c4", p1.moves)
#p1.update_player_moves("b1", "c3")
# p p1.moves[:knght1]
# # p board.validate_player_input("b3b4", p1.moves)

p2 = Player.new("black")
# p board.return_piece_type("e1",p1.moves)
# p2.moves.each do |item|
#     item if item[1] == "a7"
# end
# p p2.moves.key("a7")

#board.display_grid(board.grid, p1.moves, p2.moves)



# a8  b8  c8  d8  e8  f8  g8  h8 
# --------------------------------
#  a7  b7  c7  d7  e7  f7  g7  h7 
# --------------------------------
#  a6  b6  c6  d6  e6  f6  g6  h6 
# --------------------------------
#  a5  b5  c5  d5  e5  f5  g5  h5 
# --------------------------------
#  a4  b4  c4  d4  e4  f4  g4  h4 
# --------------------------------
#  a3  b3  c3  d3  e3  f3  g3  h3 
# --------------------------------
#  a2  b2  c2  d2  e2  f2  g2  h2 
# --------------------------------
#  a1  b1  c1  d1  e1  f1  g1  h1 
