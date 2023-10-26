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