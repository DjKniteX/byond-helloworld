client
	New()
		. = ..()
		sleep(1)
		world.log << "Hello World!" // Try breakpointing this line by clicking the editor margin and then debug with F5

	verb
		crash_message()
			CRASH("Boom!")
