require_relative '../lib/main.rb'

p1 = Player.new("white")
p2 = Player.new("black")
board = Gameboard.new
# render board with players
board.update_board(p1, p2)
board.display_grid
while true do
    #arrays of each player's positions
    p1_moves = p1.return_moves_array
    p2_moves = p2.return_moves_array
    # prompt player 1
    puts "Enter move p1"
    # receive player 1 input
    move = gets.chomp.to_s
    # Loop until p1 user input valid
    until p1.validate_player_input(move, p2) == true
        puts "Invalid. Try again"
        move = gets.chomp.to_s
    end
    #update Player instance and gameboard
    p1.update_player_moves(move)
    board.refresh_board
    board.update_board(p1, p2)
    board.display_grid
    
    p p1_moves = p1.return_moves_array
    p p2_moves = p2.return_moves_array
    # prompt player 2
    puts "Enter move p2"
    # receive player 1 input
    move = gets.chomp.to_s
    # Loop until p2 user input valid
    until p2.validate_player_input(move, p1) == true
        puts "Invalid. Try again"
        move = gets.chomp.to_s
    end
    #update Player instance and gameboard
    p2.update_player_moves(move)
    board.refresh_board
    board.update_board(p2, p1)
    board.display_grid
end





















# board.grid = board.grid.each_with_index do |item, index|
#     index_plus_one = index + 1
#     p1.pieces.select do |piece|
#         if piece.type.position == item
#             board.grid[index] = piece.type.class
#         end
#     end
# end

# p1 = Player.new("white")
# p board.find_rook_moves("c4", p1.moves)
# #p1.update_player_moves("b1", "c3")
# # p p1.moves[:knght1]
# # # p board.validate_player_input("b3b4", p1.moves)

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



