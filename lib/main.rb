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

end




# board = Gameboard.new
# board.display_grid(board.grid)
