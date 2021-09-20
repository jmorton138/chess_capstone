require_relative '../lib/main.rb'
describe Pawn do

    describe "#find_moves" do
        
        context "when white pawn starts at a3 with no pawns at diagonal" do
            subject(:simple_pawn_move) { described_class.new("a3", "white") }
            
            it "returns a4" do
                opp_moves = []
                player_moves = ["a3"]
                expect(simple_pawn_move.find_moves(player_moves, opp_moves)).to eq(["a4"])
                simple_pawn_move.find_moves(player_moves, opp_moves)
            end
        end
        
        context "when white pawn start makes first move at c2 with no pawns at diagonal" do
            subject(:init_pawn) { described_class.new("c2", "white") }
            it "returns ['c3', 'c4']" do
                opp_moves = []
                player_moves = ["c2"]
                expect(init_pawn.find_moves(player_moves, opp_moves)).to eq(["c3", "c4"])
                init_pawn.find_moves(player_moves, opp_moves)
            end
        end
        
        context "when white pawn at c2 is blocked by opponent piece at c3" do
            subject(:blocked_pawn) { described_class.new("c2", "white") }

            it "returns empty array, no valid moves" do
                opp_moves = ["c3"]
                player_moves = ["c2"]
                expect(blocked_pawn.find_moves(player_moves, opp_moves)).to eq([])
                blocked_pawn.find_moves(player_moves, opp_moves)
            end
        end

        context "when white pawn has opponnent's pawn at diagonal d3" do
            subject(:opp_pawn_at_diag) { described_class.new("c2", "white") }

            it "adds d3 to available moves" do
                opp_moves = ["d3"]
                player_moves = ["c2"]
                moves = ["c3", "c4", "d3"]
                expect(opp_pawn_at_diag.find_moves(player_moves, opp_moves)).to eq(moves)
                opp_pawn_at_diag.find_moves(player_moves, opp_moves)
            end
        end

        context "when white pawn has opponnent's pawns at diagonal d3 and diagonal b3" do
            subject(:opp_pawns_at_diags) { described_class.new("c2", "white") }

            it "adds b3 and d3 to available moves" do
                opp_moves = ["d3", "b3"]
                player_moves = ["c2"]
                moves = ["b3", "c3", "c4", "d3"]
                expect(opp_pawns_at_diags.find_moves(player_moves, opp_moves)).to eq(moves)
                opp_pawns_at_diags.find_moves(player_moves, opp_moves)
            end
        end

        context "when white pawn has opponnent's pawns at diagonal d3, diagonal b3, and blocked at c3" do
            subject(:opp_pawns_at_diags_block) { described_class.new("c2", "white") }

            it "adds b3 and d3 to available moves" do
                opp_moves = ["d3", "b3", "c3"]
                player_moves = ["c2"]
                moves = ["b3", "d3"]
                expect(opp_pawns_at_diags_block.find_moves(player_moves, opp_moves)).to eq(moves)
                opp_pawns_at_diags_block.find_moves(player_moves, opp_moves)
            end
        end

        context "When white pawn has own piece one space ahead with no opp diagonal pieces" do 
            subject(:pawn_self_block) { described_class.new("c2", "white") }

            it "returns empty array" do
                opp_moves = []
                player_moves = ["c3"]
                expect(pawn_self_block.find_moves(player_moves, opp_moves)).to eq([])
                pawn_self_block.find_moves(player_moves, opp_moves)
            end
        end
        
        context "When white pawn has own piece 2 ahead for first move" do 
            subject(:pawn_self_block_2) { described_class.new("c2", "white") }

            it "returns c3" do
                opp_moves = []
                player_moves = ["c4"]
                expect(pawn_self_block_2.find_moves(player_moves, opp_moves)).to eq(["c3"])
                pawn_self_block_2.find_moves(player_moves, opp_moves)
            end
        end

        context "when black pawn makes first move at c7 with no pawns at diagonal" do
            subject(:init_p2_pawn) { described_class.new("c7", "black") }
            
            it "returns ['c5', 'c6']" do
                player_moves = []
                opp_moves = []
                moves = ["c5", "c6"]
                expect(init_p2_pawn.find_moves(player_moves, opp_moves)).to eq(moves)
                init_p2_pawn.find_moves(player_moves, opp_moves)
            end
        end
        
        context "when black pawn at c7 is blocked by piece at c6" do
            subject(:blocked_p2_pawn) { described_class.new("c7", "black") }
  
            it "returns empty array, no valid moves" do
                player_moves = []
                opp_moves = ["c6"]
                moves = []
                expect(blocked_p2_pawn.find_moves(player_moves, opp_moves)).to eq([])
                blocked_p2_pawn.find_moves(player_moves, opp_moves)
            end
        end

        context "when black pawn is at c6 and has opponnent's pawn at diagonal d5" do
            subject(:opp_p2_pawn_at_diag) { described_class.new("c6", "black")}

            it "adds d5 to available moves" do
                opp_moves = ["d5"]
                player_moves = []
                moves = ["c5", "d5"].sort
                expect(opp_p2_pawn_at_diag.find_moves(player_moves, opp_moves)).to eq(moves)
                opp_p2_pawn_at_diag.find_moves(player_moves, opp_moves)
            end
        end

        context "when black pawn is at c7 and has opponnent's pawns at diagonal d6 and diagonal b6" do
            subject(:opp_p2_pawns_at_diags) { described_class.new("c7", "black") }

            it "adds b3 and d3 to available moves" do
                opp_moves = ["d6", "b6"]
                player_moves = []
                moves = ["b6", "c6", "c5", "d6"].sort
                expect(opp_p2_pawns_at_diags.find_moves(player_moves, opp_moves)).to eq(moves)
                opp_p2_pawns_at_diags.find_moves(player_moves, opp_moves)
            end
        end

        context "when black pawn is at c4 and has opponnent's pawns at diagonal d3, diagonal b3, and blocked at c3" do
            subject(:opp_p2_pawns_at_diags_block) { described_class.new("c4", "black") }

            it "adds b3 and d3 to available moves" do
                opp_moves = ["d3", "b3", "c3"]
                player_moves = []
                moves = ["b3", "d3"]
                expect(opp_p2_pawns_at_diags_block.find_moves(player_moves, opp_moves)).to eq(moves)
                opp_p2_pawns_at_diags_block.find_moves(player_moves, opp_moves)
            end
        end

    end
