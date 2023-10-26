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