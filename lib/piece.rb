class Piece 
    attr_reader :type
    attr_accessor :type, :color

    def initialize(type, color)
        @type = type
        @color = color
    end
end