end

describe Rook do
        describe "#find_rook_moves" do
        context "when white rook is at b1 with no obstructions" do
            subject(:rook_moves) { described_class.new("b1", "white") }

            it "returns ['a1', 'c1', 'd1', 'e1', 'f1', 'g1', 'h1', 'b2', 'b3', 'b4', 'b5', 'b6', 'b7', 'b8']" do
                player_moves = []
                opp_moves = []
                moves = ["a1", "c1", "d1", "e1", "f1", "g1", "h1", "b2", "b3", "b4", "b5", "b6", "b7", "b8"]
                expect(rook_moves.find_moves(player_moves, opp_moves)).to eq(moves)
                rook_moves.find_moves(player_moves, opp_moves)
            end
        end

        context "when white rook is at c4 with no obstructions" do
            subject(:rook_moves_2) { described_class.new("c4", "white") }

            it "returns ['a4', 'b4','d4', 'e4', 'f4', 'g4', 'h4', 'c1', 'c2', 'c3', 'c5', 'c6', 'c7', 'c8']" do
                player_moves = []
                opp_moves = []
                moves = ["a4", "b4","d4", "e4", "f4", "g4", "h4", "c1", "c2", "c3", "c5", "c6", "c7", "c8"]
                expect(rook_moves_2.find_moves(player_moves, opp_moves)).to eq(moves)
                rook_moves_2.find_moves(player_moves, opp_moves)
            end
        end

        context "when white rook is at c4 with player's own peice obstructing at c5" do
            subject(:rook_blocked_once) { described_class.new("c4", "white") }

            it "returns ['a4', 'b4','d4', 'e4', 'f4', 'g4', 'h4', 'c1', 'c2', 'c3']" do
                player_moves = ["c4", "c5"]
           
                opp_moves = []
                moves = ["a4", "b4","d4", "e4", "f4", "g4", "h4", "c1", "c2", "c3"]
                expect(rook_blocked_once.find_moves(player_moves, opp_moves)).to eq(moves)
                rook_blocked_once.find_moves(player_moves, opp_moves)
            end
        end

        context "when white rook is at c4 with player's own peices obstructing at c5 and at f4" do
            subject(:rook_blocked_twice) { described_class.new("c4", "white") }

            it "returns ['a4', 'b4','d4', 'e4', 'c1', 'c2', 'c3']" do
                player_moves = ["f4", "d5", "c5"]
            
                opp_moves = []
                moves = ["a4", "b4","d4", "e4", "c1", "c2", "c3"]
                expect(rook_blocked_twice.find_moves(player_moves, opp_moves)).to eq(moves)
                rook_blocked_twice.find_moves( player_moves, opp_moves)
            end
        end
        

        context "when white rook is at c4 with player's own peices obstructing at c5 and at f4 and opponent at c2" do
            subject(:rook_blocked_opp) { described_class.new("c4", "white") }
            
            it "returns ['a4', 'b4','d4', 'e4', 'c1', 'c2', 'c3']" do
                player_moves = ["f4", "d5", "c5"]
                opp_moves = ["c2"]
                moves = ["a4", "b4","d4", "e4", "c1", "c2"]
                expect(rook_blocked_opp.find_moves(player_moves, opp_moves)).to eq(moves)
                rook_blocked_opp.find_moves(player_moves, opp_moves)
            end
        end

    end

