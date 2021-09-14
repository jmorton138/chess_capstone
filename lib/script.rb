require_relative '../lib/main.rb'

board = Gameboard.new
p1 = Player.new("white")

#p1.update_player_moves("b1", "c3")
# p p1.moves[:knght1]
# # p board.validate_player_input("b3b4", p1.moves)

p2 = Player.new("black")
# p board.return_piece_type("e1",p1.moves)
# p2.moves.each do |item|
#     item if item[1] == "a7"
# end
# p p2.moves.key("a7")

board.display_grid(board.grid, p1.moves, p2.moves)