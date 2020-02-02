# Ruby code file - All your code should be located between the comments provided.

# Add any additional gems and global variables here		
require 'colorize'
# Main class module
module CF_Game
	# Input and output constants processed by subprocesses. MUST NOT change.
	TOKEN1 = "O"
	TOKEN2 = "X"
	$lastToken = [-1,-1]

	class Game
		attr_reader :matrix, :player1, :player2, :template, :input, :output, :turn, :turnsleft, :winner, :played, :score, :resulta, :resultb, :guess
		attr_writer :matrix, :player1, :player2, :template, :input, :output, :turn, :turnsleft, :winner, :played, :score, :resulta, :resultb, :guess
		
		def initialize(input, output)
			@input = input
			@output = output
		end
		
		def getinput
			txt = @input.gets.chomp
			return txt
		end
		
		# Any code/methods aimed at passing the RSpect tests should be added below.
		
	def start
		@output.puts ("Welcome to Connect 4!").yellow
		@output.puts ("Created by: #{created_by}").yellow
		@output.puts ("Game started.").yellow
		@output.puts ( "\n \t Player 1: O ").green
		@output.puts ("\t Computer Player: X").white
		@output.puts ("\n Enter column number to place token.").green
	end
	
	def created_by
		@game = "Alexander Groh".yellow
		return @game
		end
	
	def student_id
		@game = 51874763
		return @game 
	end

	def displaybegingame
		@output.puts ("Begin game.").green
	end

	
	#prints a message
	def displaynewgamecreated
		@output.puts('New game created.').green
	end
	

	# prints a finish message
	def finish
		@output.puts'Game finished.'.green
	end
	
	
	#prints menu
	def displaymenu
		@output.puts "Menu: (1)Start | (2)New | (9)Exit\n".yellow
	end
	
	
	#display message for player 1
	def displayplayer1prompt
		@output.puts "Player 1 to enter token (0 returns to menu).".green
	end
	
	
	#display message for player 2
	def displayplayer2prompt
		@output.puts "Player 2 to enter token (0 returns to menu).".green
	end
	
	
	#display invalid input
	def displayinvalidinputerror
		@output.puts 'Invalid input.'.red
	end
	
	
	#prints no more room string
	def displaynomoreroomerror
		@output.puts 'No more room in the matrix.'.red
	end
	

	#prints the winner
	def displaywinner(p)
		if p==1
		@output.puts "Player 1 wins.".yellow
		elsif p ==2
		@output.puts "Computer Player wins.".yellow
		end
	end
	
	
	#sets the token O
	def setplayer1
		@player1 = "O"
	end 
	
	
	#sets the token X
	def setplayer2
		@player2 = "X"
	end 

	
	#sets @matrix to be empty 
	def clearcolumns
		@matrix = []
		@matrix[0] = ["_", "_", "_", "_", "_", "_"]
		@matrix[1] = ["_", "_", "_", "_", "_", "_"]
		@matrix[2] = ["_", "_", "_", "_", "_", "_"]
		@matrix[3] = ["_", "_", "_", "_", "_", "_"]
		@matrix[4] = ["_", "_", "_", "_", "_", "_"]
		@matrix[5] = ["_", "_", "_", "_", "_", "_"]
		@matrix[6] = ["_", "_", "_", "_", "_", "_"]
		return @matrix
	end

	#returns the value in appropriate coordinates
	#argument 1 = row coordinate, argument 2 = column coordinate
	def getcolumnvalue(a,b)
		return $matrix[a][b]
	end
	
	# changes a value in matrix
	def setmatrixcolumnvalue(c,  i, v, matrix)
		if matrix[c][i] == "_"
		matrix[c][i] = v
		matrix[c][i] = v
		end
	end
	
	# Displays an empty frame of matrix
	def displayemptyframe
		clearcolumns
		columnTitle = " 1 2 3 4 5 6 7 "
		rowdivider = "+-+-+-+-+-+-+-+"
		rowempty = "|_|_|_|_|_|_|_|"
		@output.puts ("#{columnTitle}")
		for i in 1..6
			@output.puts ("#{rowdivider}")
			@output.puts ("#{rowempty}")
		end
		@output.puts ("#{rowdivider}")
	end
	
	# Displays matrix
	def displayframe(matrix)
		#@output.print $lastToken
		#@output.print "\n"
		
		@output.print "\e[H\e[2J"
		
		columnTitle = " 1 2 3 4 5 6 7 "
		rowdivider = "+-+-+-+-+-+-+-+"
		@output.puts ("#{columnTitle}")
		for i in 0..5
		@output.print "|"
		for j in 0..6
		token1 = matrix[j][5-i]
		
		if j == $lastToken[0] && 5-i == $lastToken[1]-1
			token1 = matrix[j][5-i].yellow
		
		
		elsif matrix[j][5-i] == 'X' 
			token1 = matrix[j][5-i].white
			
		elsif matrix[j][5-i] == 'O' 
			token1 = matrix[j][5-i].green
		
		elsif matrix[j][5-i] == '_'
			token1 = matrix[j][5-i].colorize(:color => :magenta)
		end
		
		
		@output.print token1 + "|"
		end
		@output.print "\n"
		@output.puts ("#{rowdivider}")
		
		end
	end

	def checkfull(matrix)
		full = true
		 for i in 0..5
		 for j in 0..6
		 if matrix[j][5-i] == "_"
		  full = false
		end
		end
		end
		return full
	end

	def getheight(matrix, col)
		count = 6
		for i in 0..5
		if matrix[col][i] == "_"
		count = count - 1
		end
		end
		return count
	end

	def isfull(matrix, col)
		if getheight(matrix, col) == 6
			return true
		else
			return false
	end
	end
	#checks the input during playing the game
	def inputcheck(input)
		case input
			when 1,2,3,4,5,6,7
				return true
			when 0
				return "pause"
			else
				return false
			end
	end
	
	#checks input in main menu
	def inputcheck_menu(input)
		case input
			when 1,2,9
				return true
			when 9
				return "exit"
			else
				return false
			end
	end

	#main playing unit
	def play_turn(player)
		if player == "player1"
		    displayplayer1prompt
			player1 = @input.gets.chomp
			player1 = player1.to_i
			#check for invalid input
			while inputcheck(player1) == false
				displayinvalidinputerror
				player1 = @input.gets.chomp
				player1 = player1.to_i
			end
			#check if player wants to pause the game
			if inputcheck(player1) == "pause"
				$active_player = "player1"	# That says that player1 pause the game
				return "pause"
			end
			#check is column is full			
			while isfull(player1-1) == true
				@output.puts "Column is full, select a new one".red
				player1 = @input.gets.chomp
				player1 = player1.to_i
			end
			#Set player token
			if inputcheck(player1) == true	
			setmatrixcolumnvalue(player1-1,getheight(player1-1),"O")	
			displayframe
			#change active player to player 2 
			$active_player = "player2"
			return
			end
		
		elsif player == "player2"	
			displayplayer2prompt
			player2 = @input.gets.chomp
			player2 = player2.to_i
			#check for invalid input
			while inputcheck(player2) == false
				displayinvalidinputerror
				player2 = @input.gets.chomp
				player2 = player2.to_i
			end
			
			#check if player wants to pause the game
			if inputcheck(player2) == "pause"
				$active_player = "player2" # That says that player2 pause the game
				return "pause"
			end
			#check is column is full
			while isfull(player2-1) == true
				@output.puts "Column is full, select a new one" .red
				player2 = @input.gets.chomp
				player2 = player2.to_i
			end
			#Set player token
			if inputcheck(player2) == true
			setmatrixcolumnvalue(player2-1,getheight(player2-1),"X")
			displayframe
			#change active player to player 1
			$active_player = "player1"
			return
		     end
	
			end
		end
		
	#function for players' turns on the webpage
	def webplay_turn(player,column)
		if  player == "player1"
			player1 = column.to_i				#number of the column
			$message = nil
			#check if column is full
			if isfull(player1-1) == true
				puts " full " 
				$message = "Column is full, select a new one"
				return
			end		
			#set token to matrix
			setmatrixcolumnvalue(player1-1,getheight(player1-1),"O")
			#check for winner
			if checkwinner == 1
				return 1
			end
			#keep track of players turn
			$webactiveplayer = "player2"
			
		elsif player == "player2"
			player2 = column.to_i				#number of the column
			$message = nil
			#check if column is full
			if isfull(player2-1) == true
				puts " full " 
				$message = "Column is full, select a new one"
				return
			end	
			#set token to matrix
			setmatrixcolumnvalue(player2-1,getheight(player2-1),"X")
			#check for winner
			if checkwinner == 2
				return 2
			end
			#keep track of players turn
			$webactiveplayer = "player1"				
			end
			return nil
	end
		
	#find who is the winner
	def checkwinner
		@winner = nil
		@matrix1=[]
		#check "O" player 1	
		#check all columns (checking the one of the 3 possible positions "O" in each column)		
		for i in 0..6
			if  $matrix[i][0] == "O" && $matrix[i][1] == "O" && $matrix[i][2] == "O" && $matrix[i][3] == "O" 
				@winner = 1
				return @winner
			end
			
			if $matrix[i][1] == "O" && $matrix[i][2] == "O" && $matrix[i][3] == "O" && $matrix[i][4] == "O"
				@winner = 1
				return @winner
			end		
			
			if  $matrix[i][2] == "O" && $matrix[i][3] == "O" && $matrix[i][4] == "O" && $matrix[i][5] == "O"
				@winner = 1
				return @winner
			end	
			
		end
			
		#check all rows	
		#check each possibility (one of four positions of "O") in every row
		for i in 0..6
			if  $matrix[0][i] == "O" && $matrix[1][i] == "O" && $matrix[2][i] == "O" && $matrix[3][i] == "O" 
				@winner = 1
				return @winner
			end
			
			if $matrix[1][i] == "O" && $matrix[2][i] == "O" && $matrix[3][i] == "O" && $matrix[4][i] == "O"
				@winner = 1
				return @winner
			end		
			
			if  $matrix[2][i] == "O" && $matrix[3][i] == "O" && $matrix[4][i] == "O" && $matrix[5][i] == "O"
				@winner = 1
				return @winner
			end	
			
			if  $matrix[3][i] == "O" && $matrix[4][i] == "O" && $matrix[5][i] == "O" && $matrix[6][i] == "O" 
				@winner = 1
				return @winner
			end	
		end
	
		#check diagonals player one
		for i in 0..2
			#RIGHT diagonal starting 0,0
			if $matrix[0+i][0+i]=="O" && $matrix[1+i][1+i]=="O" && $matrix[2+i][2+i]=="O" && $matrix[3+i][3+i]=="O"
				@winner = 1
				return @winner
			end
			
			#RIGHT diagonal starting 0,1
			if $matrix[0+i][1+i]=="O" && $matrix[1+i][2+i]=="O" && $matrix[2+i][3+i]=="O" && $matrix[3+i][4+i]=="O"
				@winner = 1
				return @winner
			end
		
			#LEFT diagonal at 6,0
			if $matrix[6-i][0+i]=="O" && $matrix[5-i][1+i]=="O" && $matrix[4-i][2+i]=="O" && $matrix[3-i][3+i]=="O"
				@winner = 1
				return @winner
			end
			
							
			#LEFT diagonal at 5,0 
			if $matrix[5-i][0+i]=="O" && $matrix[4-i][1+i]=="O" && $matrix[3-i][2+i]=="O" && $matrix[2-i][3+i]=="O"
				@winner = 1
				return @winner
			end	
		
		end
		
			#RIGHT diagonal at 0,2
		for i in 0..1	
			if $matrix[0+i][2+i]=="O" && $matrix[2+i][3+i]=="O" && $matrix[3+i][4+i]=="O" && $matrix[4+i][5+i]=="O"
				@winner = 1
				return @winner
			end
		#RIGHT diagonal at 1,0
			if $matrix[1+i][0+i]=="O" && $matrix[2+i][1+i]=="O" && $matrix[3+i][2+i]=="O" && $matrix[4+i][3+i]=="O"
				@winner = 1
				return @winner
			end
			
		#LEFT diagonal at 4,0
			if $matrix[4-i][0+i]=="O" && $matrix[3-i][1+i]=="O" && $matrix[2-i][2+i]=="O" && $matrix[1-i][3+i]=="O"
				@winner = 1
				return @winner
			end
			
		#LEFT diagonal at 1,6	
			if $matrix[6-i][1+i]=="O" && $matrix[5-i][2+i]=="O" && $matrix[4-i][3+i]=="O" && $matrix[3-i][4+i]=="O"
				@winner = 1
				return @winner
			end	
		
		end
		
		#RIGHT diagonal at 0,3	
			if $matrix[0][3]=="O" && $matrix[1][4]=="O" && $matrix[2][5]=="O" && $matrix[3][6]=="O"
				@winner = 1
				return @winner
			end
		#RIGHT diagonal at 2,0	
			if $matrix[2][0]=="O" && $matrix[3][1]=="O" && $matrix[4][2]=="O" && $matrix[5][3]=="O"
				@winner = 1
				return @winner
			end
		
		#LEFT diagonal at 3,0
		if $matrix[3][0]=="O" && $matrix[2][1]=="O" && $matrix[1][2]=="O" && $matrix[0][3]=="O"
				@winner = 1
				return @winner
			end		
		#LEFT diagonal at 6,2
		if $matrix[6][2]=="O" && $matrix[5][3]=="O" && $matrix[4][4]=="O" && $matrix[3][5]=="O"
				@winner = 1
				return @winner
			end	
		
		#check "X" player 2	
		#check all columns
		#check all columns (checking the one of the 3 possible positions "X" in each column)	
		for i in 0..6
			if  $matrix[i][0] == "X" && $matrix[i][1] == "X" && $matrix[i][2] == "X" && $matrix[i][3] == "X" 
				@winner = 2
				return @winner
			end
			
			if $matrix[i][1] == "X" && $matrix[i][2] == "X" && $matrix[i][3] == "X" && $matrix[i][4] == "X"
				@winner = 2
				return @winner
			end		
			
			if  $matrix[i][2] == "X" && $matrix[i][3] == "X" && $matrix[i][4] == "X" && $matrix[i][5] == "X"
				@winner = 2
				return @winner
			end	
			
		end
			
		#check all rows
		#check each possibility (one of four positions of "X") in every row
		for i in 0..5
			if  $matrix[0][i] == "X" && $matrix[1][i] == "X" && $matrix[2][i] == "X" && $matrix[3][i] == "X" 
				@winner = 2
				return @winner
			end
			
			if $matrix[1][i] == "X" && $matrix[2][i] == "X" && $matrix[3][i] == "X" && $matrix[4][i] == "X"
				@winner = 2
				return @winner
			end		
			
			if  $matrix[2][i] == "X" && $matrix[3][i] == "X" && $matrix[4][i] == "X" && $matrix[5][i] == "X"
				@winner = 2
				return @winner
			end	
			
			if  $matrix[3][i] == "X" && $matrix[4][i] == "X" && $matrix[5][i] == "X" && $matrix[6][i] == "X" 
				@winner = 2
				return @winner
			end	
		end
			
			
			#check diagonals player two
		for i in 0..2
			#RIGHT diagonal starting 0,0
			if $matrix[0+i][0+i]=="X" && $matrix[1+i][1+i]=="X" && $matrix[2+i][2+i]=="X" && $matrix[3+i][3+i]=="X"
				@winner = 2
				return @winner
			end
			
			#RIGHT diagonal starting 0,1
			if $matrix[0+i][1+i]=="X" && $matrix[1+i][2+i]=="X" && $matrix[2+i][3+i]=="X" && $matrix[3+i][4+i]=="X"
				@winner = 2
				return @winner
			end
		
			#LEFT diagonal at 6,0
			if $matrix[6-i][0+i]=="X" && $matrix[5-i][1+i]=="X" && $matrix[4-i][2+i]=="X" && $matrix[3-i][3+i]=="X"
				@winner = 2
				return @winner
			end
			
							
			#LEFT diagonal at 5,0 
			if $matrix[5-i][0+i]=="X" && $matrix[4-i][1+i]=="X" && $matrix[3-i][2+i]=="X" && $matrix[2-i][3+i]=="X"
				@winner = 2
				return @winner
			end	
		
		end
		
		#RIGHT diagonal at 0,2
		for i in 0..1	
			if $matrix[0+i][2+i]=="X" && $matrix[2+i][3+i]=="X" && $matrix[3+i][4+i]=="X" && $matrix[4+i][5+i]=="X"
				@winner = 2
				return @winner
			end
		#RIGHT diagonal at 1,0
			if $matrix[1+i][0+i]=="X" && $matrix[2+i][1+i]=="X" && $matrix[3+i][2+i]=="X" && $matrix[4+i][3+i]=="X"
				@winner = 2
				return @winner
			end
			
		#LEFT diagonal at 4,0
			if $matrix[4-i][0+i]=="X" && $matrix[3-i][1+i]=="X" && $matrix[2-i][2+i]=="X" && $matrix[1-i][3+i]=="X"
				@winner = 2
				return @winner
			end
			
		#LEFT diagonal at 1,6	
			if $matrix[6-i][1+i]=="X" && $matrix[5-i][2+i]=="X" && $matrix[4-i][3+i]=="X" && $matrix[3-i][4+i]=="X"
				@winner = 2
				return @winner
			end	
		
		end
			
		#RIGHT diagonal at 0,3	
			if $matrix[0][3]=="X" && $matrix[1][4]=="X" && $matrix[2][5]=="X" && $matrix[3][6]=="X"
				@winner = 2
				return @winner
			end
		#RIGHT diagonal at 2,0	
			if $matrix[2][0]=="X" && $matrix[3][1]=="X" && $matrix[4][2]=="X" && $matrix[5][3]=="X"
				@winner = 2
				return @winner
			end
		
		#LEFT diagonal at 3,0
		if $matrix[3][0]=="X" && $matrix[2][1]=="X" && $matrix[1][2]=="X" && $matrix[0][3]=="X"
				@winner = 2
				return @winner
			end		
		#LEFT diagonal at 6,2
		if $matrix[6][2]=="X" && $matrix[5][3]=="X" && $matrix[4][4]=="X" && $matrix[3][5]=="X"
				@winner = 2
				return @winner
			end	
		
	

			
	end


	#find who is the winner in any matrix, second function from the vm
		def check_winner(matrix)
			winner = nil
			
			
		#check "O" player 1	
			#check all columns (checking the one of the 3 possible positions "O" in each column)		
				for i in 0..6
					if  matrix[i][0] == "O" && matrix[i][1] == "O" && matrix[i][2] == "O" && matrix[i][3] == "O" 
						winner = 1
						return winner
					end
					
					if matrix[i][1] == "O" && matrix[i][2] == "O" && matrix[i][3] == "O" && matrix[i][4] == "O"
						winner = 1
						return winner
					end		
					
					if  matrix[i][2] == "O" && matrix[i][3] == "O" && matrix[i][4] == "O" && matrix[i][5] == "O"
						winner = 1
						return winner
					end	
					
				end
				
			#check all rows	
			#check each possibility (one of four positions of "O") in every row
				for i in 0..6
					if  matrix[0][i] == "O" && matrix[1][i] == "O" && matrix[2][i] == "O" && matrix[3][i] == "O" 
						winner = 1
						return winner
					end
					
					if matrix[1][i] == "O" && matrix[2][i] == "O" && matrix[3][i] == "O" && matrix[4][i] == "O"
						winner = 1
						return winner
					end		
					
					if  matrix[2][i] == "O" && matrix[3][i] == "O" && matrix[4][i] == "O" && matrix[5][i] == "O"
						winner = 1
						return winner
					end	
					
					if  matrix[3][i] == "O" && matrix[4][i] == "O" && matrix[5][i] == "O" && matrix[6][i] == "O" 
						winner = 1
						return winner
					end	
				end
		
			#check diagonals player one
				for i in 0..2
					#RIGHT diagonal starting 0,0
					if matrix[0+i][0+i]=="O" && matrix[1+i][1+i]=="O" && matrix[2+i][2+i]=="O" && matrix[3+i][3+i]=="O"
						winner = 1
						return winner
					end
					
					#RIGHT diagonal starting 0,1
					if matrix[0+i][1+i]=="O" && matrix[1+i][2+i]=="O" && matrix[2+i][3+i]=="O" && matrix[3+i][4+i]=="O"
						winner = 1
						return winner
					end
				
					#LEFT diagonal at 6,0
					if matrix[6-i][0+i]=="O" && matrix[5-i][1+i]=="O" && matrix[4-i][2+i]=="O" && matrix[3-i][3+i]=="O"
						winner = 1
						return winner
					end
					
									
					#LEFT diagonal at 5,0 
					if matrix[5-i][0+i]=="O" && matrix[4-i][1+i]=="O" && matrix[3-i][2+i]=="O" && matrix[2-i][3+i]=="O"
						winner = 1
						return winner
					end	
				
				end
			
				#RIGHT diagonal at 0,2
				for i in 0..1	
					if matrix[0+i][2+i]=="O" && matrix[2+i][3+i]=="O" && matrix[3+i][4+i]=="O" && matrix[4+i][5+i]=="O"
						winner = 1
						return winner
					end
				#RIGHT diagonal at 1,0
					if matrix[1+i][0+i]=="O" && matrix[2+i][1+i]=="O" && matrix[3+i][2+i]=="O" && matrix[4+i][3+i]=="O"
						winner = 1
						return winner
					end
					
				#LEFT diagonal at 4,0
					if matrix[4-i][0+i]=="O" && matrix[3-i][1+i]=="O" && matrix[2-i][2+i]=="O" && matrix[1-i][3+i]=="O"
						winner = 1
						return winner
					end
					
				#LEFT diagonal at 1,6	
					if matrix[6-i][1+i]=="O" && matrix[5-i][2+i]=="O" && matrix[4-i][3+i]=="O" && matrix[3-i][4+i]=="O"
						winner = 1
						return winner
					end	
				
				end
				
				#RIGHT diagonal at 0,3	
					if matrix[0][3]=="O" && matrix[1][4]=="O" && matrix[2][5]=="O" && matrix[3][6]=="O"
						winner = 1
						return winner
					end
				#RIGHT diagonal at 2,0	
					if matrix[2][0]=="O" && matrix[3][1]=="O" && matrix[4][2]=="O" && matrix[5][3]=="O"
						winner = 1
						return winner
					end
				
				#LEFT diagonal at 3,0
				if matrix[3][0]=="O" && matrix[2][1]=="O" && matrix[1][2]=="O" && matrix[0][3]=="O"
						winner = 1
						return winner
					end		
				#LEFT diagonal at 6,2
				if matrix[6][2]=="O" && matrix[5][3]=="O" && matrix[4][4]=="O" && matrix[3][5]=="O"
						winner = 1
						return winner
					end	
				
					
			

		#check "X" player 2	
			#check all columns
			#check all columns (checking the one of the 3 possible positions "X" in each column)	
				for i in 0..6
					if  matrix[i][0] == "X" && matrix[i][1] == "X" && matrix[i][2] == "X" && matrix[i][3] == "X" 
						@winner = 2
						return @winner
					end
					
					if matrix[i][1] == "X" && matrix[i][2] == "X" && matrix[i][3] == "X" && matrix[i][4] == "X"
						@winner = 2
						return @winner
					end		
					
					if  matrix[i][2] == "X" && matrix[i][3] == "X" && matrix[i][4] == "X" && matrix[i][5] == "X"
						@winner = 2
						return @winner
					end	
					
				end
				
			#check all rows
			#check each possibility (one of four positions of "X") in every row
				for i in 0..5
					if  matrix[0][i] == "X" && matrix[1][i] == "X" && matrix[2][i] == "X" && matrix[3][i] == "X" 
						@winner = 2
						return @winner
					end
					
					if matrix[1][i] == "X" && matrix[2][i] == "X" && matrix[3][i] == "X" && matrix[4][i] == "X"
						@winner = 2
						return @winner
					end		
					
					if  matrix[2][i] == "X" && matrix[3][i] == "X" && matrix[4][i] == "X" && matrix[5][i] == "X"
						@winner = 2
						return @winner
					end	
					
					if  matrix[3][i] == "X" && matrix[4][i] == "X" && matrix[5][i] == "X" && matrix[6][i] == "X" 
						@winner = 2
						return @winner
					end	
				end
				
				
				#check diagonals player two
				for i in 0..2
					#RIGHT diagonal starting 0,0
					if matrix[0+i][0+i]=="X" && matrix[1+i][1+i]=="X" && matrix[2+i][2+i]=="X" && matrix[3+i][3+i]=="X"
						@winner = 2
						return @winner
					end
					
					#RIGHT diagonal starting 0,1
					if matrix[0+i][1+i]=="X" && matrix[1+i][2+i]=="X" && matrix[2+i][3+i]=="X" && matrix[3+i][4+i]=="X"
						@winner = 2
						return @winner
					end
				
					#LEFT diagonal at 6,0
					if matrix[6-i][0+i]=="X" && matrix[5-i][1+i]=="X" && matrix[4-i][2+i]=="X" && matrix[3-i][3+i]=="X"
						@winner = 2
						return @winner
					end
					
									
					#LEFT diagonal at 5,0 
					if matrix[5-i][0+i]=="X" && matrix[4-i][1+i]=="X" && matrix[3-i][2+i]=="X" && matrix[2-i][3+i]=="X"
						@winner = 2
						return @winner
					end	
				
				end
			
				#RIGHT diagonal at 0,2
				for i in 0..1	
					if matrix[0+i][2+i]=="X" && matrix[2+i][3+i]=="X" && matrix[3+i][4+i]=="X" && matrix[4+i][5+i]=="X"
						@winner = 2
						return @winner
					end
				#RIGHT diagonal at 1,0
					if matrix[1+i][0+i]=="X" && matrix[2+i][1+i]=="X" && matrix[3+i][2+i]=="X" && matrix[4+i][3+i]=="X"
						@winner = 2
						return @winner
					end
					
				#LEFT diagonal at 4,0
					if matrix[4-i][0+i]=="X" && matrix[3-i][1+i]=="X" && matrix[2-i][2+i]=="X" && matrix[1-i][3+i]=="X"
						@winner = 2
						return @winner
					end
					
				#LEFT diagonal at 1,6	
					if matrix[6-i][1+i]=="X" && matrix[5-i][2+i]=="X" && matrix[4-i][3+i]=="X" && matrix[3-i][4+i]=="X"
						@winner = 2
						return @winner
					end	
				
				end
				
				#RIGHT diagonal at 0,3	
					if matrix[0][3]=="X" && matrix[1][4]=="X" && matrix[2][5]=="X" && matrix[3][6]=="X"
						@winner = 2
						return @winner
					end
				#RIGHT diagonal at 2,0	
					if matrix[2][0]=="X" && matrix[3][1]=="X" && matrix[4][2]=="X" && matrix[5][3]=="X"
						@winner = 2
						return @winner
					end
				
				#LEFT diagonal at 3,0
				if matrix[3][0]=="X" && matrix[2][1]=="X" && matrix[1][2]=="X" && matrix[0][3]=="X"
						@winner = 2
						return @winner
					end		
				#LEFT diagonal at 6,2
				if matrix[6][2]=="X" && matrix[5][3]=="X" && matrix[4][4]=="X" && matrix[3][5]=="X"
						@winner = 2
						return @winner
					end	
				
		

				
		end

	#log file function, creates a new line each time the file is updated and prints the action (loged in, loged out , edited ) and users's username , password and current date
	def update_file(filename,action,username1,username2, password1, password2)
		#checking for guests
		if username1 == " " 
			username1 = "guest"
			password1 = "guest password" 
		end	
		
		if username2 == " "
			username2 = "guest"
			password2 = "guest password" 
		end	
			
		File.open(filename,"a") do |line|
			line.puts "\r"
			if action == "playgame"
				line.puts "\r" + action
				line.puts "\r" + "Player1: " + username1 + " (Password: " + password1 + " )" + " is playing against Player 2:" + username2 +  "( Password: " + password2 + " )"  
				line.puts " Date:" + Time.now.to_s
			else
				line.puts "\r" + action
				line.puts "\r" + "Users logged in: "+ username1 + " (Password: " + password1 + " )" + " and "+ username2 + " ( Password: " + password2 + " )" 
				line.puts "Date:" + Time.now.to_s
			end
			
		end
		
		
	end
	#changes stats if there is a winner; adds 1 to wins in databaase, substract 1 for the loser and  updates players overall score
	def update_winning_stats(user)
		
		if user != " "		#if its not a guest
			p = User.first(:username => user)
				wins_new = p.wins + 1
			p.update(:wins=> wins_new) 							#update wins					
				winning_new = p.winning_rate + 1				
			p.update(:winning_rate => winning_new)                 #update winning rate
		end
		
	end
	# Updates stats for losing player
	def update_losing_stats(user)
	
		if user != " "	
			p = User.first(:username => user)
			new_winning_rate = p.winning_rate - 1
			p.update(:winning_rate => new_winning_rate)					#update winning rate
			new_losses = p.losses + 1	
			p.update(:losses => new_losses)								#update losses
		end
	
	end
	
	
	######################################################################################
	# computer AI
	
		#gives me an array of playable columns
		def active_columns(matrix,active_columns_list)
			j = 0
			for i in 0..6
				if isfull(matrix,i) == false
					active_columns_list[j] = i +1
					j +=1
				end
			end
		end
		
		#gives me a random active column
		def random_input(matrix)
			columns = []
			active_columns(matrix,columns)
			input = columns.sample
			return input
		end	
	
		#if it gets the winning list it returns colum with maximum wins
		def computer_turn(winning_list)
			if winning_list == nil
				return nil
			else
			return winning_list.index(winning_list.max) 	#give me the index(column) of maximum wins 
			end	
		end
		
		#play one game, input: column - which column to finish, winning_col - list to store the winning stats
		def update_winning_column(column, winning_columns)
			columns = []
			active_columns($matrix, columns)	#columns are active_columns 
			if columns.include? column
			
				#copy the matrix (vm - virtual matrix) -> this does only reference the matrix!