end

describe Knight do
    describe "#find_moves" do
        context "when white knight is at d3 with no obstructions" do
            subject(:knight_moves) { described_class.new("d3", "white") }
        
            it "returns ['b2', 'b4', 'c1', 'c5', 'e1', 'e5', 'f2', 'f4']" do
                moves = ["c1", "b2", "b4", "c5", "e5", "f4", "f2", "e1"].sort
                player_moves = []
                opp_moves = []
                expect(knight_moves.find_moves(player_moves, opp_moves)).to eq(moves)
                knight_moves.find_moves(player_moves, opp_moves)
            end
        end
    end

    context "when white knight  is at b3" do
        subject(:knight_moves_bounds) { described_class.new("b3", "white") }

        it "only returns moves on the board ['a1','a5', 'c1', 'c5', 'd2', 'd4']" do
            moves = ["a1","a5", "c1", "c5", "d2", "d4"].sort
            player_moves = []
            opp_moves = []
            expect(knight_moves_bounds.find_moves(player_moves, opp_moves)).to eq(moves)
            knight_moves_bounds.find_moves(player_moves, opp_moves)
        end
    end
    context "when white knight is at b3 with own pieces at c1 and c5" do
        subject(:knight_moves_block) { described_class.new("b3", "white") }

        it "only returns free moves on the board ['a1','a5', 'd2', 'd4']" do
            player_moves = ["c1" , "c5"]
            opp_moves = []
            moves = ["a1","a5", "d2", "d4"].sort
            expect(knight_moves_block.find_moves(player_moves, opp_moves)).to eq(moves)
            knight_moves_block.find_moves(player_moves, opp_moves)
        end
    end

end

# describe Gameboard do

#     describe "#find_bishop_moves" do
#         context "when white bishop is at e4 with no obstructing pieces" do
#             subject(:bishop_moves) { described_class.new }

#             it "returns available moves [b1, c2, d3, f5, g6, h7, h1, g2, f3, d5, c6, b7, a8]" do
#                 player_moves = {}
#                 opp_moves = {}
#                 moves = ["b1", "c2", "d3", "f5", "g6", "h7", "h1", "g2", "f3", "d5", "c6", "b7", "a8"].sort
#                 expect(bishop_moves.find_bishop_moves("e4", player_moves, opp_moves)).to eq(moves)
#                 bishop_moves.find_bishop_moves("e4", player_moves, opp_moves)
#             end
#         end

#         context "when white bishop is at e4 with player's own obstructing pieces at g6" do
#             subject(:bishop_blocked_once) { described_class.new }

#             it "returns available moves [b1, c2, d3, f5, h1, g2, f3, d5, c6, b7, a8]" do
#                 moves = ["b1", "c2", "d3", "f5", "h1", "g2", "f3", "d5", "c6", "b7", "a8"].sort
#                 opp_moves = {}
#                 player_moves[:pawn3] = "g6"
#                 player_moves[:pawn7] = "g5"
#                 player_moves[:rook2] ="h2"
#                 player_moves[:knght1] = "b5"
#                 expect(bishop_blocked_once.find_bishop_moves("e4", player_moves, opp_moves)).to eq(moves)
#                 bishop_blocked_once.find_bishop_moves("e4", player_moves, opp_moves)
#             end
#         end

#         context "when white bishop is at e4 with player's own obstructing pieces at g6 and g2" do
#             subject(:bishop_blocked_twice) { described_class.new }

