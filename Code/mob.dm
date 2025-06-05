mob
	step_size = 8
	var
		canMove = TRUE
		Speed = 1
		Strength = 1
		Stamina = 100
		exerciseCoolDown = 0

	Move()
		if(canMove)
			..() // calls parent move proc and will execute if true

	player
		icon = 'player.dmi'

	proc
		Exercise(passedStat)
			if(src.exerciseCoolDown > world.time)
				src << "You need to rest before exercising again."
			if(src.Stamina < 10)
				src << "You are too tired to exercise!"
				return
			Stamina -= 10
			switch(passedStat)
				if("Speed")
					src.Speed += 1
				if("Strength")
					src.Strength += 1
			src << "Your [passedStat] increased to [src.vars[passedStat]]! You are getting stronger than Picoshong!"
