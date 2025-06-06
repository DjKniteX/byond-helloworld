obj
	step_size = 8
	density = 1 // tells the game that the object is densed and can't be walked over

	Exercise_Equipment
		icon = 'equipment.dmi'

		Treadmill
			icon_state = "treadmill"
			verb
				Use_Treadmill()
					set src in oview(1) // checking if this icon is one distance away from the user
					usr.Exercise("Speed")
		Barbell
			icon_state = "barbell"
			layer = MOB_LAYER + 1
			verb
				Lift_Barbell()
					set src in oview(1)
					usr.canMove = FALSE
					usr.loc = locate(src.x, src.y, src.z)
					usr.step_x = src.step_x
					usr.step_y = src.step_y
					usr.dir = SOUTH
					animate(src, pixel_y = 16, time = 8)
					animate(pixel_y = 0, time = 5)
					spawn(15)
						usr.Exercise("Strength")
						sleep(2)
						usr.canMove = TRUE
					usr << "You begin to lift the barbell."

	Vending_Machine
		icon = 'vending_machine.dmi'
		verb
			Purchase_Creatine()
				set src in oview(1)
				usr.GetCreatine()

	Dirt_Spot
		icon = 'dirt_spot.dmi'
		alpha = 150
		density = 0
		verb
			Clean_Dirt()
				set src in oview(1)
				usr << "You cleaned up the dirt!"
				usr.dirtCleaned = 1
				src.loc = null // delete function is not very siginificant vs src.loc


