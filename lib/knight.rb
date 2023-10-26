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