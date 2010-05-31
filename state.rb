class BaseState
	attr_accessor :icon, :isPiece

	def initialize(x=-1, y=-1, color=WHITE)
		@color = color
		@icon = Qt::Icon.new
		@isPiece = false
		@moveCount = 0
		@x = x
		@y = y
	end
end

class PawnState < BaseState

	def initialize(x, y, color = WHITE)
		super(x, y, color)
		@isPiece = true
		@color = color
		if(@color == WHITE) then
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_wp.svg")
		else
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_bp.svg")
		end
	end

	def can_move_to?(chessBoard, x, y)
	end
end

class RookState < BaseState

	def initialize(x, y, color = WHITE)
		super(x, y, color)
		@isPiece = true
		@color = color
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
		@isPiece = true
		@color = color
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
		@isPiece = true
		@color = color
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
		@isPiece = true
		@color = color
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
		@isPiece = true
		@color = color
		if(@color == WHITE) then
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_wb.svg")
		else
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_bb.svg")
		end
	end
end
