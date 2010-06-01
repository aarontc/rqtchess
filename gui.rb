#!/usr/bin/ruby

BOARD_WIDTH = 8
BOARD_HEIGHT = 8
DEBUG = false

require 'Qt4'
require 'state.rb'
require 'chess.rb'
BLACK = "black"
WHITE = "white"

class ChessBoard < Qt::Widget
	slots 'piecePressed()'
	attr :pressedRow, true
	attr :pressedCol, true

	def initialize(parent = nil)
		@mod = ARGV[0]
		@whoseMove = WHITE
		@chess = Chess.new

		super(parent)
		resize(400, 400)
		@clickedPiece = nil
		@pressedRow = 0
		@pressedCol = 0
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
				connect(@buttonArray[row][col], SIGNAL('selected()'), self, SLOT('piecePressed()'))
			end
		end


		setBoard()

		if @mod == "cvc"
			while true do
				move = @chess.ai_generate_move(@buttonArray, WHITE)
				domove
				doevents
				move = @chess.ai_generate_moev(@buttonArray, BLACK)
				domove
				doevents
			end
		end

	end

	def setBoard()
		for i in 0.upto(BOARD_WIDTH-1)
			@buttonArray[1][i].state = PawnState.new(1, i, WHITE)
			@buttonArray[6][i].state = PawnState.new(6, i, BLACK)
		end

		#place rooks
		@buttonArray[0][0].state = RookState.new(0, 0, WHITE)
		@buttonArray[0][7].state = RookState.new(0, 7, WHITE)
		@buttonArray[7][0].state = RookState.new(7, 0, BLACK)
		@buttonArray[7][7].state = RookState.new(7, 7, BLACK)

		#place knights
		@buttonArray[0][1].state = KnightState.new(0, 1, WHITE)
		@buttonArray[0][6].state = KnightState.new(0, 6, WHITE)
		@buttonArray[7][1].state = KnightState.new(7, 1, BLACK)
		@buttonArray[7][6].state = KnightState.new(7, 6, BLACK)

		#place bishops
		@buttonArray[0][2].state = BishopState.new(0, 2, WHITE)
		@buttonArray[0][5].state = BishopState.new(0, 5, WHITE)
		@buttonArray[7][2].state = BishopState.new(7, 2, BLACK)
		@buttonArray[7][5].state = BishopState.new(7, 5, BLACK)

		#place Kings
		@buttonArray[0][3].state = KingState.new(0, 3, WHITE)
		@buttonArray[7][3].state = KingState.new(7, 3, BLACK)

		#place Queens
		@buttonArray[0][4].state = QueenState.new(0, 4, WHITE)
		@buttonArray[7][4].state = QueenState.new(7, 4, BLACK)
	end

	def piecePressed
		if @clickedPiece.nil? then
			return unless (@buttonArray[@pressedRow][@pressedCol].state.color == @whoseMove)
			c = Chess.new
			@array_moves = c.enumerate_move_destinations(@buttonArray, @pressedRow, @pressedCol)
			unless @array_moves.nil? or @array_moves.empty?
				for moves in @array_moves
					tmp = @buttonArray[moves[0]][moves[1]]
					tmp.setStyleSheet("QPushButton { background-color: #{tmp.color}; border: 5px solid green; padding:none;}")
				end

				@clickedPiece = @buttonArray[@pressedRow][@pressedCol]
				@whoseMove = (@whoseMove == WHITE ? BLACK: WHITE)

			end
		else
			if @array_moves.include?([@pressedRow, @pressedCol])
				tmp = @buttonArray[@pressedRow][@pressedCol]
				tmp.move_state(@clickedPiece)


				puts @chess.in_check?(@buttonArray, WHITE)
				puts @chess.in_check?(@buttonArray, BLACK)
				p @chess.ai_generate_move(@buttonArray, WHITE)

				for moves in @array_moves
					tmp = @buttonArray[moves[0]][moves[1]]
					tmp.setStyleSheet("QPushButton { background-color: #{tmp.color}; padding:none; border:none;}")
				end

				@clickedPiece =  nil

				if @mod == "pvc" and @whoseMove == BLACK then
					move = @chess.ai_generate_move(@buttonArray, BLACK)
					p move
					@pressedRow = move[0][0]
					@pressedCol = move[0][1]
					piecePressed
					@pressedRow = move[1][0]
					@pressedCol = move[1][1]
					piecePressed
				end
			end
		end


	end
end

class Square < Qt::PushButton
	attr_accessor :color, :state, :row, :col

	slots 'pressed()'
	signals 'selected()'

	def initialize(color, row, col, parent = nil)
		@chess = Chess.new

		super(parent)
		@row = row
		@col = col
		@color = color
		@state= BaseState.new(row, col, WHITE)
		setUpSizePolicy
		setStyleSheet("QPushButton { background-color: #{color}; padding:none; border:none;}");
		setMinimumSize(Qt::Size.new(60, 60))
		setMaximumHeight(16777215)
		connect(self, SIGNAL('clicked()'), self, SLOT('pressed()'))
	end

	def setUpSizePolicy
		policy = sizePolicy
		policy.setControlType(0x4000)
		policy.setHorizontalStretch(0)
		policy.setVerticalStretch(0)
		setSizePolicy(sizePolicy)
	end

	def resizeEvent(event)
		setIconSize(size())
	end

	def sizeHint
		height = parent.size().height() / 8
		size = Qt::Size.new(height, height)
		return size
	end

	def pressed()
		parent.pressedRow = @row
		parent.pressedCol = @col
		emit selected()
	end

	def state=(val)
		@state = val
		setIcon(@state.icon)
	end

	def move_state(from)
		from.state.move_to(@state)

		if(@state.class == BaseState) then
			tmp = @state
			self.state = from.state
			from.state = tmp
		else
			self.state = from.state
			from.state = BaseState.new(from.row, from.col)
		end

		if (@state.needPromotion?) then
			self.state = QueenState.new(@row, @col, self.state.color)
		end

	end

	def inspect
		"<Square [#{@row}, #{@col}]: (#{@color}) #{@state.class}: #{@state.inspect}>"
	end
end

if ARGV.count != 1
	puts "Use argument: pvp, pvc, cvc"
	exit(1)
else
	unless ["pvp", "pvc", "cvc"].include?(ARGV[0])
		puts "Use argument: pvp, pvc, cvc"
		exit(2)
	end
end

app = Qt::Application.new(ARGV)
chess = ChessBoard.new
chess.show
app.exec
