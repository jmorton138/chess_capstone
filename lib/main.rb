class Gameboard
    attr_accessor :grid, :grid_with_pieces

    def initialize
        @grid = build_grid()
        @grid_with_pieces = build_grid()
    end

    def build_grid
        letters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
        grid = []
        for letter in letters
            i = 1
            og_letter = letter
            until i > 8 do
                square = "#{og_letter}#{i.to_s}"
                grid.push(square)
                i += 1
            end
        end
        grid
        #sort grid
        sorted_grid = []
        i = 8
        until i < 1 do
            sorted_grid += grid.select { |item| item.include?(i.to_s) }
            i -= 1
        end
       sorted_grid
    end

    def refresh_board
        self.grid_with_pieces = self.grid
    end

    def update_board(p1, p2)
        self.grid.each_with_index do |item, index|
            index_plus_one = index + 1
            p1.pieces.select do |piece|
                if piece.type.position == item
                    self.grid_with_pieces[index] = piece.type.class
                end
            end
            p2.pieces.select do |piece|
                if piece.type.position == item
                    self.grid_with_pieces[index] = piece.type.class
                end
            end
        end
    end

    def display_grid
        grid_with_pieces.each_with_index do |item, index|
            index_plus_one = index + 1
            if index_plus_one % 8 == 0
                    puts "  #{item}   "
                puts "-------------------------------------------------------"
            else
                    print "  #{item}   "
            end
        end
        puts ""
    end

    def validate_player_input(input, player_moves, opp_moves)
        return false if input.length > 4
        sliced = input.chars.each_slice(2).map(&:join)
        #check if starting point is point on the board
        return false if !grid.include?(sliced[0])
        #check if starting point has player's piece on it
        return false if player_moves.key(sliced[0]) == nil
        # determine type of chess piece
        piece_type = return_piece_type(sliced[0], player_moves)
        valid_moves = return_available_moves(piece_type, sliced[0], player_moves, opp_moves)
        #check if end point is in available moves returned from find_#{piece}_moves method
        if valid_moves.include?(sliced[1])
            return true
        else
            return false
        end
    end


    def return_available_moves(piece, start_pt, player_moves, opp_moves)
        if piece == "pawn"
            ###condition for determining p1 or p2
            find_p1_pawn_moves(start_pt, player_moves, opp_moves)
        elsif piece == "rook"
            find_rook_moves(start_pt, player_moves, opp_moves)
        elsif piece == "knight"
            find_knight_moves(start_pt, player_moves, opp_moves)
        elsif piece == "bishop"
            find_bishop_moves(start_pt, player_moves, opp_moves)
        elsif piece == "queen"
            find_queen_moves(start_pt, player_moves, opp_moves)
        elsif piece == "King"
            find_king_moves(start_pt, player_moves, opp_moves)
        end
    end
    
    def has_opp_piece?(space, opp_moves)
        return true if opp_moves.key(space) != nil
        false
    end

    def has_player_piece?(space, player_moves)
        return true if player_moves.key(space) != nil
        false
    end

end

class Player
    attr_accessor :moves, :piece_color, :pieces
    def initialize(piece_color)
        @piece_color = piece_color
        @pieces = build_pieces
    end

    def build_pieces
        x_axis = ["a", "b", "c", "d", "e", "f", "g", "h"]
        #x-axis moves
        pawns = []
        i = 1
        y = 2
        self.piece_color == "black" ? y = 7 : y
        x_axis.each do |letter|
            position = letter + y.to_s
            pawns << Piece.new(Pawn.new(i, position), piece_color)
            i += 1
        end 
        pawns

    end

    def build_moves_hash(piece_color)

        # if piece_color == "white"
            # moves = {
            #     pawn1: "a2",
            #     pawn2: "b2",
            #     pawn3: "c2",
            #     pawn4: "d2",
            #     pawn5: "e2",
            #     pawn6: "f2",
            #     pawn7: "g2",
            #     pawn8: "h2",
            #     rook1: "a1",
            #     knght1: "b1",
            #     bish1: "c1",
            #     queen: "d1",
            #     King: "e1",
            #     bish2: "f1",
            #     knght2: "g1",
            #     rook2: "h1"
            # }
 
        # elsif piece_color == "black"
        #     moves = {
        #         pawn1: "a7",
        #         pawn2: "b7",
        #         pawn3: "c7",
        #         pawn4: "d7",
        #         pawn5: "e7",
        #         pawn6: "f7",
        #         pawn7: "g7",
        #         pawn8: "h7",
        #         rook1: "a8",
        #         knght1: "b8",
        #         bish1: "c8",
        #         queen: "d8",
        #         King: "e8",
        #         bish2: "f8",
        #         knght2: "g8",
        #         rook2: "h8"
        #     }
        # end
        # moves
    end

    def update_player_moves(start_pt, end_pt)
        key = nil
        moves.each do |item|
            key = item[0] if item[1] == start_pt
        end 
        moves[key] = end_pt
    end

