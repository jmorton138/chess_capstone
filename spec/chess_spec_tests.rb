require_relative '../lib/main.rb'

describe Gameboard do
    describe "#find_pawn_moves" do
        context "when white pawn starts at a3 with no pawns at diagonal" do
            subject(:simple_pawn_move) { described_class.new }
            it "returns a4" do
                expect(simple_pawn_move.find_pawn_moves("a3")).to eq(["a4"])
                simple_pawn_move.find_pawn_moves("a3")
            end
        end
        
        context "when white pawn start makes first move at c2 with no pawns at diagonal" do
            subject(:init_pawn) { described_class.new }
            it "returns ['c3', 'c4']" do
                expect(init_pawn.find_pawn_moves("c2")).to eq(["c3", "c4"])
                init_pawn.find_pawn_moves("c2")
            end
        end
        #handle diagonals in both directions"
        #handles being blocked by opponnents piece
    end

    describe "#find_rook_moves" do
        context "when white rook is at b1 with no obstructions" do
            subject(:rook_moves) { described_class.new }

            it "returns ['a1', 'c1', 'd1', 'e1', 'f1', 'g1', 'h1', 'b2', 'b3', 'b4', 'b5', 'b6', 'b7', 'b8']" do
                moves = ["a1", "c1", "d1", "e1", "f1", "g1", "h1", "b2", "b3", "b4", "b5", "b6", "b7", "b8"]
                expect(rook_moves.find_rook_moves("b1")).to eq(moves)
            end
        end

        context "when white rook is at c4 with no obstructions" do
            subject(:rook_moves_2) { described_class.new }

            it "returns ['a4', 'b4','d4', 'e4', 'f4', 'g4', 'h4', 'c1', 'c2', 'c3', 'c5', 'c6', 'c7', 'c8']" do
                moves = ["a4", "b4","d4", "e4", "f4", "g4", "h4", "c1", "c2", "c3", "c5", "c6", "c7", "c8"]
                expect(rook_moves_2.find_rook_moves("c4")).to eq(moves)
            end
        end
    end
end




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
