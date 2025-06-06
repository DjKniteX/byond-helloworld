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
			verb
				Lift_Barbell()
					set src in oview(1)
					usr.Exercise("Strength")

	Vending_Machine
		icon = 'vending_machine.dmi'
		verb
			Purchase_Creatine()
				set src in oview(1)
				usr.GetCreatine()

	Dirt_Spot
		icon = 'dirt_spot.dmi'
		alpha = 150
		verb
			Clean_Dirt()
				set src in oview(1)
				usr << "You cleaned up the dirt!"
				src.loc = null // delete function is not very siginificant vs src.loc


