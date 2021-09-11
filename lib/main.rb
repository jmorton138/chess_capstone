class Gameboard
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

    def dispay_grid(grid)
        new_grid = []
        i = 8
        until i < 1 do
            new_grid += grid.select { |item| item.include?(i.to_s) }
            i -= 1
        end
       p new_grid
    end
    
end








# grid = build_grid()
# dispay_grid(grid)