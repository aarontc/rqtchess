
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


	def enumerate_all_moves(chessBoard, color)
		moves = Hash.new
		for row in 0.upto(BOARD_HEIGHT-1)
			for col in 0.upto(BOARD_WIDTH-1)
				#puts "Chess::enumerate_all_moves: checking [#{row}, #{col}]..." if DEBUG
				next unless chessBoard[row][col].state.color == color
				m = enumerate_move_destinations(chessBoard, row, col)
				moves[[row, col]] = m unless m.nil?
			end
		end
		moves
	end

	def get_king_state(chessBoard, color)
		for row in 0.upto(BOARD_HEIGHT-1)
			for col in 0.upto(BOARD_WIDTH-1)
				state = chessBoard[row][col].state
				return state if state.hasPiece? and state.color == color and state.class == KingState
			end
		end
	end

	def in_check?(chessBoard, color)
		puts "Checking if #{color} is in check..."
		if color == WHITE
			enemy_moves = enumerate_all_moves(chessBoard, BLACK)
		else
			enemy_moves = enumerate_all_moves(chessBoard, WHITE)
		end
		puts "enemy moves: #{enemy_moves.inspect}"
		king = get_king_state(chessBoard, color)
		puts "king: #{king.inspect}"
		enemy_moves.each_value do |x|
			return true if x.include?([king.row, king.col])
		end
		return false
	end

	def ai_generate_move(chessBoard, color)

	end

end

