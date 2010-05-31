class BaseState
	attr_accessor :icon, :isPiece

	def initialize(x, y, color=WHITE)
		@color = color
		@icon = Qt::Icon.new
		@isPiece = false
		@moveCount = 0
		@x = -1
		@y = -1
	end
end

class PawnState < BaseState

	def initialize(x, y, color = WHITE)
		super
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

class RookState < BaseState

	def initialize(color = WHITE)
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
	@isPiece = true
	def initialize(color = WHITE)
		@color = color
		if(@color == WHITE) then
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_wk.svg")
		else
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_bk.svg")
		end
	end


end

class QueenState < BaseState

	def initialize(color = WHITE)
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

	def initialize(color = WHITE)
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

	def initialize(color = WHITE)
		@isPiece = true
		@color = color
		if(@color == WHITE) then
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_wb.svg")
		else
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_bb.svg")
		end
	end
end
