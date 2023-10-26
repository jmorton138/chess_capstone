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