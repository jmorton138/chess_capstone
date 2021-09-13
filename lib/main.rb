class Gameboard
    attr_reader :grid

    def initialize
        @grid = build_grid()
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

    def display_grid(sorted_grid)
        sorted_grid.each_with_index do |item, index|
            index_plus_one = index + 1
            if index_plus_one % 8 == 0
                puts " #{item} "
                puts "--------------------------------"
            else
                print " #{item} "
            end
        end
        puts ""
    end

    def find_pawn_moves(start_pt)
        #split starting point and increment column
        moves = []
        move_1 = start_pt.split(//)
        move_1[1] = (move_1[1].to_i + 1).to_s
        move_1 = move_1.join()
        moves.push(move_1)
        if start_pt.split(//)[1] == "2"
            move_2 = start_pt.split(//)
            move_2[1] = (move_2[1].to_i + 2).to_s
            move_2 = move_2.join()
            moves.push(move_2)
        end
        moves
        #add 1 to asccii
        #arr[1] = (arr[1].to_i + 1).to_s
        #convert back into chess notation
        #return space coordinates
    end

    def find_rook_moves(start_pt)
        moves = []
        split_point = start_pt.split(//)
        x = 1
        x_axis = ["a", "b", "c", "d", "e", "f", "g", "h"]
        #x-axis moves
        x_axis.each do |letter|
            temp = letter + split_point[1]
            moves.push(temp)
            x += 1
        end 
        #y-axis moves 
        y = 1
        until y > 8
            temp = split_point
            temp = temp[0] + y.to_s
            moves.push(temp)
            y += 1 
        end
        moves = moves.uniq
        st_pt_index = moves.index(start_pt)
        moves.slice!(st_pt_index)
        moves

    end
    def find_knight_moves(start_pt)
 
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
                sum.push(item.join())
            end
            moves.sort
    end
end




# board = Gameboard.new
# board.display_grid(board.grid)

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