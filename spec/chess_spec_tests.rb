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

    describe "#find_knight_moves" do
        context "when white knight is at d3 with no obstructions" do
            subject(:knight_moves) { described_class.new }
            
            it "returns ['b2', 'b4', 'c1', 'c5', 'e1', 'e5', 'f2', 'f4']" do
                moves = ["c1", "b2", "b4", "c5", "e5", "f4", "f2", "e1"].sort
                expect(knight_moves.find_knight_moves("d3")).to eq(moves)
                knight_moves.find_knight_moves("d3")
            end
        end

        context "when white knight  is at b3" do
            subject(:knight_moves_bounds) { described_class.new }

            it "only returns moves on the board ['a1','a5', 'c1', 'c5', 'd2', 'd4']" do
                moves = ["a1","a5", "c1", "c5", "d2", "d4"].sort
                expect(knight_moves_bounds.find_knight_moves("b3")).to eq(moves)
                knight_moves_bounds.find_knight_moves("b3")
            end
        end
    end

    describe "#find_bishop_moves" do
        context "when white bishop is at e4 with no obstructing pieces" do
            subject(:bishop_moves) { described_class.new }

            it "returns available moves [b1, c2, d3, f5, g6, h7, h1, g2, f3, d5, c6, b7, a8]" do
                moves = ["b1", "c2", "d3", "f5", "g6", "h7", "h1", "g2", "f3", "d5", "c6", "b7", "a8"].sort
                expect(bishop_moves.find_bishop_moves("e4")).to eq(moves)
                bishop_moves.find_knight_moves("e4")
            end
        end
    end

    describe "#find_queen_moves" do
        context "when white queen is at e4 with no obstructing pieces" do
            subject(:queen_moves) { described_class.new }

            it "returns available moves at [b1, c2, d3, f5, g6, h7, h1, g2, f3, d5, c6, b7, a8, e1, e2, e3, e5, e6, e7, e8, a4, b4, c4, c5, c6, c7, c8]" do
                moves = ["b1", "c2", "d3", "f5", "g6", "h7", "h1", "g2", "f3", "d5", "c6", "b7", "a8", "e1", "e2", "e3", "e5", "e6", "e7", "e8", "a4", "b4", "c4", "d4", "f4", "g4", "h4"].sort
                expect(queen_moves.find_queen_moves("e4")). to eq(moves)
                queen_moves.find_queen_moves("e4")
            end
        end
    end

    describe "#find_king_moves" do
        context "when white king is at e4 with no obstructing pieces or checks" do
            subject(:king_moves) { described_class.new }

            it "returns moves [d5, e5, f5, d4, f4, d3, e3, f3]" do
                moves = ["d5", "e5", "f5", "d4", "f4", "d3", "e3", "f3"].sort
                expect(king_moves.find_king_moves("e4")).to eq(moves)
                king_moves.find_king_moves("e4")
            end
        end
    end

    describe "#validate_player_input" do
        context "when player inputs coordinates b1b2(invalid) at start of game" do
            subject(:validate_player_input_invalid) { described_class.new }
            let(:moves)  {
                {
                pawn1: "a2",
                pawn2: "b2",
                pawn3: "c2",
                pawn4: "d2",
                pawn5: "e2",
                pawn6: "f2",
                pawn7: "g2",
                pawn8: "h2",
                rook1: "a1",
                knght1: "b1",
                bish1: "c1",
                queen: "d1",
                King: "e1",
                bish2: "f1",
                knght2: "g1",
                rook2: "h1"
            }
        }
            it "returns false" do
                expect(validate_player_input_invalid.validate_player_input("b1b2", moves)).to eq(false)
                validate_player_input_invalid.validate_player_input("b1b2", moves)
            end

        end

        context "when player inputs coordinates a2a3(valid) at start of game" do
            subject(:validate_player_input_valid) { described_class.new }
            let(:moves)  {
                {
                pawn1: "a2",
                pawn2: "b2",
                pawn3: "c2",
                pawn4: "d2",
                pawn5: "e2",
                pawn6: "f2",
                pawn7: "g2",
                pawn8: "h2",
                rook1: "a1",
                knght1: "b1",
                bish1: "c1",
                queen: "d1",
                King: "e1",
                bish2: "f1",
                knght2: "g1",
                rook2: "h1"
            }
        }
            it "returns true" do
                expect(validate_player_input_valid.validate_player_input("a2a3", moves)).to eq(true)
                validate_player_input_valid.validate_player_input("a2a3", moves)
            end
        end
    end

    describe "#return_piece_type" do
        context "when starting input coordinate is b1" do
            subject(:return_piece_type) { described_class.new }
            it "returns pawn" do
                moves = {
                    pawn1: "a2",
                    pawn2: "b2",
                    pawn3: "c2",
                    pawn4: "d2",
                    pawn5: "e2",
                    pawn6: "f2",
                    pawn7: "g2",
                    pawn8: "h2",
                    rook1: "a1",
                    knght1: "b1",
                    bish1: "c1",
                    queen: "d1",
                    King: "e1",
                    bish2: "f1",
                    knght2: "g1",
                    rook2: "h1"
                }
                expect(return_piece_type.return_piece_type("b2", moves)).to eq("pawn")
                return_piece_type.return_piece_type("b2", moves)
            end
        end
    end

    describe "#return_available_moves" do
        context "when piece/arg is a pawn at b2" do
            subject(:find_moves) { described_class.new }
            before do
                allow(find_moves).to receive(:find_pawn_moves).with("b2")
            end
            it "receives #find_pawn_moves" do
                piece = "pawn"
                expect(find_moves).to receive(:find_pawn_moves).with("b2")
                find_moves.return_available_moves(piece, "b2")
            end
        end

        context "when piece/arg is a knight at b4" do
            subject(:find_moves) { described_class.new }
            before do
                allow(find_moves).to receive(:find_knight_moves).with("b4")
            end
            it "receives #find_knight_moves" do
                piece = "knight"
                expect(find_moves).to receive(:find_knight_moves).with("b4")
                find_moves.return_available_moves(piece, "b4")
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
