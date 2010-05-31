class BaseState
	attr_accessor :icon, :color

	def initialize(x = -1, y = -1, color = WHITE)
		@color = color
		@icon = Qt::Icon.new
		@hasPiece = false
		@moveCount = 0
		@x = x
		@y = y
	end

	def hasPiece?
		@hasPiece
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

	def can_move_to?(chessBoard, x, y)
		return false if x < 0 or y < 0 or x >= BOARD_WIDTH or y >= BOARD_HEIGHT
		destination = chessBoard[x][y].state

		return false if y < @y and @color == WHITE							# White cannot move backward (-y)
		return false if y > @y and @color == BLACK							# Black cannot move backward (+y)

		if x == @x # same column
			return false if destination.hasPiece?								# Cannot attack forward
			return false if (y - @y).abs > 2
			return false if (y - @y).abs == 2 unless @moveCount == 0
		else
			return false unless destination.hasPiece?							# Must move to attack if going diagonal
			return false unless (y - @y).abs == 1								# Must move forward exactly one row
			return false unless (x - @x).abs == 1								# Must move exactly one column over
			return false if destination.color == @color
		end

		return true
	end
end

class RookState < BaseState

	def initialize(x, y, color = WHITE)
		super(x, y, color)
		@hasPiece = true
		if(@color == WHITE) then
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_wr.svg")
		else
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_br.svg")
		end
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

end

class KnightState < BaseState

	def initialize(x, y, color = WHITE)
		super(x, y, color)
		@hasPiece = true
		if(@color == WHITE) then
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_bn.svg")
		else
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_wn.svg")
		end
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
end