#             it "returns available moves [b1, c2, d3, f5, h1, g2, f3, d5, c6, b7, a8]" do
#                 moves = ["b1", "c2", "d3", "f5", "f3", "d5", "c6", "b7", "a8"].sort
#                 opp_moves = {}
#                 player_moves[:pawn3] = "g6"
#                 player_moves[:knght2] = "g2"
#                 player_moves[:knght1] = "b5"
#                 expect(bishop_blocked_twice.find_bishop_moves("e4", player_moves, opp_moves)).to eq(moves)
#                 bishop_blocked_twice.find_bishop_moves("e4", player_moves, opp_moves)
#             end
#         end

#         context "when white bishop is at e4 with player's own obstructing pieces at g6, g2, and b7" do
#             subject(:bishop_blocked_thrice) { described_class.new }

#             it "returns available moves [b1, c2, d3, f5, h1, g2, f3, d5, c6]" do
#                 moves = ["b1", "c2", "d3", "f5", "f3", "d5", "c6"].sort
#                 opp_moves = {}
#                 player_moves[:pawn3] = "g6"
#                 player_moves[:knght2] = "g2"
#                 player_moves[:rook1] = "b7"
#                 player_moves[:knght1] = "b5"
#                 expect(bishop_blocked_thrice.find_bishop_moves("e4", player_moves, opp_moves)).to eq(moves)
#                 bishop_blocked_thrice.find_bishop_moves("e4", player_moves, opp_moves)
#             end
#         end

#         context "when white bishop is at e4 with player's own obstructing pieces at g6, g2, c2, and b7" do
#             subject(:bishop_blocked_4) { described_class.new }

#             it "returns available moves [d3, f5, h1, g2, f3, d5, c6]" do
#                 moves = ["d3", "f5", "f3", "d5", "c6"].sort
#                 opp_moves = {}
#                 player_moves[:pawn4] = "g6"
#                 player_moves[:knght2] = "g2"
#                 player_moves[:rook1] = "b7"
#                 player_moves[:pawn3] = "c2"
#                 expect(bishop_blocked_4.find_bishop_moves("e4", player_moves, opp_moves)).to eq(moves)
#                 bishop_blocked_4.find_bishop_moves("e4", player_moves, opp_moves)
#             end
#         end

#         #blocked by opponent's pieces
#         context "when white bishop is at e4 and has opponent piece in path at g6" do
#             subject(:bishop_block_opp) { described_class.new }

#             it "returns available moves [b1, c2, d3, f5, g6, h1, g2, f3, d5, c6, b7, a8]" do
#                 player_moves = {}
#                 opp_moves = {}
#                 opp_moves[:rook1] = "g6"
#                 moves = ["b1", "c2", "d3", "f5", "g6", "h1", "g2", "f3", "d5", "c6", "b7", "a8"].sort
#                 expect(bishop_block_opp.find_bishop_moves("e4", player_moves, opp_moves)).to eq(moves)
#                 bishop_block_opp.find_bishop_moves("e4", player_moves, opp_moves)
#             end
#         end

#         context "when white bishop is at e4 and has opponent piece in path at g6 and g2" do
#             subject(:bishop_block_opp_twice) { described_class.new }

#             it "returns available moves [b1, c2, d3, f5, g6, h1, g2, f3, d5, c6, b7, a8]" do
#                 player_moves = {}
#                 opp_moves = {}
#                 opp_moves[:rook1] = "g6"
#                 opp_moves[:queen] = "g2"
#                 moves = ["b1", "c2", "d3", "f5", "g6", "g2", "f3", "d5", "c6", "b7", "a8"].sort
#                 expect(bishop_block_opp_twice.find_bishop_moves("e4", player_moves, opp_moves)).to eq(moves)
#                 bishop_block_opp_twice.find_bishop_moves("e4", player_moves, opp_moves)
#             end
#         end


#         context "when white bishop is at e4 with opponent pieces at g6, g2, and b7" do
#             subject(:bishop_block_opp_thrice) { described_class.new }

#             it "returns available moves [b1, c2, d3, f5, b7, g2, f3, d5, c6, g6]" do
#                 player_moves = {}
#                 opp_moves = {}
#                 moves = ["b1", "c2", "d3", "f5", "f3", "d5", "c6", "b7", "g6", "g2"].sort
#                 opp_moves[:pawn3] = "g6"
#                 opp_moves[:knght2] = "g2"
#                 opp_moves[:rook1] = "b7"
#                 expect(bishop_block_opp_thrice.find_bishop_moves("e4", player_moves, opp_moves)).to eq(moves)
#                 bishop_block_opp_thrice.find_bishop_moves("e4", player_moves, opp_moves)
#             end
#         end

