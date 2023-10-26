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
            # see if move would put player's king in check
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
    end

    # returns opponents potential moves for next turn if player makes a certain move
    def next_turn_potential_moves(move, opponent)
        split = move.split(//)
        start_pt = split[0] + split[1]
        end_pt = split[2] + split[3]
        #create temp player class
        dummy_player = create_dummy_player
        #update dummy_player's pieces so move has been completed
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
        end
        potential_moves.flatten.uniq.sort
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
            dummy_player
        end
        checks
        #if all player_potential_moves put player in check
        if checks.all?(true)
            return true 
        else
            return false
        end

    end

    
end