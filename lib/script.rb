class Connect4
    attr_accessor :board, :play_count, :player1, :player2, :current_player, :res
    BLACK = "\u25C6".encode('utf-8')
    WHITE = "\u25C7".encode('utf-8')
    def initialize()
        @play_count = 0
        @board = Board.new
        @player1 = nil
        @player2 = nil
        @current_player = nil
        @res = res
    end

    def start
        puts  "Have fun playing connect four!"
        set_up
        board.display
        take_turns
        game_over?
    end

    def get_player_name(arg)
        "Enter #{arg}'s name"
    end

    def creat(arg, player_disc)
        puts get_player_name(arg)
        name = gets.chomp
        disc = player_disc
        Play.new(name, disc)
    end

    def set_up
        @player1 = creat("player1", BLACK)
        @player2 = creat("player2", WHITE)
        @current_player = @player1
    end

    def play(name, disc)
        puts ''
        "#{name} play with numbers [1-7] to drop #{disc} on the board"
    end

    def take_turns
        loop do
            puts play(@current_player.name, @current_player.disc)
            col = turn
            @board.drop_disc(@current_player.disc, col)
            break if @board.won? || @board.full?
            game_over?
            switch_player
        end
    end

    
    def turn
        choice = gets.chomp.to_i
        if  !@board.not_filled?(choice)
            turn
        elsif !@board.valid_entry?(choice)
            puts "Invalid entry"
            turn
        end
        choice
    end

    def switch_player
        if @current_player == @player1
            @current_player = @player2
        else
            @current_player = @player1
        end
    end


        #binding.pry
    def validate_input(input)
        return input if %w[Y y].include?(input) || %w[N n].include?(input)
    end

    def player_decision
        loop do
            @res = validate_input(replay?)
            break if @res
            puts 'Invalid input'
        end
    end

    def replay?
        puts "Enter [y] to play again or [n] to end game."
        loop do
            @res = gets.chomp
            if %w[Y y].include?(@res)
                game_logic = Connect4.new
                game_logic.start
            elsif %w[N n].include?(@res)
               exit
            end
            
        end
    end

    def game_over?
        if board.won?
            puts ''
            puts "Congrats #{current_player.name}! You won."
            puts ''
            player_decision
        elsif board.full?
            puts ''
            puts 'That\'s a tie!'
            puts ''
            player_decision
        end
    end
end


class Board
    attr_accessor :board, :play_count, :name

    BLACK = "\u25C6".encode('utf-8')
    WHITE = "\u25C7".encode('utf-8')


    def initialize()
       @board = Array.new(7) {Array.new(6,' ')}
       @play_count = 0
       @name = name
      
    end

  

    def display
        puts ' |1|2|3|4|5|6|7|'

        0.upto(5) do |row|
            print row

            0.upto(6) do |col|
                if @board[col][row].nil?
                    print '| '
                else
                    print '|' + @board[col][row]
                end
            end
            puts '|'
        end
    
    end



    def col_wins?
        7.times do |col|
            if @board[col].join('').include?(BLACK * 4) || board[col].join('').include?(WHITE * 4)
                return true
            end
        end
        false
    end

    def row_wins?
        t_board = @board.transpose
        6.times do |row|
            if t_board[row].join('').include?(BLACK * 4) || t_board[row].join('').include?(WHITE * 4)
                return true
            end
		end
        return false
    end

    def diagonal_wins?
        win = right_diag? || left_diag?
        return win
    end

    def right_diag?
        0.upto(3) do |c|
            0.upto(2) do |r|
                if @board[c][r] == @board[c+1][r+1] && 
                    @board[c][r] == @board[c+2][r+2] && 
                    @board[c][r] == @board[c+3][r+3] && 
                    @board[c][r] != ' '
                    return true
                end
			end
        end
        false
    end

    def left_diag?
        0.upto(3) do |c|
			5.downto(3) do |r|
                if @board[c][r] == @board[c+1][r-1] && 
                    @board[c][r] == @board[c+2][r-2] && 
                    @board[c][r] == @board[c+3][r-3] && 
                    @board[c][r] != ' '
                    return true
                end
			end
		end
        false
    end

    def full?
        @play_count == 42
    end



    def not_filled?(col)
        begin
            @board[col-1].include?(' ')
        rescue NoMethodError
            puts "Possible grid boundaries exceeded! \nEnter any number to continue"
        end
    end


    def valid_entry?(col)
        (1..7).include?(col) && not_filled?(col)
    end


    def drop_disc(disc, col)
        begin
            cell = @board[col - 1].count(' ') - 1
            @board[col - 1][cell] = disc
            @play_count += 1
            if @current_player = @player1
                disc == BLACK
            elsif @current_player = @player2
                disc == WHITE
            end
            display
        rescue NoMethodError
            puts 'Play with numbers [1-7] only'
        end
    end

    def won?
        if row_wins? || col_wins? || diagonal_wins?
            return true
        else
            false
        end
    end

end

class Play
    attr_accessor :name, :disc

    def initialize(name, disc)
        @name = name
        @disc = disc
    end
end
game = Connect4.new
game.start





