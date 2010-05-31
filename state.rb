class BaseState
	attr_accessor :icon, :color
	attr :row, true
	attr :col, true

	def initialize(row = -1, col = -1, color = WHITE)
		@color = color
		@icon = Qt::Icon.new
		@hasPiece = false
		@moveCount = 0
		@row = row
		@col = col
	end

	def hasPiece?
		@hasPiece
	end

	def move_to(to)
		if(to.class == BaseState) then
			@moveCount = @moveCount + 1

			tmpRow = @row
			tmpCol = @col
			@row = to.row
			@col = to.col
			to.row = tmpRow
			to.col = tmpCol
		end
	end
end


# board layout:
# 0,0		white
#
#
#
#
#
#
#
#			black	7,7

class PawnState < BaseState

	def initialize(x, y, color = WHITE)
		super(x, y, color)
		@hasPiece = true

		if(@color == WHITE) then
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_wp.svg")
		else
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_bp.svg")
		end
	end

	def can_move_to?(chessBoard, row, col)
		# Can't leave the board
		return false if row < 0 or col < 0 or row >= BOARD_HEIGHT or col >= BOARD_WIDTH

		# Grab destination state for ease of rules
		destination = chessBoard[row][col].state
		return false if destination.hasPiece? and destination.color == @color

		# move forward one space
		return true if @color == WHITE and row == @row + 1 and col == @col and not destination.hasPiece?
		return true if @color == BLACK and row == @row - 1 and col == @col and not destination.hasPiece?

		# move forward two spaces, can't jump a piece, only available at first move of the game
		return true if @color == WHITE and row == @row + 2 and col == @col and not destination.hasPiece? and @moveCount == 0 and not chessBoard[row - 1][col].state.hasPiece?
		return true if @color == BLACK and row == @row - 2 and col == @col and not destination.hasPiece? and @moveCount == 0 and not chessBoard[row + 1][col].state.hasPiece?

		# move diagonally forward one row and one col
		return true if @color == WHITE and row == @row + 1 and (col == @col + 1 or col == @col - 1) and destination.hasPiece? and destination.color == BLACK
		return true if @color == BLACK and row == @row - 1 and (col == @col + 1 or col == @col - 1) and destination.hasPiece? and destination.color == WHITE

		return false
	end
end

class RookState < BaseState

	def initialize(row, col, color = WHITE)
		super(row, col, color)
		@hasPiece = true

		if(@color == WHITE) then
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_wr.svg")
		else
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_br.svg")
		end
	end

	def can_move_to?(chessBoard, row, col)
		puts "RookState: can_move_to?(#{row}, #{col}) From [#{@row}, #{@col}]" if DEBUG

		# Can't leave the board
		return false if row < 0 or col < 0 or row >= BOARD_HEIGHT or col >= BOARD_WIDTH

		# Can't move to same space
		return false if row == @row and col == @col

		# Grab destination state for ease of rules
		destination = chessBoard[row][col].state
		return false if destination.hasPiece? and destination.color == @color

		# move horizontal n spaces
		if row == @row
			direction = 1 if col > @col
			direction = -1 if col < @col
			# make sure there are no pieces in between
			(col - @col).abs.times do |x|
				return false if chessBoard[row][@col + ((x + 1) * direction)].state.hasPiece?
			end
			return true
		end

		# move vertical n spaces
		if col == @col
			puts "RookState: moving vertically" if DEBUG
			direction = 1 if row > @row
			direction = -1 if row < @row
			(row - @row).abs.times do |x|
				puts "RookState: vertically checking [#{@row + ((x + 1) * direction)}, #{col}]..." if DEBUG
				return false if chessBoard[@row + ((x + 1) * direction)][col].state.hasPiece?
				puts "RookState: ...nothing found" if DEBUG
			end
			return true
		end

		return false
	end
end

class KingState < BaseState
	def initialize(x, y, color = WHITE)
		super(x, y, color)
		@hasPiece = true

		if(@color == WHITE) then
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_wk.svg")
		else
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_bk.svg")
		end
	end

	def can_move_to?(chessBoard, row, col)
		puts "KingState: can_move_to?(#{row}, #{col}) From [#{@row}, #{@col}]" if DEBUG

		# Can't leave the board
		return false if row < 0 or col < 0 or row >= BOARD_HEIGHT or col >= BOARD_WIDTH

		# Can't move to same space
		return false if row == @row and col == @col

		# Grab destination state for ease of rules
		destination = chessBoard[row][col].state

		return false if destination.hasPiece? and destination.color == @color
		return false if (col - @col).abs > 1
		return false if (row - @row).abs > 1

		return true
	end
