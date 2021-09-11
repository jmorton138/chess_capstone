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
    end

    def sort_grid(grid = self.grid)
        new_grid = []
        i = 8
        until i < 1 do
            new_grid += grid.select { |item| item.include?(i.to_s) }
            i -= 1
        end
       new_grid
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

end




board = Gameboard.new
sorted_grid = board.sort_grid
board.display_grid(sorted_grid)
