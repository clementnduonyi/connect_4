require_relative '../lib/script.rb'

describe Connect4 do
    subject(:connect) {described_class.new}
    describe "#start" do
        it ' Starts game' do
            info = "Have fun playing connect four!"
            allow(connect).to receive(:puts).with(info)
            allow(connect).to receive(:set_up)
            allow(connect).to receive(:take_turns)
            allow(connect).to receive(:game_over?)
            expect(connect.board).to receive(:display)
            connect.start
            
        end
    end

    describe "#creat" do
        it 'Creats player with specific disc' do
            player = 'Nick'
            play_disc = 'BLACK' 
            allow(connect).to receive(:puts)
            allow(connect).to receive(:get_player_name).with('player1')
            allow(connect).to receive(:gets).and_return(player)
            expect(Play).to receive(:new).with(player, play_disc)
            connect.creat('player1', play_disc)

        end
    end

    

end


describe Board do
    subject(:board_connect) {described_class.new}
    describe '#initialize' do
        context 'Displays board' do
            board = Board.new
            it 'generate an empty array for 7 columns' do
                expect(board_connect.board.size).to eq(7)
            end

            it 'generates empty array for 6 rows' do
                expect(board_connect.board.all?{|col| col.size == 6}).to be true
            end
        end
    end

    describe '#not_full?' do
        context 'When validating free columns' do
            before do
                board = Board.new
                board_connect.board[0] = ["BLACK", "WHITE", "BLACK", "WHITE", "BLACK", "BLACK"]
                board_connect.board[1] = [nil, nil, nil, "WHITE", "BLACK", "WHITE"]
            end
            
            it ' returns true when chossen column is empty' do
                expect(board_connect.not_filled?(7)).to eq(true)
            end

            it 'returns true when the chossen column is partially filled' do
                expect(board_connect.not_filled?(3)).to eq(true)
            end

            it 'returns false when the chossen column is filled' do
                expect(board_connect.not_filled?(1)).to eq(false)
            end
        end
    end

    describe '#valide_entry?' do
        it 'return false when entry exceeds vaild possible [1-7] boundaries' do
            entry = 8
            expect(board_connect.valid_entry?(entry)).to be(false)
        end

        it 'return true when entry is within the vaild possible [1-7] boundaries' do
            entry = 5
            expect(board_connect.valid_entry?(entry)).to be(true)
        end
    end

       
    describe "#game_over?" do
        before do
			allow(board_connect).to receive(:won?).and_return(true)
			allow(board_connect).to receive(:full?).and_return(true)
		end

        context 'when 4 disc connected together.' do
            it 'returns true' do
                expect(board_connect.won?).to eq(true)
            end
        end
        context 'when play count is equal 42' do
            it 'returns true'do
                expect(board_connect.full?).to eq(true)
            end
        end
    end

    
end

