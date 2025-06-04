/*
	These are simple defaults for your project.
 */

world
	fps = 25		// 25 frames per second
	icon_size = 32	// 32x32 icon size by default

	view = 6		// show up to 6 tiles outward from center (13x13 view)

	New()
		// Called when the world is created: Currently just enables the debug server
		var/debug_server = world.GetConfig("env", "AUXTOOLS_DEBUG_DLL")
		if(debug_server)
			call_ext(debug_server, "auxtools_init")()
			enable_debugging()
		. = ..() // Calls the base implementation of world/New()

	Del()
		// Called when the world is destroyed: Currently just shuts down the debug server
		var/debug_server = world.GetConfig("env", "AUXTOOLS_DEBUG_DLL")
		if(debug_server)
			call_ext(debug_server, "auxtools_shutdown")()
		. = ..() // Calls the base implementation of world/Del()

// Make objects move 8 pixels per tick when walking

mob
	step_size = 8

obj
	step_size = 8
