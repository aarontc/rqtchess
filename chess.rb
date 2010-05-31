
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

	# returns an array of valid moves from the x, y coordinates passed
	def enumerate_move_destinations(chessBoard, x, y)
		destinations = Array.new
		curstate = chessBoard[x][y].state
		return nil unless curstate.hasPiece?
		for x in 0.upto(BOARD_HEIGHT-1)
			for y in 0.upto(BOARD_WIDTH-1)
				destinations.push([x, y]) if curstate.can_move_to?(chessBoard, x, y)
			end
		end
		destinations
	end


	def enumerate_all_moves(chessBoard)
		moves = Hash.new
		for x in 0.upto(BOARD_HEIGHT-1)
			for y in 0.upto(BOARD_WIDTH-1)
				m = enumerate_move_destinations(chessBoard, x, y)
				moves[[x, y]] = m unless m.nil?
			end
		end
		moves
	end
end

