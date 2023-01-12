--------------------------------------------------------------------
-- create a game where a player can guess a number between 1 and 10
-- and the computer will tell them if they are right or wrong
-- and if they are wrong, if the guess was too high or too low
-- and the player will have 3 guesses
-- and the player will be able to play again
-- and the player will be able to quit
--------------------------------------------------------------------

-- get a random number between 1 and 10
local randomNumber = math.random(1, 10)

-- loop until player guesses the number
while true do
	-- get a number from player
	io.write("Guess a number between 1 and 10: ")
	local getNumber = io.read("*n")

	-- check if player guessesed the number
	if randomNumber == getNumber then
		-- tell player they guessesed the number
		print("You guessesed the number!")
		break
	elseif randomNumber < getNumber then
		-- tell player number too high
		print("Your guess is too high!")
	else
		print("Your guess is too low!")
	end
end