end


class Piece 

    attr_reader :type
    attr_accessor :type, :color

    def initialize(type, color)
        @type = type
        @color = color
    end


end

class Moves
end

class Checks
end

class Pawn < Piece
    attr_accessor :id, :position
    def initialize(id, position)
        @id = id
        @position = position
    end

    def find_moves
        start_pt = self.position
        moves = []
        diag_moves = []
        move_1 = start_pt.split(//)
        diag_r = move_1
        diag_l = move_1
        move_1[1] = (move_1[1].to_i + 1).to_s
        move_1 = move_1.join()
        moves.push(move_1)
        if start_pt.split(//)[1] == "2"
            move_2 = start_pt.split(//)
            move_2[1] = (move_2[1].to_i + 2).to_s
            move_2 = move_2.join()
            moves.push(move_2)
        end
        #right diagonal edge case
        diag_r[1] = move_1[1]
        diag_r[0] = (diag_r[0].ord + 1).chr
        diag_r = diag_r.join()
        #left diagonal edge case
        diag_l[1] = move_1[1]
        diag_l[0] = (diag_l[0].ord - 2).chr
        diag_l = diag_l.join()
        # if opp_moves.key(diag_l) != nil
        #     diag_moves.push(diag_l)
        # end
        # if opp_moves.key(diag_r) != nil
        #     diag_moves.push(diag_r)
        # end
        # diag_moves
        # if opp_moves.key(move_1) != nil
        #     moves = []
        # end
        moves += diag_moves
        p moves.sort
    end

    # def update_position(new_pos)
    #     self.position = new_pos
    # end

    def find_p1_pawn_moves(start_pt, player_moves, opp_moves)
        #split starting point and increment column
        moves = []
        diag_moves = []
        move_1 = start_pt.split(//)
        diag_r = move_1
        diag_l = move_1
        move_1[1] = (move_1[1].to_i + 1).to_s
        move_1 = move_1.join()
        moves.push(move_1)
        if start_pt.split(//)[1] == "2"
            move_2 = start_pt.split(//)
            move_2[1] = (move_2[1].to_i + 2).to_s
            move_2 = move_2.join()
            moves.push(move_2)
        end
        #right diagonal edge case
        diag_r[1] = move_1[1]
        diag_r[0] = (diag_r[0].ord + 1).chr
        diag_r = diag_r.join()
        #left diagonal edge case
        diag_l[1] = move_1[1]
        diag_l[0] = (diag_l[0].ord - 2).chr
        diag_l = diag_l.join()
        if opp_moves.key(diag_l) != nil
            diag_moves.push(diag_l)
        end
        if opp_moves.key(diag_r) != nil
            diag_moves.push(diag_r)
        end
        diag_moves
        if opp_moves.key(move_1) != nil
            moves = []
        end
        moves += diag_moves
        moves.sort
    end

    def find_p2_pawn_moves(start_pt, player_moves, opp_moves)
        #split starting point and increment column
        moves = []
        diag_moves = []
        move_1 = start_pt.split(//)
        diag_r = move_1
        diag_l = move_1
        move_1[1] = (move_1[1].to_i - 1).to_s
        move_1 = move_1.join()
        moves.push(move_1)
        if start_pt.split(//)[1] == "7"
            move_2 = start_pt.split(//)
            move_2[1] = (move_2[1].to_i - 2).to_s
            move_2 = move_2.join()
            moves.push(move_2)
        end
        #right diagonal edge case
        diag_r[1] = move_1[1]
        diag_r[0] = (diag_r[0].ord + 1).chr
        diag_r = diag_r.join()
        #left diagonal edge case
        diag_l[1] = move_1[1]
        diag_l[0] = (diag_l[0].ord - 2).chr
        diag_l = diag_l.join()
        if opp_moves.key(diag_l) != nil
            diag_moves.push(diag_l)
        end
        if opp_moves.key(diag_r) != nil
            diag_moves.push(diag_r)
        end
        diag_moves
        if opp_moves.key(move_1) != nil
            moves = []
        end
        moves += diag_moves
        moves.sort
    end

    
end

class Rook < Piece
    attr_accessor :position
    def initialize(position)
        @position = position
    end

    def test
        puts "nope"
    end

    def find_rook_moves(start_pt, player_moves, opp_moves)
        moves = []
        split_point = start_pt.split(//)
        x = 1
        x_axis = ["a", "b", "c", "d", "e", "f", "g", "h"]
        #x-axis moves
        x_axis.each do |letter|
            temp = letter + split_point[1]
            if has_player_piece?(temp, player_moves) && temp != start_pt
                break
            else
                moves.push(temp)
            end
        end 
        #y-axis moves 
        y = 1
        until y > 8
            temp = split_point
            temp = temp[0] + y.to_s
            if has_player_piece?(temp, player_moves) && temp !=start_pt
                break
            elsif has_opp_piece?(temp, opp_moves)
                moves.push(temp)  
                break
            else
                moves.push(temp) 
            end
            y += 1 
        end
        moves = moves.uniq
        st_pt_index = moves.index(start_pt)
        moves.slice!(st_pt_index)
        moves

    end

end

class Bishop < Piece

    def find_bishop_moves(start_pt, player_moves, opp_moves)
        split_point = start_pt.split(//)
        moves = []
        i = split_point[0].ord
        j = split_point[1].to_i
        
        #find up slope right moves
        until j == 8
            i += 1
            j += 1
            move = i.chr + j.to_s
            if has_player_piece?(move, player_moves) && move !=start_pt
                break
            elsif has_opp_piece?(move, opp_moves)
                moves.push(move)  
                break
            else
                moves.push(move)
            end
        end    
        #find down slope right moves
        i = split_point[0].ord
        j = split_point[1].to_i
        until j == 1
            i += 1
            j -= 1
            move = i.chr + j.to_s
            if has_player_piece?(move, player_moves) && move !=start_pt
                break
            elsif has_opp_piece?(move, opp_moves)
                moves.push(move)  
                break
            else
                moves.push(move)
            end
        end
        
        #find up slope left moves
        i = split_point[0].ord
        j = split_point[1].to_i
        until j == 8
            i -= 1
            j += 1
            move = i.chr + j.to_s
            if has_player_piece?(move, player_moves) && move !=start_pt
                break
            elsif has_opp_piece?(move, opp_moves)
                moves.push(move)  
                break
            else
                moves.push(move)
            end
        end
        #find down slope left moves
        i = split_point[0].ord
        j = split_point[1].to_i
        until j == 1
            i -= 1
            j -= 1
            move = i.chr + j.to_s
            if has_player_piece?(move, player_moves) && move !=start_pt
                break
            elsif has_opp_piece?(move, opp_moves)
                moves.push(move)  
                break
            else
                moves.push(move)
            end
        end
        moves = moves.select {|item| grid.include?(item) }.sort

    end

end

class Knight < Piece

    def find_knight_moves(start_pt, player_moves, opp_moves)
        split_point = start_pt.split(//)
        paths = [
            [1, 2],
            [1, (-2)],
            [(-1), 2],
            [(-1), (-2)],
            [2, 1],
            [2, (-1)],
            [(-2),(-1)],
            [(-2), 1]]
    
            moves = paths.reduce([]) do |sum, item|
                item[0] = (split_point[0].ord + item[0]).chr
                item[1] = (split_point[1].to_i + item[1]).to_s
                item = item.join()
                if grid.include?(item) && !has_player_piece?(item, player_moves)
                    sum.push(item)
                end
                sum
            end
            moves.sort
            
    end
end

class Queen < Piece

    def find_queen_moves(start_pt, player_moves, opp_moves)
        diagonal_lines = find_bishop_moves(start_pt, player_moves, opp_moves)
        straight_lines = find_rook_moves(start_pt, player_moves, opp_moves)
        moves = diagonal_lines + straight_lines
        moves.sort
    end
end

class King < Piece

    def find_king_moves(start_pt, player_moves, opp_moves)
        split_point = start_pt.split(//)
        paths = [[1, 1],
        [1, (-1)],
        [(-1),(-1)],
        [(-1), 1],
        [0, 1],
        [1, 0],
        [0, (-1)],
        [(-1), 0]]

        moves = paths.reduce([]) do |sum, item|
            item[0] = (split_point[0].ord + item[0]).chr
            item[1] = (split_point[1].to_i + item[1]).to_s
            item = item.join()
            if grid.include?(item) && !has_player_piece?(item, player_moves)
                sum.push(item)
            end
            sum
        end
        moves.sort
    end
end





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

