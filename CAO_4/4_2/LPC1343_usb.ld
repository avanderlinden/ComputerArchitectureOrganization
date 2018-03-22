/* LPC1343_usb.ld: ROM support for USB, requires the 384 lowest bytes of RAM */
ENTRY(Reset_Handler)

MEMORY
{
	sram	:	ORIGIN = 0x10000000+384, LENGTH = 8k-384
	flash	:	ORIGIN = 0x00000000, LENGTH = 32k
}

_end_stack = 0x10001FF0;

SECTIONS {
	. = ORIGIN(flash);

	vectors :
	{
		*(.vectors)
	} >flash

	.text :
	{
		*(.text.startup)
		*(.text .text*)
		*(.rodata)
		*(.rodata*)
		_end_text = .;
	} >flash

	.data :
	{
		_start_data = .;
		*(.data)
		_end_data = .;
	} >sram AT >flash

	.bss :
	{
		_start_bss = .;
		*(.bss)
		_end_bss = .;
	} >sram

	. = ALIGN(4);

	_start_stack = .;
}

_end = .;
PROVIDE(end = .);
