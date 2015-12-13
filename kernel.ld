//linker script for the generation of the Raspberry Pi kernel images using C
SECTIONS {
	
	//.init section runs first followed by the data and the rest of the code
	.init 0x8000 : {
		*(.init)
	}
	
	//data
	.data : {
		*(.data)
		*.c.o(*)
	}
	
	.text : {
		*.c.o(.text)
		*(.text)
	}

	/DISCARD/ : {
		*(*)
	}
}