#OG gameboard methods
# def find_p1_pawn_moves(start_pt, player_moves, opp_moves)
    #     #split starting point and increment column
    #     moves = []
    #     diag_moves = []
    #     move_1 = start_pt.split(//)
    #     diag_r = move_1
    #     diag_l = move_1
    #     move_1[1] = (move_1[1].to_i + 1).to_s
    #     move_1 = move_1.join()
    #     moves.push(move_1)
    #     if start_pt.split(//)[1] == "2"
    #         move_2 = start_pt.split(//)
    #         move_2[1] = (move_2[1].to_i + 2).to_s
    #         move_2 = move_2.join()
    #         moves.push(move_2)
    #     end
    #     #right diagonal edge case
    #     diag_r[1] = move_1[1]
    #     diag_r[0] = (diag_r[0].ord + 1).chr
    #     diag_r = diag_r.join()
    #     #left diagonal edge case
    #     diag_l[1] = move_1[1]
    #     diag_l[0] = (diag_l[0].ord - 2).chr
    #     diag_l = diag_l.join()
    #     if opp_moves.key(diag_l) != nil
    #         diag_moves.push(diag_l)
    #     end
    #     if opp_moves.key(diag_r) != nil
    #         diag_moves.push(diag_r)
    #     end
    #     diag_moves
    #     if opp_moves.key(move_1) != nil
    #         moves = []
    #     end
    #     moves += diag_moves
    #     moves.sort
    # end

    # def find_p2_pawn_moves(start_pt, player_moves, opp_moves)
    #     #split starting point and increment column
    #     moves = []
    #     diag_moves = []
    #     move_1 = start_pt.split(//)
    #     diag_r = move_1
    #     diag_l = move_1
    #     move_1[1] = (move_1[1].to_i - 1).to_s
    #     move_1 = move_1.join()
    #     moves.push(move_1)
    #     if start_pt.split(//)[1] == "7"
    #         move_2 = start_pt.split(//)
    #         move_2[1] = (move_2[1].to_i - 2).to_s
    #         move_2 = move_2.join()
    #         moves.push(move_2)
    #     end
    #     #right diagonal edge case
    #     diag_r[1] = move_1[1]
    #     diag_r[0] = (diag_r[0].ord + 1).chr
    #     diag_r = diag_r.join()
    #     #left diagonal edge case
    #     diag_l[1] = move_1[1]
    #     diag_l[0] = (diag_l[0].ord - 2).chr
    #     diag_l = diag_l.join()
    #     if opp_moves.key(diag_l) != nil
    #         diag_moves.push(diag_l)
    #     end
    #     if opp_moves.key(diag_r) != nil
    #         diag_moves.push(diag_r)
    #     end
    #     diag_moves
    #     if opp_moves.key(move_1) != nil
    #         moves = []
    #     end
    #     moves += diag_moves
    #     moves.sort
    # end


    # def find_rook_moves(start_pt, player_moves, opp_moves)
    #     moves = []
    #     split_point = start_pt.split(//)
    #     x = 1
    #     x_axis = ["a", "b", "c", "d", "e", "f", "g", "h"]
    #     #x-axis moves
    #     x_axis.each do |letter|
    #         temp = letter + split_point[1]
    #         if has_player_piece?(temp, player_moves) && temp != start_pt
    #             break
    #         else
    #             moves.push(temp)
    #         end
    #     end 
    #     #y-axis moves 
    #     y = 1
    #     until y > 8
    #         temp = split_point
    #         temp = temp[0] + y.to_s
    #         if has_player_piece?(temp, player_moves) && temp !=start_pt
    #             break
    #         elsif has_opp_piece?(temp, opp_moves)
    #             moves.push(temp)  
    #             break
    #         else
    #             moves.push(temp) 
    #         end
    #         y += 1 
    #     end
    #     moves = moves.uniq
    #     st_pt_index = moves.index(start_pt)
    #     moves.slice!(st_pt_index)
    #     moves

    # end

    # def find_knight_moves(start_pt, player_moves, opp_moves)
    #     split_point = start_pt.split(//)
    #     paths = [
    #         [1, 2],
    #         [1, (-2)],
    #         [(-1), 2],
    #         [(-1), (-2)],
    #         [2, 1],
    #         [2, (-1)],
    #         [(-2),(-1)],
    #         [(-2), 1]]
    
    #         moves = paths.reduce([]) do |sum, item|
    #             item[0] = (split_point[0].ord + item[0]).chr
    #             item[1] = (split_point[1].to_i + item[1]).to_s
    #             item = item.join()
    #             if grid.include?(item) && !has_player_piece?(item, player_moves)
    #                 sum.push(item)
    #             end
    #             sum
    #         end
    #         moves.sort
            
    # end

    # def find_bishop_moves(start_pt, player_moves, opp_moves)
    #     split_point = start_pt.split(//)
    #     moves = []
    #     i = split_point[0].ord
    #     j = split_point[1].to_i
        
    #     #find up slope right moves
    #     until j == 8
    #         i += 1
    #         j += 1
    #         move = i.chr + j.to_s
    #         if has_player_piece?(move, player_moves) && move !=start_pt
    #             break
    #         elsif has_opp_piece?(move, opp_moves)
    #             moves.push(move)  
    #             break
    #         else
    #             moves.push(move)
    #         end
    #     end    
    #     #find down slope right moves
    #     i = split_point[0].ord
    #     j = split_point[1].to_i
    #     until j == 1
    #         i += 1
    #         j -= 1
    #         move = i.chr + j.to_s
    #         if has_player_piece?(move, player_moves) && move !=start_pt
    #             break
    #         elsif has_opp_piece?(move, opp_moves)
    #             moves.push(move)  
    #             break
    #         else
    #             moves.push(move)
    #         end
    #     end
        
    #     #find up slope left moves
    #     i = split_point[0].ord
    #     j = split_point[1].to_i
    #     until j == 8
    #         i -= 1
    #         j += 1
    #         move = i.chr + j.to_s
    #         if has_player_piece?(move, player_moves) && move !=start_pt
    #             break
    #         elsif has_opp_piece?(move, opp_moves)
    #             moves.push(move)  
    #             break
    #         else
    #             moves.push(move)
    #         end
    #     end
    #     #find down slope left moves
    #     i = split_point[0].ord
    #     j = split_point[1].to_i
    #     until j == 1
    #         i -= 1
    #         j -= 1
    #         move = i.chr + j.to_s
    #         if has_player_piece?(move, player_moves) && move !=start_pt
    #             break
    #         elsif has_opp_piece?(move, opp_moves)
    #             moves.push(move)  
    #             break
    #         else
    #             moves.push(move)
    #         end
    #     end
    #     moves = moves.select {|item| grid.include?(item) }.sort

    # end

    # def find_queen_moves(start_pt, player_moves, opp_moves)
    #     diagonal_lines = find_bishop_moves(start_pt, player_moves, opp_moves)
    #     straight_lines = find_rook_moves(start_pt, player_moves, opp_moves)
    #     moves = diagonal_lines + straight_lines
    #     moves.sort
    # end

    # def find_king_moves(start_pt, player_moves, opp_moves)
    #     split_point = start_pt.split(//)
    #     paths = [[1, 1],
    #     [1, (-1)],
    #     [(-1),(-1)],
    #     [(-1), 1],
    #     [0, 1],
    #     [1, 0],
    #     [0, (-1)],
    #     [(-1), 0]]

    #     moves = paths.reduce([]) do |sum, item|
    #         item[0] = (split_point[0].ord + item[0]).chr
    #         item[1] = (split_point[1].to_i + item[1]).to_s
    #         item = item.join()
    #         if grid.include?(item) && !has_player_piece?(item, player_moves)
    #             sum.push(item)
    #         end
    #         sum
    #     end
    #     moves.sort
    # end

   

    # def return_piece_type(start_pt, player_moves)
    #     kv_pair = nil
    #     player_moves.each do |item|
    #         kv_pair = item if item[1] == start_pt
    #     end
    #     peice_abbr = kv_pair[0].to_s.split(//)
    #     if peice_abbr[0] == "p"
    #         return "pawn"
    #     elsif peice_abbr[0] == "r"
    #         return "rook"
    #     elsif peice_abbr[0] == "k"
    #         return "knight"
    #     elsif peice_abbr[0] == "b"
    #         return "bishop"
    #     elsif peice_abbr[0] == "q"
    #         return "queen"
    #     elsif peice_abbr[0] == "K"
    #         return "King"
    #     end    
    # end