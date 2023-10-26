require 'colorize'
require_relative 'piece'
require_relative 'king'
require_relative 'knight'
require_relative 'pawn'
require_relative 'player'
require_relative 'queen'
require_relative 'rook'
require_relative 'bishop'

class Gameboard
    attr_accessor :grid, :grid_with_pieces

    def initialize
        @grid = build_grid()
        @grid_with_pieces = build_grid()
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

    def refresh_board
        self.grid_with_pieces = build_grid()
    end

    def update_board(p1, p2)
        self.grid.each_with_index do |item, index|
            index_plus_one = index + 1
            p1.pieces.select do |piece|
                if piece.type.position == item
      
                    if piece.type.class == Pawn
                        self.grid_with_pieces[index] = " #{"\u2659".encode("utf-8")}"
                    elsif piece.type.class == Rook
                        self.grid_with_pieces[index] = " #{"\u2656".encode("utf-8")}"
                    elsif piece.type.class == Bishop
                        self.grid_with_pieces[index] = " #{"\u2657".encode("utf-8")}"
                    elsif piece.type.class == Knight
                        self.grid_with_pieces[index] = " #{"\u2658".encode("utf-8")}"
                    elsif piece.type.class == Queen
                        self.grid_with_pieces[index] = " #{"\u2655".encode("utf-8")}" 
                    elsif piece.type.class == King
                        self.grid_with_pieces[index] = " #{"\u2654".encode("utf-8")}" 
                    end
                end
                
            end
            p2.pieces.select do |piece|
                if piece.type.position == item
                    if piece.type.class == Pawn
                        self.grid_with_pieces[index] = " #{"\u265F".encode("utf-8")}".black
                    elsif piece.type.class == Rook
                        self.grid_with_pieces[index] = " #{"\u265C".encode("utf-8")}".black
                    elsif piece.type.class == Bishop
                        self.grid_with_pieces[index] = " #{"\u265D".encode("utf-8")}".black
                    elsif piece.type.class == Knight
                        self.grid_with_pieces[index] = " #{"\u265E".encode("utf-8")}".black
                    elsif piece.type.class == Queen
                        self.grid_with_pieces[index] = " #{"\u265B".encode("utf-8")}".black
                    elsif piece.type.class == King
                        self.grid_with_pieces[index] = " #{"\u265A".encode("utf-8")}".black
                    end
                end

            end
        end
    end

    def display_grid
        y = 8
        print "#{y} "
        grid_with_pieces.each_with_index do |item, index|
            if item[0].ord >= 97 && item[0].ord <= 104                
                item = "  "
            end
            index_plus_one = index + 1
            if index_plus_one % 8 == 0
                y -= 1
                
                puts " #{item}  ".on_light_magenta if y.odd?
                puts " #{item}  ".on_light_cyan if y.even?
                print "#{y} " unless y == 0
            elsif y.even?
                print " #{item}  ".on_light_cyan if index.even?
                print " #{item}  ".on_light_magenta if index.odd?
            elsif y.odd?
                print " #{item}  ".on_light_magenta if index.even?
                print " #{item}  ".on_light_cyan if index.odd?
            end
            
        end
        
        ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'].each {|item| print "    #{item}"}
        puts ""
    end




end