#         context "when white bishop is at e4 with opponent pieces at g6, g2, c2, and b7" do
#             subject(:bishop_block_opp_4) { described_class.new }

#             it "returns available moves [c2, d3, f5, b7, g2, f3, d5, c6, g6]" do
#                 player_moves = {}
#                 opp_moves = {}
#                 moves = ["c2", "d3", "f5", "f3", "d5", "c6", "b7", "g6", "g2"].sort
#                 opp_moves[:pawn3] = "g6"
#                 opp_moves[:knght2] = "g2"
#                 opp_moves[:rook1] = "b7"
#                 opp_moves[:pawn1] = "c2"
#                 expect(bishop_block_opp_4.find_bishop_moves("e4", player_moves, opp_moves)).to eq(moves)
#                 bishop_block_opp_4.find_bishop_moves("e4", player_moves, opp_moves)
#             end
#         end
#     end

#     describe "#find_queen_moves" do
#         context "when white queen is at e4 with no obstructing pieces" do
#             subject(:queen_moves) { described_class.new }

#             it "returns available moves at [b1, c2, d3, f5, g6, h7, h1, g2, f3, d5, c6, b7, a8, e1, e2, e3, e5, e6, e7, e8, a4, b4, c4, c5, c6, c7, c8]" do
#                 moves = ["b1", "c2", "d3", "f5", "g6", "h7", "h1", "g2", "f3", "d5", "c6", "b7", "a8", "e1", "e2", "e3", "e5", "e6", "e7", "e8", "a4", "b4", "c4", "d4", "f4", "g4", "h4"].sort
#                 opp_moves = {}
#                 player_moves = {}
#                 expect(queen_moves.find_queen_moves("e4", player_moves, opp_moves)). to eq(moves)
#                 queen_moves.find_queen_moves("e4", player_moves, opp_moves)
#             end
#         end

#     end

#     describe "#find_king_moves" do
#         context "when white king is at e4 with no obstructing pieces or checks" do
#             subject(:king_moves) { described_class.new }

#             it "returns moves [d5, e5, f5, d4, f4, d3, e3, f3]" do
#                 player_moves = {}
#                 opp_moves = {}
#                 moves = ["d5", "e5", "f5", "d4", "f4", "d3", "e3", "f3"].sort
#                 expect(king_moves.find_king_moves("e4", player_moves, opp_moves)).to eq(moves)
#                 king_moves.find_king_moves("e4", player_moves, opp_moves)
#             end
#         end

#         #handle player pieces
#         context  "when white king is at e4 with obstructing piece at e5" do
#             subject(:king_blocked) { described_class.new }

#             it "returns moves [d5, f5, d4, f4, d3, e3, f3]" do
#                 player_moves = {}
#                 player_moves[:pawn1] = "e5"
#                 moves = ["d5", "f5", "d4", "f4", "d3", "e3", "f3"].sort
#                 expect(king_blocked.find_king_moves("e4", player_moves, opp_moves)).to eq(moves)
#                 king_blocked.find_king_moves("e4", player_moves, opp_moves)
#             end
#         end

#         context  "when white king is at e4 with obstructing pieces at e5 and d4" do
#             subject(:king_blocked_twice) { described_class.new }

#             it "returns moves [d5, f5, d4, f4, d3, e3, f3]" do
#                 player_moves = {}
#                 player_moves[:pawn1] = "e5"
#                 player_moves[:knght2] = "d4"
#                 moves = ["d5", "f5", "f4", "d3", "e3", "f3"].sort
#                 expect(king_blocked_twice.find_king_moves("e4", player_moves, opp_moves)).to eq(moves)
#                 king_blocked_twice.find_king_moves("e4", player_moves, opp_moves)
#             end
#         end

#         context  "when white king is at e4 with obstructing pieces at e5, e3 and d4" do
#             subject(:king_blocked_thrice) { described_class.new }

