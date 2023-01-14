-- guess number game
-- get a random number between 1 and 10
local randomNumber = math.random(1, 10)

-- loop until the player guesses the right number
repeat
	-- ask the player to guess the number
	print("Guess a number between 1 and 10")
	local guess = io.read("*n") -- read a number

	-- check if the player guessed correctly
	if guess < randomNumber then
		print("The number is higher than " .. guess .. ". Try again.")
	elseif guess > randomNumber then
		print("The number is lower than " .. guess .. ". Try again.")
	else
		print("You guessed the number!")
	end
until guess == randomNumber
