#!/usr/bin/ruby

require 'Qt4'
require 'state.rb'
require 'chess.rb'
BLACK = "black"
WHITE = "white"
class ChessBoard < Qt::Widget
	def initialize(parent = nil)
		super(parent)
		resize(400, 400)
		@chessLayout = Qt::GridLayout.new(self)
		@chessLayout.setSpacing(0)
		@chessLayout.setContentsMargins(0, 0, 0, 0)
		#@chessLayout.setSizeConstraint()
		setLayout(@chessLayout)
		@buttonArray = Array.new
		for i in 0..7
			@buttonArray[i] = Array.new
			for j in 0..7
				if (i + j) % 2 == 0 then
					blah= Square.new(WHITE, i, j, self)
				else
					blah= Square.new(BLACK, i, j, self)
				end
				@buttonArray[i].push blah
				@chessLayout.addWidget(@buttonArray[i][j], j, i)
			end
		end

		setBoard()

		c = Chess.new
		p c.enumerate_move_destinations(@buttonArray, 1, 1)

	end

	def setBoard()
		for i in 0..7
			@buttonArray[i][1].state = PawnState.new(1, i, WHITE)
			p @buttonArray[i][1]
		end
	end
end

class Square < Qt::PushButton
	slots 'pressed()'
	def initialize(color, x, y, parent = nil)
		super(parent)
		@x = x
		@y = y
		@state= BaseState.new(x, y, WHITE)
		setStyleSheet("QPushButton { background-color: #{color}; padding:none; border:none;}");
		setMinimumSize(Qt::Size.new(30, 30))
		connect(self, SIGNAL('clicked()'), self, SLOT('pressed()'))
	end

	def pressed()
		setStyleSheet("QPushButton { background-color: hotpink; }")
	end

	def state=(val)
		@state = val
		setIcon(@state.icon)
	end
end

app = Qt::Application.new(ARGV)
chess = ChessBoard.new
chess.show

app.exec
