mob
	step_size = 8
	var
		canMove = TRUE
		Speed = 1
		Strength = 1
		Stamina = 100
		exerciseCoolDown = 0
		creatineCoolDown = 0
		questsCompleted = 0
		list/playerList = list()
		list/inventory = list() // Avaiable to all mobs
		tmp
			dirtCleaned = 0

	Move()
		if(canMove)
			..() // calls parent move proc and will execute if true



	player
		icon = 'player.dmi'
		Login()
			..()
			RegenerateStamina()
			playerList += src
			world << "Hello, world!"
		Logout()
			playerList -= src
			..()
		Stat()
			if(statpanel("Stats"))
				stat("Name: ", name)
				stat("Speed: ", Speed)
				stat("Strength: ", Strength)
				stat("Stamina: :", Stamina)


	verb
		Choose_Name()
			usr.name = input(usr, "What is your name?", "Name") as text

		Check_Online_Players()
			usr << "PLAYERS ONLINE"
			for(var/mob/i in playerList)
				usr << i


		Say(T as text)
			if(CheckArea(/area/spooky_area))
				src << "Nothing happens...."
				return
			view(5, src) << "[src] says :[T]" // anybody within 5 spaces of the src will see the message

		Yell(T as text)
			world << "<b>[src] yells: [T]"

		Consume_Creatine()
			if(world.time < usr.creatineCoolDown)
				usr << "It's too soon for another serving!"
				return
			if("creatine" in src.inventory)
				src.inventory -= "creatine"
				src.Stamina += 20
				creatineCoolDown = world.time + 3000
				src << "You took a heaping scoop of creatine!"
			else
				src << "You don't have any creatine."
		Save_Progress()
			if(fexists("savefile.sav"))
				fdel("savefile.sav")
			var/savefile/F = new("savefile.sav")
			Write(F)
			F["x"] << src.x
			F["y"] << src.y
			F["z"] << src.z
		Load_Progress()
			if(fexists("savefile.sav"))
				var/savefile/F = new("savefile.sav")
				Read(F)
				var/x; var/y; var/z
				F["x"] >> x
				F["y"] >> y
				F["z"] >> z
				loc = (locate(x,y,z))
		Check_LOC()
			src << src.loc


	proc
		CheckArea(area/passedArea)
			for(var/area/A in range(0, src.loc)) // range is similar to oview, but can look at a tile when a player is standing
				if (A.type == passedArea)
					return TRUE


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

	npc
		Picoshong
			icon = 'enemy.dmi'
			icon_state = "picoshong"
			Strength = 10
			verb
				Talk()
					set src in oview(1)
					var/response = alert(usr, "This is my gym. You can call me Picoshong", "Picoshong", "Can I get a job?", "Can I fight you?")
					switch(response)
						if("Can I get a job?")
							usr << "Sure, you can clean up some dirt on the gym floor! Accept the quest?"
							var/accept_quest = alert(usr, "Do you want to accept the quest?", "Cleanup Duty", "Yes", "No")
							if(accept_quest == "Yes")
								usr << "Great! There's a dirt spot on the floor. Go clean it up and come back."
								new/obj/Dirt_Spot(locate(10, 10, 1))
						if("Can I fight you?")
							if( usr.Strength > src.Strength)
								usr << "Let's throw down!"
							else
								usr << "You think you can fight me? You can never fight me"
				Complete_Quest()
					set src in oview(1)
					if(usr.dirtCleaned == 1)
						usr.questsCompleted += 1
						usr << "Great Job!"
						usr.dirtCleaned = 0
					else
						usr << "Go clean up the dirt, lazy bones!"

