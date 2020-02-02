# Ruby code file - All your code should be located between the comments provided.

# Add any additional gems and global variables here
require 'colorize'

# The file where you are to write code to pass the tests must be present in the same folder.
require "#{File.dirname(__FILE__)}/wad_cf_gen_01"

# Main program
module CF_Game
	@input = STDIN
	@output = STDOUT
	g = Game.new(@input, @output)
	
	
	g.start
	
	#@output.puts 'This is connect 4 with computer opponent'.green
	#@output.puts 'Player 1 - you'.green
	#@output.puts 'Player 2 - computer'.white
	
	#main game loop
	playing = true
	$matrix = []
	$matrix = g.clearcolumns
	$winner = nil
	while playing
		
		g.displayframe($matrix)
	
		#exit the game if full
		if g.checkfull($matrix)
			@output.puts "The field is full. End of game. \n".red
			break
		end
		
		#PLAYER
		g.displayplayer1prompt
		player1 = @input.gets.chomp
		player1 = player1.to_i
		while g.inputcheck(player1) == false
			g.displayinvalidinputerror
			player1 = @input.gets.chomp
			player1 = player1.to_i
		end
		
		while g.isfull($matrix,player1-1) == true
			@output.puts "Column is full, select a new one".red
			player1 = @input.gets.chomp
			player1 = player1.to_i
		end
		
		#finally setting up the token
		if g.inputcheck(player1) == true	
			g.setmatrixcolumnvalue(player1-1,g.getheight($matrix, player1-1),"O", $matrix)	
			$lastToken = [player1-1,g.getheight($matrix, player1-1)]
			g.displayframe($matrix)
			
		end	
		
		#checking the winner
		$winner = g.checkwinner
			if $winner == 1 || $winner ==2
				g.displayframe($matrix)
				g.displaywinner($winner)
				break
			end
			
		
		#COMPUTER1 - random
=begin		
		@output.puts "Computer turn:".green
		computer = g.random_input($matrix)
		g.setmatrixcolumnvalue(computer-1,g.getheight($matrix, computer-1),"X", $matrix)
		
		
		#checking the winner
		$winner = g.checkwinner
			if $winner == 1 || $winner ==2
				g.displaywinner($winner)
				break
			end
=end	
		
		#COMPUTER2
		winning_list = [0,0,0,0,0,0,0]
		#puts winning_list ###
		for i in 1..7
			for j in 1..100
				g.update_winning_column(i,winning_list) ###
			end
		end
		#puts winning_list
		
		computer = g.computer_turn(winning_list)
		g.setmatrixcolumnvalue(computer,g.getheight($matrix, computer),"X", $matrix)
		$lastToken = [computer,g.getheight($matrix, computer)]
		#checking the winner
		$winner = g.checkwinner
			if $winner == 1 || $winner ==2
				g.displayframe($matrix)
				g.displaywinner($winner)
				break
			end
		
		
		
	end
	
	
	g.finish
	
	
end
#################################################################################################

	# Any code added to output the activity messages to a browser should be added above.

# End program