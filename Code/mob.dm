mob
	step_size = 8
	var
		canMove = TRUE

	Move()
		if(canMove)
			..() // calls parent move proc and will execute if true

	player
		icon = 'player.dmi'
