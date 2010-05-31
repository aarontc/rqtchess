
require 'Qt4'

=begin
# Chess rules
http://www.conservativebookstore.com/chess/

Initial board layout:
WBWBWBWB
BWBWBWBW
WBWBWBWB
BWBWBWBW
WBWBWBWB
BWBWBWBW
WBWBWBWB
BWBWBWBW

squares (B=black, W=white)

Pieces:
Ro Kn Bi Qu Ki Bi Kn Ro
Pa Pa Pa Pa Pa Pa Pa Pa
-  -  -  -  -  -  -  -
-  -  -  -  -  -  -  -
-  -  -  -  -  -  -  -
-  -  -  -  -  -  -  -
Pa Pa Pa Pa Pa Pa Pa Pa
Ro Kn Bi Qu Ki Bi Kn Ro

1. White moves first
2. Pieces may not move through or over other pieces except for the knight
3.
=end


class Chess

	# returns an array of valid moves from the row, col coordinates passed
	def enumerate_move_destinations(chessBoard, row_in, col_in)
		destinations = Array.new
		curstate = chessBoard[row_in][col_in].state
		return nil unless curstate.hasPiece?
		for row in 0.upto(BOARD_HEIGHT-1)
			for col in 0.upto(BOARD_WIDTH-1)
				destinations.push([row, col]) if curstate.can_move_to?(chessBoard, row, col)
			end
		end
		destinations
	end


	def enumerate_all_moves(chessBoard)
		moves = Hash.new
		for row in 0.upto(BOARD_HEIGHT-1)
			for col in 0.upto(BOARD_WIDTH-1)
				puts "Chess::enumerate_all_moves: checking [#{row}, #{col}]..." if DEBUG
				m = enumerate_move_destinations(chessBoard, row, col)
				moves[[row, col]] = m unless m.nil?
			end
		end
		moves
	end
end