#             it "returns moves [d5, f5, d4, f4, d3, e3, f3]" do
#                 player_moves = {}
#                 player_moves[:pawn1] = "e5"
#                 player_moves[:knght2] = "d4"
#                 player_moves[:bish1] = "e3"
#                 moves = ["d5", "f5", "f4", "d3", "f3"].sort
#                 expect(king_blocked_thrice.find_king_moves("e4", player_moves, opp_moves)).to eq(moves)
#                 king_blocked_thrice.find_king_moves("e4", player_moves, opp_moves)
#             end
#         end
                
#         #handle opponent pieces
#         context "when white king is at e4 with opponent pieces adjacent at e5" do
#             subject(:king_with_opp) { described_class.new }

#             it "returns moves [d5, f5, d4, f4, d3, e3, f3, e5]" do
#                 player_moves = {}
#                 opp_moves[:pawn1] = "e5"
#                 moves = ["d5", "f5", "d4", "f4", "d3", "e3", "f3", "e5"].sort
#                 expect(king_with_opp.find_king_moves("e4", player_moves, opp_moves)).to eq(moves)
#                 king_with_opp.find_king_moves("e4", player_moves, opp_moves)
#             end
#         end

#         # context "when moving to f5 puts king in check" do
#         #     it "f5 is not returned in available moves [d5, d4, f4, d3, e3, f3, e5]" do
#         #         player_moves = {}
#         #         opp_moves[:pawn1] = "e5"
#         #         moves = ["d5", "f5", "d4", "f4", "d3", "e3", "f3", "e5"].sort
#         #         expect(king_with_opp.find_king_moves("e4", player_moves, opp_moves)).to eq(moves)
#         #         king_with_opp.find_king_moves("e4", player_moves, opp_moves)
#         #     end
#         # end

#     end

#     describe "#validate_player_input" do
#         context "when player inputs coordinates b1b2(invalid) at start of game" do
#             subject(:validate_player_input_invalid) { described_class.new }
       
#             it "returns false" do
#                 expect(validate_player_input_invalid.validate_player_input("b1b2", player_moves, opp_moves)).to eq(false)
#                 validate_player_input_invalid.validate_player_input("b1b2", player_moves, opp_moves)
#             end

#         end

#         context "when player inputs coordinates a2a3(valid) at start of game" do
#             subject(:validate_player_input_valid) { described_class.new }
        
#             it "returns true" do
#                 expect(validate_player_input_valid.validate_player_input("a2a3", player_moves, opp_moves)).to eq(true)
#                 validate_player_input_valid.validate_player_input("a2a3", player_moves, opp_moves)
#             end
#         end

#         describe "#has_opp_piece?" do
#             context "when space on board(c5) is occupied by an opponnents piece" do
#                 subject(:opp_piece_true) { described_class.new }

#                 it "returns true" do
#                     opp_moves[:queen] = "c5"
#                     expect(opp_piece_true.has_opp_piece?("c5", opp_moves)).to eq(true)
#                     opp_piece_true.has_opp_piece?("c5", opp_moves)
#                 end
#             end
#             context "when space on board(c5) is not occupied by an opponnents piece" do
#                 subject(:opp_piece_false) { described_class.new }

#                 it "returns false" do
#                     expect(opp_piece_false.has_opp_piece?("c5", opp_moves)).to eq(false)
#                     opp_piece_false.has_opp_piece?("c5", opp_moves)
#                 end
#             end
#         end

#         describe "#has_player_piece?" do
#             context "when space on board(c6) is occupied by player's own piece" do
#                 subject(:player_piece_true) { described_class.new }

#                 it "returns true" do
#                     player_moves[:queen] = "c6"
#                     expect(player_piece_true.has_player_piece?("c6", player_moves)).to eq(true)
#                     player_piece_true.has_player_piece?("c6", player_moves)
#                 end
#             end

#             context "when space on board(c6) is not occupied by player's own piece" do
#                 subject(:player_piece_false) { described_class.new }
    
#                 it "returns true" do
#                     expect(player_piece_false.has_player_piece?("c6", player_moves)).to eq(false)
#                     player_piece_false.has_player_piece?("c6", player_moves)
#                 end
#             end
#         end
 
#     end

