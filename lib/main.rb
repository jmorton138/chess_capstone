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
            pawns << Piece.new(Pawn.new(position, piece_color), piece_color)
            i += 1
        end 
        pawns << Piece.new(King.new("a#{y+4}", piece_color), piece_color)

    end

    ##needs updating
    def update_player_moves(start_pt, end_pt)
        self.pieces.each do |piece|
            if piece.type.position == start_pt
                piece.type.position = end_pt
            end
        end 
    end

    def capture?(move)
        split = move.split(//)
        end_pt = split[2] + split[3]
        self.pieces.each do |piece|
            if piece.type.position == end_pt
                piece.type.position = "captured"
                return
            end
        end
        false
    end

    def return_moves_array
        array = []
        self.pieces.map do |piece|
            array << piece.type.position
        end
        array
    end

    # king moving to a space where is check
    def return_king_moves_checks_array(opponent)
        potential_moves = []
        player_moves = self.return_moves_array
        opp_moves = opponent.return_moves_array

        #all of moves opponent could make on next turn
        opponent.pieces.each do |piece|
            potential_moves << piece.type.find_moves(player_moves, opp_moves)
        end
        potential_moves.flatten
        ## is end_pt of king in potential_moves array
    end

    # if another piece moving to end_pt puts king in check
    def checks_array_after_move(move, opponent)
        split = move.split(//)
        start_pt = split[0] + split[1]
        end_pt = split[2] + split[3]
        #create temp player class
        dummy_player = Player.new(self.piece_color)
        self.pieces.each_with_index do |item, index|
            dummy_player.pieces[index].type.position  = item.type.position
        end
        #update dummy_player's pieces so move has been completed
        dummy_player.pieces.each do |piece|
            if piece.type.position == start_pt
                piece.type.position = end_pt
            end
        end
        #build array with this updated move
        potential_moves = []
        player_moves = dummy_player.pieces.map {|item| item.type.position}
        opp_moves = opponent.return_moves_array
        #all of moves opponent could make on next turn
        opponent.pieces.each do |piece|  
            potential_moves << piece.type.find_moves(opp_moves, player_moves)
        end
        potential_moves.flatten
    end

    def is_king?(move)
        split = move.split(//)
        start_pt = split[0] + split[1]
        piece = self.pieces.select { |piece| piece.type.position == start_pt }
        if piece[0].type.class == King
            return true
        else
            return false
        end
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

class Checks
end

class Pawn < Piece
    attr_accessor :position
    attr_reader :piece_color
    def initialize(position, piece_color)
        @position = position
        @piece_color = piece_color
    end

    def find_moves(player_moves, opp_moves)
        start_pt = self.position
        moves = []
        diag_moves = []
        move_1 = start_pt.split(//)
        diag_r = move_1
        diag_l = move_1
        y = 1
        self.piece_color == "white" ? y : y = (-1)
        move_1[1] = (move_1[1].to_i + y).to_s
        move_1 = move_1.join()
        moves.push(move_1)
        if start_pt.split(//)[1] == "2" || start_pt.split(//)[1] == "7"
            move_2 = start_pt.split(//)
            move_2[1] = (move_2[1].to_i + (2*y)).to_s
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
        if opp_moves.include?(diag_l)
            diag_moves.push(diag_l)
        end
        if opp_moves.include?(diag_r)
            diag_moves.push(diag_r)
        end
        # diag_moves
        if opp_moves.include?(move_1) || player_moves.include?(move_1)
            moves = []
        elsif opp_moves.include?(move_2) || player_moves.include?(move_2)
            moves.delete(move_2)
        end
        moves += diag_moves
        moves.sort
    end

    
end

class Rook < Piece
    attr_accessor :position
    def initialize(position, piece_color)
        @position = position
        @piece_color = piece_color
    end

    def find_moves(player_moves, opp_moves)
        start_pt = self.position
        moves = []
        split_point = start_pt.split(//)
        x = 1
        x_axis = ["a", "b", "c", "d", "e", "f", "g", "h"]
        #x-axis moves
        x_axis.each do |letter|
            temp = letter + split_point[1]
            if player_moves.include?(temp) && temp != start_pt
                break
            elsif opp_moves.include?(temp)
                moves.push(temp)
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
            if player_moves.include?(temp) && temp != start_pt
                break
            elsif opp_moves.include?(temp)
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
    attr_accessor :position

    def initialize(position, piece_color)
        @position = position
        @piece_color = piece_color
    end

    def find_moves(player_moves, opp_moves)
        start_pt = self.position
        split_point = start_pt.split(//)
        moves = []
        i = split_point[0].ord
        j = split_point[1].to_i
        grid = Gameboard.new.grid
        #find up slope right moves
        until j == 8
            i += 1
            j += 1
            move = i.chr + j.to_s
            if player_moves.include?(move) && move !=start_pt
                break
            elsif opp_moves.include?(move) #has_opp_piece?(move, opp_moves)
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
            if player_moves.include?(move) && move != start_pt 
                break
            elsif opp_moves.include?(move)
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
            if player_moves.include?(move) && move != start_pt 
                break
            elsif opp_moves.include?(move)
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
            if player_moves.include?(move) && move != start_pt 
                break
            elsif opp_moves.include?(move)
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
    attr_accessor :position

    def initialize(position, piece_color)
        @position = position
        @piece_color = piece_color
    end

    def find_moves(player_moves, opp_moves)
        start_pt = self.position
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
            board = Gameboard.new
            moves = paths.reduce([]) do |sum, item|
                item[0] = (split_point[0].ord + item[0]).chr
                item[1] = (split_point[1].to_i + item[1]).to_s
                item = item.join()
                if !player_moves.include?(item) && board.grid.include?(item) 
                    sum.push(item)
                end
                sum
            end
            moves.sort
            
    end
end

class Queen < Piece
    attr_accessor :position
    attr_reader :piece_color

    def initialize(position, piece_color)
        @position = position
        @piece_color = piece_color
    end
    def find_moves(player_moves, opp_moves)
        start_pt = self.position
        diagonal_lines = Bishop.new(start_pt, piece_color).find_moves(player_moves, opp_moves)
        straight_lines = Rook.new(start_pt, piece_color).find_moves(player_moves, opp_moves)
        moves = diagonal_lines + straight_lines
        moves.sort
    end
end

class King < Piece
    attr_accessor :piece_color, :position

    def initialize(position, piece_color)
        @position = position
        @piece_color = piece_color
    end

    def find_moves(player_moves, opp_moves)
        split_point = self.position.split(//)
        paths = [[1, 1],
        [1, (-1)],
        [(-1),(-1)],
        [(-1), 1],
        [0, 1],
        [1, 0],
        [0, (-1)],
        [(-1), 0]]
        moves = []
        board = Gameboard.new

        moves = paths.reduce([]) do |sum, item|
            item[0] = (split_point[0].ord + item[0]).chr
            item[1] = (split_point[1].to_i + item[1]).to_s
            item = item.join()
            if !player_moves.include?(item) && board.grid.include?(item) 
                sum.push(item)
            end
            sum
        end
        #if move is in checks array
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

