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
            elsif opp_moves.include?(move)
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