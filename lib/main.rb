require 'colorize'


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
        #new_grid = build_grid()
        self.grid_with_pieces = build_grid()
    end

    def update_board(p1, p2)
        self.grid.each_with_index do |item, index|
            index_plus_one = index + 1
            p1.pieces.select do |piece|
                if piece.type.position == item
                #     #self.grid_with_pieces[index] = piece.type.class.to_s[0..1]
      
                    if piece.type.class == Pawn
                        self.grid_with_pieces[index] = " #{"\u2659".encode("utf-8")}"
                    elsif piece.type.class == Rook
                        self.grid_with_pieces[index] = " #{"\u2656".encode("utf-8")}"
                    elsif piece.type.class == Bishop
                        self.grid_with_pieces[index] = " #{"\u2657".encode("utf-8")}"
                    elsif piece.type.class == Knight
                        self.grid_with_pieces[index] = " #{"\u2658".encode("utf-8")}"
                    elsif piece.type.class == Queen
                        self.grid_with_pieces[index] = " #{"\u2655".encode("utf-8")}" 
                    elsif piece.type.class == King
                        self.grid_with_pieces[index] = " #{"\u2654".encode("utf-8")}" 
                    end
                end
                
            end
            p2.pieces.select do |piece|
                if piece.type.position == item
                    #self.grid_with_pieces[index] = piece.type.class.to_s[0..1]
                    if piece.type.class == Pawn
                        self.grid_with_pieces[index] = " #{"\u265F".encode("utf-8")}".black
                    elsif piece.type.class == Rook
                        self.grid_with_pieces[index] = " #{"\u265C".encode("utf-8")}".black
                    elsif piece.type.class == Bishop
                        self.grid_with_pieces[index] = " #{"\u265D".encode("utf-8")}".black
                    elsif piece.type.class == Knight
                        self.grid_with_pieces[index] = " #{"\u265E".encode("utf-8")}".black
                    elsif piece.type.class == Queen
                        self.grid_with_pieces[index] = " #{"\u265B".encode("utf-8")}".black
                    elsif piece.type.class == King
                        self.grid_with_pieces[index] = " #{"\u265A".encode("utf-8")}".black
                    end
                end

            end
        end
    end

    def display_grid
        y = 8
        print "#{y} "
        grid_with_pieces.each_with_index do |item, index|
            if item[0] == "a" || item[0] == "b" || item[0] == "c" || item[0] == "d" || item[0] == "e" || item[0] == "f" || item[0] == "g" || item[0] == "h"
                
                item = "  "
            end
            index_plus_one = index + 1
            if index_plus_one % 8 == 0
                y -= 1
                
                puts " #{item}  ".on_light_magenta if y.odd?
                puts " #{item}  ".on_light_cyan if y.even?
                print "#{y} " unless y == 0
            elsif y.even?
                print " #{item}  ".on_light_cyan if index.even?
                print " #{item}  ".on_light_magenta if index.odd?
            elsif y.odd?
                print " #{item}  ".on_light_magenta if index.even?
                print " #{item}  ".on_light_cyan if index.odd?
            end
            
        end
        
        ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'].each {|item| print "    #{item}"}
        puts ""
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
        pieces = []
        i = 1
        y = 2
        self.piece_color == "black" ? y = 7 : y
        self.piece_color == "black" ? i = 8 : i
        x_axis.each do |letter|
            position = letter + y.to_s
            pieces << Piece.new(Pawn.new(position, piece_color), piece_color)
        end 
        pieces
        x_axis.each do |letter|
            position = letter + i.to_s
            pieces << Piece.new(Rook.new(position, piece_color), piece_color) if letter == "a" || letter == "h"
            pieces << Piece.new(Knight.new(position, piece_color), piece_color) if letter == "b" || letter == "g"
            pieces << Piece.new(Bishop.new(position, piece_color), piece_color) if letter == "c" || letter == "f"
            pieces << Piece.new(Queen.new(position, piece_color), piece_color) if letter == "d"
            pieces << Piece.new(King.new(position, piece_color), piece_color) if letter == "e"
        end
        pieces

    end

    def update_player_moves(move)
        split = move.split(//)
        start_pt = split[0] + split[1]
        end_pt = split[2] + split[3]

        self.pieces.each do |piece|
            if piece.type.position == start_pt
                piece.type.position = end_pt
            end
        end 
    end


    def capture(move)
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

    def return_positions_array
        array = []
        self.pieces.map do |piece|
            array << piece.type.position
        end
        array
    end

    def validate_player_input(input, opponent)
        
        player_moves = self.return_positions_array
        opp_moves = opponent.return_positions_array
        board = Gameboard.new
        return false if input.length > 4
        sliced = input.chars.each_slice(2).map(&:join)
        #check if starting point is point on the board
        return false if !board.grid.include?(sliced[0])
        #check if starting point has player's piece on it
        return false if !player_moves.include?(sliced[0])
        # find chess piece object and set as variable
        moving_piece = self.pieces.select { |piece| piece.type.position == sliced[0] }[0]
        valid_moves = moving_piece.type.find_moves(player_moves, opp_moves)
        player_king = self.pieces.select { |piece| piece.type.class == King }
        #handle possible checks
        if self.is_king?(input)
            #this turn if king moves is it putting itself in check
            self.return_opp_potential_moves(opponent).each do |move|
                curr_piece = opponent.pieces.select { |item| item.type.position == move }
                if valid_moves.include?(move) && curr_piece[0] != nil && curr_piece[0].type.class == Pawn
                    valid_moves.delete(move)
                end
            end
            valid_moves
            self.next_turn_potential_moves(input, opponent).each do |move|
                if sliced[1] == move
                    puts "That'd be a check"
                    valid_moves.delete(move)
                end
                valid_moves
            end
        else
        #     #player's king is at that location
            self.next_turn_potential_moves(input, opponent).each do |move|
                
                if player_king[0].type.position == move
                    puts "That'd be a check"
                    valid_moves = []
                end
                valid_moves

            end
            valid_moves
        end
        valid_moves
        if valid_moves.include?(sliced[1])
            return true
        else
            return false
        end
    end


    def return_opp_potential_moves(opponent)
        opp_potential_moves = []
        player_moves = self.return_positions_array
        opp_moves = opponent.return_positions_array

        #all of moves opponent could make on next turn
        opponent.pieces.each do |piece|
            opp_potential_moves << piece.type.find_moves(opp_moves, player_moves)
        end
        opp_potential_moves.flatten.uniq
        ## is end_pt of king in potential_moves array?
    end

    # returns opponents potential moves for next turn if player makes a certain move
    def next_turn_potential_moves(move, opponent)
        split = move.split(//)
        start_pt = split[0] + split[1]
        end_pt = split[2] + split[3]
        #create temp player class
        dummy_player = create_dummy_player
        #puts dummy_player.piece_color
        #update dummy_player's pieces so move has been completed
        #in theory king should have captured pawn so king is in queen's moves
        #maybe because pawn isn't marked as captured in hypo it still block's queen
        dummy_player.pieces.each do |piece|
            if piece.type.position == start_pt
                piece.type.position = end_pt
            end
            piece
        end
        dummy_player
        #build array with this updated move
        potential_moves = []
        player_moves = dummy_player.pieces.map {|item| item.type.position}
        opp_moves = opponent.return_positions_array
        #all of moves opponent could make on next turn
        player_moves.each do |move|
            if opp_moves.include?(move)
                opp_moves.delete(move)
            end
            opp_moves
        end
        opp_moves
        opponent.pieces.each do |piece|  
            potential_moves << piece.type.find_moves(opp_moves, player_moves)
            #potential_moves << piece.type.find_moves(player_moves, opp_moves)
        end
        potential_moves.flatten.uniq.sort
        #dummy_player.king_in_check?(opponent)
    end

    # if another piece moving to end_pt puts king in check
    def create_dummy_player
        dummy_player = Player.new(self.piece_color)
        self.pieces.each_with_index do |item, index|
            dummy_player.pieces[index].type.position  = item.type.position
        end 
        dummy_player   
    end

    def is_king?(move)
        split = move.split(//)
        start_pt = split[0] + split[1]
        piece = self.pieces.select { |piece| piece.type.position == start_pt }
        if piece[0] == nil || piece[0].type.class != King
            return false
        elsif piece[0].type.class == King
            return true
        end
    end

    def king_in_check?(opponent)
        king = self.pieces.select { |piece| piece.type.class == King }
        opp_moves = self.return_opp_potential_moves(opponent).select { |move| move == king[0].type.position }
        if opp_moves.empty?
            return false
        elsif !opp_moves.empty?
            return true
        end
    end

    def checkmate?(opponent)
        player_potential_moves = []
        opp_potential_moves = []
        checks = []
        moves = []
        player_positions = self.return_positions_array
        opp_positions = opponent.return_positions_array
        #find all player's potential moves from current place
        self.pieces.each do |piece|
            joined = nil
            piece.type.find_moves(player_positions, opp_positions).each do |move|
                joined = piece.type.position + move
                player_potential_moves << joined
            end
            player_potential_moves 
        end
        player_potential_moves
        
        player_potential_moves.each do |move|
            dummy_player = create_dummy_player
            dummy_player.update_player_moves(move)
            
            checks << dummy_player.king_in_check?(opponent)
            #moves << move
            dummy_player
        end
        checks
        #if all player_potential_moves put player in check
        if checks.all?(true)
            p "checkmate"
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
    attr_accessor :position, :piece_color
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
        x_index = x_axis.index(split_point[0])
        x_axis_r = x_axis[x_index..7]
        x_axis_l = x_axis[0..x_index].reverse
        x_axis_r.each do |letter|
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

        x_axis_l.each do |letter|
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
        y_axis = ["1", "2", "3", "4", "5", "6", "7", "8"]
        y_index = y_axis.index(split_point[1])
        y_axis_up = y_axis[y_index..7]
        y_axis_down = y_axis[0..y_index].reverse
        y = 1
        z = 8
        #self.piece_color == "white" ? y_axis : y_axis = y_axis.reverse
        # for y in y_axis do
        #     temp = split_point
        #     temp = temp[0] + y.to_s
        #     if player_moves.include?(temp) && temp != start_pt
        #         break
        #     elsif opp_moves.include?(temp)
        #         moves.push(temp)
        #         break
        #     else
        #         moves.push(temp)
        #     end
        #     y += 1 
        # end

        y_axis_up.each do |num|
            temp = split_point
            temp = temp[0] + num.to_s
            if player_moves.include?(temp) && temp != start_pt
                break
            elsif opp_moves.include?(temp)
                moves.push(temp)
                break
            else
                moves.push(temp)
            end
        end

        y_axis_down.each do |num|
            temp = split_point
            temp = temp[0] + num.to_s
            if player_moves.include?(temp) && temp != start_pt
                break
            elsif opp_moves.include?(temp)
                moves.push(temp)
                break
            else
                moves.push(temp)
            end
        end

        moves = moves.uniq
        st_pt_index = moves.index(start_pt)
        moves.slice!(st_pt_index) if st_pt_index != nil
        moves.sort

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
        until j >= 8
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
        until j <= 1
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
        until j >= 8
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
        until j <= 1
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