#     describe "#return_piece_type" do
#         context "when starting input coordinate is b1" do
#             subject(:return_piece_type) { described_class.new }
#             it "returns pawn" do
#                 moves = {
#                     pawn1: "a2",
#                     pawn2: "b2",
#                     pawn3: "c2",
#                     pawn4: "d2",
#                     pawn5: "e2",
#                     pawn6: "f2",
#                     pawn7: "g2",
#                     pawn8: "h2",
#                     rook1: "a1",
#                     knght1: "b1",
#                     bish1: "c1",
#                     queen: "d1",
#                     King: "e1",
#                     bish2: "f1",
#                     knght2: "g1",
#                     rook2: "h1"
#                 }
#                 expect(return_piece_type.return_piece_type("b2", moves)).to eq("pawn")
#                 return_piece_type.return_piece_type("b2", moves)
#             end
#         end
#     end

#     describe "#return_available_moves" do
#         context "when piece/arg is a pawn at b2" do
#             subject(:find_moves_pawn) { described_class.new }
#             before do
#                 allow(find_moves_pawn).to receive(:find_p1_pawn_moves).with("b2", player_moves, opp_moves)
#             end
#             it "receives #find_p1_pawn_moves" do
#                 piece = "pawn"
#                 expect(find_moves_pawn).to receive(:find_p1_pawn_moves).with("b2", player_moves, opp_moves)
#                 find_moves_pawn.return_available_moves(piece, "b2", player_moves, opp_moves)
#             end
#         end

#         context "when piece/arg is a knight at b4" do
#             subject(:find_moves_knight) { described_class.new }
#             before do
#                 allow(find_moves_knight).to receive(:find_knight_moves).with("b4", player_moves, opp_moves)
#             end
#             it "receives #find_knight_moves" do
#                 piece = "knight"
#                 expect(find_moves_knight).to receive(:find_knight_moves).with("b4", player_moves, opp_moves)
#                 find_moves_knight.return_available_moves(piece, "b4", player_moves, opp_moves)
#             end
#         end
#     end

#     # describe "#capture_piece" do
#     #     context "when p1's pawn3 at c4 is captured" do
#     #         subject(:piece_capture) { described_class.new }
#     #         it "changes p1's :pawn3 to 'captured" do
#     #             expect(piece_capture.capture_piece())
#     #         end
#     #     end
#     # end

#     describe "#update_p_moves" do
#     end
# end

describe Player do
    describe "#capture_check" do
        context "when player moves to space occupied by opponent" do
            subject(:captured) { described_class.new("white") }

            it "changes end point a2 to 'captured'" do
                move = "a3a2"
                expect{ captured.capture?(move) }.to change { captured.pieces[0].type.position }.from("a2").to("captured")
                captured.capture?(move)
            end
        end

        context "when player moves to unoccupied space" do
            subject(:no_capture) { described_class.new("white") }

            it "returns false" do
                move = "a4a3"
                expect(no_capture.capture?(move)).to eq(false)
                no_capture.capture?(move)
            end
        end
    end

    describe "#return_king_moves_checks_array" do
    end
    describe "#checks_array_after_move" do
    end




    # describe "#update_player_moves" do
    #     context "when player moves knight1 from b1 to c3" do
    #         subject(:update_player_moves) { described_class.new("white") }

    #         it "updates Player instance of knight1 from b1 to c3" do
    #             moves = update_player_moves.moves
    #             start_pt = "b1"
    #             end_pt = "c3"
    #             expect{ update_player_moves.update_player_moves(start_pt, end_pt) }.to change{ moves[:knght1] }.from("b1").to("c3")
    #         end
    #     end
    # end

#     context "when player moves knight1 from f1 to d3" do
#         subject(:update_player_moves_bishop) { described_class.new("white") }

#         it "updates Player instance of bish2 from f1 to d3" do
#             moves = update_player_moves_bishop.moves
#             start_pt = "f1"
#             end_pt = "d3"
#             expect{ update_player_moves_bishop.update_player_moves(start_pt, end_pt) }.to change{ moves[:bish2] }.from("f1").to("d3")
#         end
#     end
end





# # a8  b8  c8  d8  e8  f8  g8  h8 
# # --------------------------------
# #  a7  b7  c7  d7  e7  f7  g7  h7 
# # --------------------------------
# #  a6  b6  c6  d6  e6  f6  g6  h6 
# # --------------------------------
# #  a5  b5  c5  d5  e5  f5  g5  h5 
# # --------------------------------
# #  a4  b4  c4  d4  e4  f4  g4  h4 
# # --------------------------------
# #  a3  b3  c3  d3  e3  f3  g3  h3 
# # --------------------------------
# #  a2  b2  c2  d2  e2  f2  g2  h2 
# # --------------------------------
# #  a1  b1  c1  d1  e1  f1  g1  h1 
