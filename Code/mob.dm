mob
	step_size = 8
	var
		canMove = TRUE
		Speed = 1
		Strength = 1
		Stamina = 100
		exerciseCoolDown = 0
		creatineCoolDown = 0
		list/inventory = list() // Avaiable to all mobs

	Move()
		if(canMove)
			..() // calls parent move proc and will execute if true



	player
		icon = 'player.dmi'
		Login()
			..()
			RegenerateStamina()
			world << "Hello, world!"


	verb
		Choose_Name()
			usr.name = input(usr, "What is your name?", "Name") as text


		Say(T as text)
			view(5, src) << "[src] says :[T]" // anybody within 5 spaces of the src will see the message

		Yell(T as text)
			world << "<b>[src] yells: [T]"

		Consume_Creatine()
			if("creatine" in src.inventory)
				src.inventory -= "creatine"
				src.Stamina += 20
				creatineCoolDown = world.time + 3000
				src << "You took a heaping scoop of creatine!"
			else
				src << "You don't have any creatine."


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
				else src << "You broke the game. Report this bug"
			src << "Your [passedStat] increased to [src.vars[passedStat]]! You are getting stronger than Picoshong!"

		RegenerateStamina()
			if(src.Stamina < 100)
				src.Stamina += 1
			spawn(10) // will execute after the time has passed in the spawn
				RegenerateStamina()

		GetCreatine()
			if("creatine" in src.inventory)
				src << "You already have creatine in your inventory!"
				return
			src.inventory += "creatine"
			src << "You got some creatine!"

		SayHi()
			src << "Picoshong: What you want fool!"
		Attack()
			src << "You do not want to do that right now."