end

class QueenState < BaseState

	def initialize(x, y, color = WHITE)
		super(x, y, color)
		@hasPiece = true

		if(@color == WHITE) then
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_wq.svg")
		else
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_bq.svg")
		end
	end

	def can_move_to?(chessBoard, row, col)
		puts "QueenState: can_move_to?(#{row}, #{col}) From [#{@row}, #{@col}]" if DEBUG

		# Can't leave the board
		return false if row < 0 or col < 0 or row >= BOARD_HEIGHT or col >= BOARD_WIDTH

		# Can't move to same space
		return false if row == @row and col == @col

		# Grab destination state for ease of rules
		destination = chessBoard[row][col].state
		return false if destination.hasPiece? and destination.color == @color

		# move horizontal n spaces
		if row == @row
			direction = 1 if col > @col
			direction = -1 if col < @col
			# make sure there are no pieces in between
			(col - @col).abs.times do |x|
				return false if chessBoard[row][@col + ((x + 1) * direction)].state.hasPiece?
			end
			return true
		end

		# move vertical n spaces
		if col == @col
			direction = 1 if row > @row
			direction = -1 if row < @row
			(row - @row).abs.times do |x|
				return false if chessBoard[@row + ((x + 1) * direction)][col].state.hasPiece?
			end
			return true
		end

		# diagonal
		coldiff = (@col - col).abs
		rowdiff = (@row - row).abs
		return false unless coldiff == rowdiff
		# iterate through each intermediate space and look for a piece
		colslope = 1 if col > @col
		colslope = -1 if col < @col
		rowslope = 1 if row > @row
		rowslope = -1 if row < @row

		coldiff.times do |x|
			return false if chessBoard[@row + ((x + 1) * rowslope)][@col + ((x + 1) * colslope)].state.hasPiece?
		end

		return true
	end
end

class KnightState < BaseState

	def initialize(x, y, color = WHITE)
		super(x, y, color)
		@hasPiece = true

		if(@color == WHITE) then
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_wn.svg")
		else
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_bn.svg")
		end
	end

	def can_move_to?(chessBoard, row, col)
		puts "KnightState: can_move_to?(#{row}, #{col}) From [#{@row}, #{@col}]" if DEBUG

		# Can't leave the board
		return false if row < 0 or col < 0 or row >= BOARD_HEIGHT or col >= BOARD_WIDTH

		# Can't move to same space
		return false if row == @row and col == @col

		# Grab destination state for ease of rules
		destination = chessBoard[row][col].state
		return false if destination.hasPiece? and destination.color == @color

		# diagonal
		coldiff = (@col - col).abs
		rowdiff = (@row - row).abs
		return false unless coldiff + rowdiff == 3
		return true if coldiff < 3 and rowdiff < 3

		return false
	end
end

class BishopState < BaseState

	def initialize(x, y, color = WHITE)
		super(x, y, color)
		@hasPiece = true

		if(@color == WHITE) then
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_wb.svg")
		else
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_bb.svg")
		end
	end

	def can_move_to?(chessBoard, row, col)
		puts "BishopState: can_move_to?(#{row}, #{col}) From [#{@row}, #{@col}]" if DEBUG

		# Can't leave the board
		return false if row < 0 or col < 0 or row >= BOARD_HEIGHT or col >= BOARD_WIDTH

		# Can't move to same space
		return false if row == @row and col == @col

		# Grab destination state for ease of rules
		destination = chessBoard[row][col].state
		return false if destination.hasPiece? and destination.color == @color

		# diagonal
		coldiff = (@col - col).abs
		rowdiff = (@row - row).abs
		return false unless coldiff == rowdiff
		# iterate through each intermediate space and look for a piece
		colslope = 1 if col > @col
		colslope = -1 if col < @col
		rowslope = 1 if row > @row
		rowslope = -1 if row < @row

		coldiff.times do |x|
			return false if chessBoard[@row + ((x + 1) * rowslope)][@col + ((x + 1) * colslope)].state.hasPiece?
		end
	end
end
