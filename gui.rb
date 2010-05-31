#!/usr/bin/ruby

BOARD_WIDTH = 8
BOARD_HEIGHT = 8


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
		setLayout(@chessLayout)

		@buttonArray = Array.new
		for row in 0.upto(BOARD_HEIGHT-1)
			@buttonArray[row] = Array.new
			for col in 0.upto(BOARD_WIDTH-1)
				if (row + col) % 2 == 0
					color = WHITE
				else
					color = BLACK
				end
				@buttonArray[row][col] = Square.new(color, row, col, self)
				@chessLayout.addWidget(@buttonArray[row][col], row, col)
			end
		end


		setBoard()

		c = Chess.new
		p c.enumerate_all_moves(@buttonArray)
		p @buttonArray

	end

	def setBoard()
		for i in 0..7
			@buttonArray[i][1].state = PawnState.new(i, 1, WHITE)
			p @buttonArray[i][1].state
		end
	end
end

class Square < Qt::PushButton
	attr_accessor :state

	slots 'pressed()'
	def initialize(color, row, col, parent = nil)
		super(parent)
		@row = row
		@col = col
		@color = color
		@state= BaseState.new(row, col, WHITE)
		setStyleSheet("QPushButton { background-color: #{color}; padding:none; border:none;}");
		setMinimumSize(Qt::Size.new(60, 60))
		setMaximumHeight(16777215)
		connect(self, SIGNAL('clicked()'), self, SLOT('pressed()'))
	end

	def pressed()
		setStyleSheet("QPushButton { background-color: hotpink; }")
	end

	def state=(val)
		@state = val
		setIcon(@state.icon)
	end

	def inspect
		"<Square [#{@row}, #{@col}]: (#{@color}) #{@state.class}: #{@state.inspect}>"
	end
end

app = Qt::Application.new(ARGV)
chess = ChessBoard.new
chess.show

app.exec