=begin				
				vm = []
				for i in 0..6
						vm[i] = $matrix[i]
				end	
					#puts "my vm:"
					#displayframe(vm)###
=end					
				vm = []
				vm = $matrix.map(&:dup)
				
				#place first token to the column of the virtual matrix
				setmatrixcolumnvalue(column-1,getheight(vm, column-1),"X", vm)
				#displayframe(vm)###
				#finish the game randomly (game loop)
				vplaying = true	#virtual playing
				while vplaying
					if checkfull(vm)
						break
					end
					
					player1 = random_input(vm)									#get random input
					player1 = player1.to_i
				setmatrixcolumnvalue(player1-1,getheight(vm, player1 -1),"O", vm) 	#change the matrix
					winner = check_winner(vm)									#check the winner
					#displayframe(vm) ###
					if winner ==2
						winning_columns[column-1] +=1
						vplaying = false
					elsif winner ==1
						vplaying = false
					end
					
					if checkfull(vm)
						break
					end
					
					computer = random_input(vm)											#get random input
					computer = computer.to_i
				setmatrixcolumnvalue(computer-1,getheight(vm, computer - 1),"X", vm)	#change matrix
					
					winner = check_winner(vm)											#check the winner
					if winner ==2
						winning_columns[column-1] +=1
						vplaying = false
					elsif winner ==1
						vplaying = false
					
					end
					#displayframe(vm) ###
				
				end
				
			end
		end
# Any code/methods aimed at passing the RSpect tests should be added above.

	end
end
