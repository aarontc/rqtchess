class BaseState
	attr_accessor :icon

	def initialize
		@icon = Qt::Icon.new
	end

	def isPiece
		return false
	end
end

class PawnState < BaseState

	def inialize(color = WHITE)
		@color = color
		if(@color == WHITE) then
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_wp.svg")
		else
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_bp.svg")
		end
	end

	def isPiece
		return true
	end
end

class RookState < BaseState

	def inialize(color = WHITE)
		@color = color
		if(@color == WHITE) then
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_wr.svg")
		else
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_br.svg")
		end
	end

	def isPiece
		return true
	end
end

class KingState < BaseState

	def inialize(color = WHITE)
		@color = color
		if(@color == WHITE) then
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_wk.svg")
		else
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_bk.svg")
		end
	end
end

class QueenState < BaseState

	def inialize(color = WHITE)
		@color = color
		if(@color == WHITE) then
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_wq.svg")
		else
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_bq.svg")
		end
	end

	def isPiece
		return true
	end
end

class KnightState < BaseState

	def inialize(color = WHITE)
		@color = color
		if(@color == WHITE) then
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_bn.svg")
		else
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_wn.svg")
		end
	end

	def isPiece
		return true
	end
end

class BishopState < BaseState

	def inialize(color = WHITE)
		@color = color
		if(@color == WHITE) then
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_wb.svg")
		else
			@icon = Qt::Icon.new("./images/Chess_Maurizio_Monge_Fantasy_bb.svg")
		end
	end

	def isPiece
		return true
	end
end