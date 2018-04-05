# This is a mips-assembly to VHDL compiler written in AWK by X. van Rijnsoever (C) 2009
BEGIN{
	# Output-file
	if (OUTPUT_FILE == "")
		OUTPUT_FILE		= "memory.vhdl"

	# Error handling
	ERROR_OUT		= "/dev/stderr"

	current_address		= 0;

	# Hex_to_bin conversion table
	hex_to_bin["0"]	= "0000"
	hex_to_bin["1"]	= "0001"
	hex_to_bin["2"]	= "0010"
	hex_to_bin["3"]	= "0011"
	hex_to_bin["4"]	= "0100"
	hex_to_bin["5"]	= "0101"
	hex_to_bin["6"]	= "0110"
	hex_to_bin["7"]	= "0111"
	hex_to_bin["8"]	= "1000"
	hex_to_bin["9"]	= "1001"
	hex_to_bin["A"]	= "1010"
	hex_to_bin["B"]	= "1011"
	hex_to_bin["C"]	= "1100"
	hex_to_bin["D"]	= "1101"
	hex_to_bin["E"]	= "1110"
	hex_to_bin["F"]	= "1111"

	# Value-table
	value["0"]	=  0;
	value["1"]	=  1;
	value["2"]	=  2;
	value["3"]	=  3;
	value["4"]	=  4;
	value["5"]	=  5;
	value["6"]	=  6;
	value["7"]	=  7;
	value["8"]	=  8;
	value["9"]	=  9;
	value["0"]	=  0;
	value["a"]	= 10;	value["A"]	= 10;
	value["b"]	= 11;	value["B"]	= 11;
	value["c"]	= 12;	value["C"]	= 12;
	value["d"]	= 13;	value["D"]	= 13;
	value["e"]	= 14;	value["E"]	= 14;
	value["f"]	= 15;	value["F"]	= 15;

	# Registers:
	register["$zero"]	= "00000";	register["$0"]	= "00000";
	register["$at"]		= "00001";	register["$1"]	= "00001";
	register["$v0"]		= "00010";	register["$2"]	= "00010";
	register["$v1"]		= "00011";	register["$3"]	= "00011";
	register["$a0"]		= "00100";	register["$4"]	= "00100";
	register["$a1"]		= "00101";	register["$5"]	= "00101";
	register["$a2"]		= "00110";	register["$6"]	= "00110";
	register["$a3"]		= "00111";	register["$7"]	= "00111";
	register["$t0"]		= "01000";	register["$8"]	= "01000";
	register["$t1"]		= "01001";	register["$9"]	= "01001";
	register["$t2"]		= "01010";	register["$10"]	= "01010";
	register["$t3"]		= "01011";	register["$11"]	= "01011";
	register["$t4"]		= "01100";	register["$12"]	= "01100";
	register["$t5"]		= "01101";	register["$13"]	= "01101";
	register["$t6"]		= "01110";	register["$14"]	= "01110";
	register["$t7"]		= "01111";	register["$15"]	= "01111";
	register["$s0"]		= "10000";	register["$16"]	= "10000";
	register["$s1"]		= "10001";	register["$17"]	= "10001";
	register["$s2"]		= "10010";	register["$18"]	= "10010";
	register["$s3"]		= "10011";	register["$19"]	= "10011";
	register["$s4"]		= "10100";	register["$20"]	= "10100";
	register["$s5"]		= "10101";	register["$21"]	= "10101";
	register["$s6"]		= "10110";	register["$22"]	= "10110";
	register["$s7"]		= "10111";	register["$23"]	= "10111";
	register["$t8"]		= "11000";	register["$24"]	= "11000";
	register["$t9"]		= "11001";	register["$25"]	= "11001";
	register["$k0"]		= "11010";	register["$26"]	= "11010";
	register["$k1"]		= "11011";	register["$27"]	= "11011";
	register["$gp"]		= "11100";	register["$28"]	= "11100";
	register["$sp"]		= "11101";	register["$29"]	= "11101";
	register["$fp"]		= "11110";	register["$30"]	= "11110";
	register["$ra"]		= "11111";	register["$31"]	= "11111";

	# Instructions:
# A
	opcode_field["add"]	= "000000";	func_field["add"]	= "100000";	instr_type["add"]	= "rtype"
	opcode_field["addi"]	= "001000";						instr_type["addi"]	= "itype"
	opcode_field["addiu"]	= "001001";						instr_type["addiu"]	= "itype"
	opcode_field["addu"]	= "000000";	func_field["addu"]	= "100001";	instr_type["addu"]	= "rtype"
	opcode_field["and"]	= "000000";	func_field["and"]	= "100100";	instr_type["and"]	= "rtype"
	opcode_field["andi"]	= "001100";						instr_type["andi"]	= "itype"
# B
	opcode_field["beq"]	= "000100";						instr_type["beq"]	= "b2type"
	opcode_field["bgez"]	= "000001";	rt_field["bgez"]	= "00001";	instr_type["bgez"]	= "b1type"
	opcode_field["bgezal"]	= "000001";	rt_field["bgezal"]	= "10001";	instr_type["bgezal"]	= "b1type"
	opcode_field["bgtz"]	= "000111";	rt_field["bgtz"]	= "00000";	instr_type["bgtz"]	= "b1type"
	opcode_field["blez"]	= "000110";	rt_field["blez"]	= "00000";	instr_type["blez"]	= "b1type"
	opcode_field["bltz"]	= "000001";	rt_field["bltz"]	= "00000";	instr_type["bltz"]	= "b1type"
	opcode_field["bne"]	= "000101";						instr_type["bne"]	= "b2type"
# C
# D
# E
# F
# G
# H
# I
# J
	opcode_field["j"]	= "000010";						instr_type["j"]		= "jtype"
	opcode_field["jal"]	= "000011";						instr_type["jal"]	= "jtype"
	opcode_field["jalr"]	= "000000";	func_field["jalr"]	= "001001";	instr_type["jalr"]	= "jalrtype"
	opcode_field["jr"]	= "000000";	func_field["jr"]	= "001000";	instr_type["jr"]	= "jrtype"
# K
# L
	opcode_field["lui"]	= "001111";						instr_type["lui"]	= "luitype"
	opcode_field["lw"]	= "100011";						instr_type["lw"]	= "memtype"
# M
											instr_type["move"]	= "pseudotype"
# N
	opcode_field["nor"]	= "000000";	func_field["nor"]	= "100111";	instr_type["nor"]	= "rtype"
# O
	opcode_field["or"]	= "000000";	func_field["or"]	= "100101";	instr_type["or"]	= "rtype"
	opcode_field["ori"]	= "001101";						instr_type["ori"]	= "itype"
# P
# Q
# R
# S	
	opcode_field["sll"]	= "000000";	func_field["sll"]	= "000000";	instr_type["sll"]	= "stype"
	opcode_field["sllv"]	= "000000";	func_field["sllv"]	= "000100";	instr_type["sllv"]	= "svtype"
	opcode_field["slt"]	= "000000";	func_field["slt"]	= "101010";	instr_type["slt"]	= "rtype"
	opcode_field["sra"]	= "000000";	func_field["sra"]	= "000011";	instr_type["sra"]	= "stype"
	opcode_field["srl"]	= "000000";	func_field["srl"]	= "000010";	instr_type["srl"]	= "stype"
	opcode_field["sub"]	= "000000";	func_field["sub"]	= "100010";	instr_type["sub"]	= "rtype"
	opcode_field["subu"]	= "000000";	func_field["subu"]	= "100011";	instr_type["subu"]	= "rtype"
	opcode_field["sw"]	= "101011";						instr_type["sw"]	= "memtype"
# T
# U
# V
# W
# X
	opcode_field["xor"]	= "000000";	func_field["xor"]	= "100110";	instr_type["xor"]	= "rtype"
	opcode_field["xori"]	= "001110";						instr_type["xori"]	= "itype"
# Y
# Z
}

{
	# Preprocess (remove some blanks, comments etc)
	sub(/\r/, "")			# No more DOS eol
	sub(/^[ \t]*/, "")		# Remove blank space in the front
	sub(/[ \t]*$/, "")		# .. and in the back
	sub(/[ \t]*#.*/, "")		# Remove comments (and blank space in front of it)
	sub(/[ \t]*\([ \t]*/, "(")	# Make sure there is no space in addresses, check '('
	sub(/[ \t]*\)[ \t]*/, ")")	# .. and check ')'
	gsub(/[ \t]*,[ \t]*/, ",")	# Remove all spaces in before and after ','
	sub(/:/, ": ")			# Put a space behind every colon

	instruction_index = 1
}

$0 == ""{
	# Empty line or line with comments only
	next
}

/:/{
	# Check for invalid labels
	if ($0 !~ /^[_a-zA-Z][_a-zA-Z0-9]*:[^:]*$/)
	{
		printf("Error: invalid label on line %s\n", NR) > ERROR_OUT
		ERROR_OCCURRED = 1; exit 1
	}
}

$1 ~ /^[_a-zA-Z][_a-zA-Z0-9]*:$/{
	# A line with a label
	label = substr($1,1,length($1)-1)

	if (label in label_on_line)
	{
		printf("Error: Double defined label <%s> on line %s (original definition on line %d)\n", label, NR, label_on_line[label]) > ERROR_OUT
		ERROR_OCCURRED = 1; exit 1
	}
	else
	{
		label_on_line[label] = NR
		label_to_address[label] = current_address
	}

	if ($2 == "")
		next
	else
		instruction_index = 2
}

$instruction_index in instr_type{
	# Supported instruction found
	type = instr_type[$instruction_index]

	# Store instruction
	code = substr($0, 1, 40)

	program_code[current_address]	= code

	if (type == "rtype")
		rtype($instruction_index)
	else if (type == "itype")
		itype($instruction_index)
	else if (type == "stype")
		stype($instruction_index)
	else if (type == "svtype")
		svtype($instruction_index)
	else if (type == "jtype")
		jtype($instruction_index)
	else if (type == "b1type")
		b1type($instruction_index)
	else if (type == "b2type")
		b2type($instruction_index)
	else if (type == "memtype")
		memtype($instruction_index)
	else if (type == "luitype")
		luitype($instruction_index)
	else if (type == "jrtype")
		jrtype($instruction_index)
	else if (type == "jalrtype")
		jalrtype($instruction_index)
	else if (type == "pseudotype")
		pseudotype($instruction_index)
	else
	{
		printf("Error: Internal error: unknown instr_type <%s>, %s\n", type, $instruction_index) > ERROR_OUT
		ERROR_OCCURRED = 1; exit 1
	}

	next
}

{
	# No label and/or no instruction found
	if (instruction_index == 2)
	{
		$0 = substr($0, length($1)+1)
		sub(/^[ \t]/, "")
	}
	printf("Error: Unknown or unsupported instruction <%s> found on line %d\n", $0, NR) > ERROR_OUT
	ERROR_OCCURRED = 1; exit 1
}

END{
	if (ERROR_OCCURRED) exit 1
	backpatch()
	print_pre_text()
	print_instructions()
	print_post_text()
	close(OUTPUT_FILE)
}

function rtype(opcode){
	# Register type
	split_and_check_args(opcode, 3)

	instr_opcode	= get_opcode_field(instr_fields[instruction_index+0])
	instr_func	= get_func_field(instr_fields[instruction_index+0])
	instr_RD	= get_register(instr_fields[instruction_index+1])
	instr_RS	= get_register(instr_fields[instruction_index+2])
	instr_RT	= get_register(instr_fields[instruction_index+3])

	instruction	= instr_opcode instr_RS instr_RT instr_RD "00000" instr_func

	instructions[current_address] = instruction
	current_address	+= 4
}

function itype(opcode){
	# Immidiate type
	split_and_check_args(opcode, 3)

	instr_opcode	= get_opcode_field(instr_fields[instruction_index+0])
	instr_RT	= get_register(instr_fields[instruction_index+1])
	instr_RS	= get_register(instr_fields[instruction_index+2])
	instr_imm	= get_imm_field(instr_fields[instruction_index+3])

	instruction	= instr_opcode instr_RS instr_RT instr_imm

	instructions[current_address] = instruction
	current_address	+= 4
}

function stype(opcode){
	# Shamt-type
	split_and_check_args(opcode, 3)

	instr_opcode	= get_opcode_field(instr_fields[instruction_index+0])
	instr_func	= get_func_field(instr_fields[instruction_index+0])
	instr_RD	= get_register(instr_fields[instruction_index+1])
	instr_RT	= get_register(instr_fields[instruction_index+2])
	instr_shamt	= get_shamt_field(instr_fields[instruction_index+3])

	instruction	= instr_opcode "00000" instr_RT instr_RD instr_shamt instr_func

	instructions[current_address] = instruction
	current_address	+= 4
}

function svtype(opcode){
	# Shift Variable-type
	split_and_check_args(opcode, 3)

	instr_opcode	= get_opcode_field(instr_fields[instruction_index+0])
	instr_func	= get_func_field(instr_fields[instruction_index+0])
	instr_RD	= get_register(instr_fields[instruction_index+1])
	instr_RT	= get_register(instr_fields[instruction_index+2])
	instr_RS	= get_register(instr_fields[instruction_index+3])

	instruction	= instr_opcode instr_RS instr_RT instr_RD "00000" instr_func

	instructions[current_address] = instruction
	current_address	+= 4
}

function jtype(opcode){
	# Jump-type
	split_and_check_args(opcode, 1)

	instr_opcode	= get_opcode_field(instr_fields[instruction_index+0])

	address_to_label[current_address] = instr_fields[instruction_index+1]
	target_on_line[current_address] = NR;

	instruction	= instr_opcode

	instructions[current_address] = instruction
	jump_type[current_address] = "jump"
	current_address	+= 4
}

function b1type(opcode){
	# Branch-type with 1 register operand
	split_and_check_args(opcode, 2)

	instr_opcode	= get_opcode_field(instr_fields[instruction_index+0])
	instr_RT_field	= get_RT_field(instr_fields[instruction_index+0])
	instr_RS	= get_register(instr_fields[instruction_index+1])

	address_to_label[current_address] = instr_fields[instruction_index+2]
	target_on_line[current_address] = NR;

	instruction	= instr_opcode instr_RS instr_RT_field

	instructions[current_address] = instruction
	jump_type[current_address] = "branch"
	current_address	+= 4
}

function b2type(opcode){
	# Branch-type with 2 register operands
	split_and_check_args(opcode, 3)

	instr_opcode	= get_opcode_field(instr_fields[instruction_index+0])
	instr_RS	= get_register(instr_fields[instruction_index+1])
	instr_RT	= get_register(instr_fields[instruction_index+2])

	address_to_label[current_address] = instr_fields[instruction_index+3]
	target_on_line[current_address] = NR;

	instruction	= instr_opcode instr_RS instr_RT

	instructions[current_address] = instruction
	jump_type[current_address] = "branch"
	current_address	+= 4
}

function memtype(opcode){
	# Mem-type with number($register) notation
	split_and_check_args(opcode, 2)

	instr_opcode	= get_opcode_field(instr_fields[instruction_index+0])
	instr_RT	= get_register(instr_fields[instruction_index+1])
	instr_RS	= get_address_register(instr_fields[instruction_index+2])
	instr_offset	= get_address_offset(instr_fields[instruction_index+2])

	instruction	= instr_opcode instr_RS instr_RT instr_offset

	instructions[current_address] = instruction
	current_address	+= 4
}

function pseudotype(opcode,	new_instruction, constant){
	if (opcode == "move")
	{
		split_and_check_args(opcode, 2)

		if (instruction_index == 2) new_instruction = instr_fields[instruction_index-1]" "
		$0 = new_instruction "or " instr_fields[instruction_index+1] ",$0," instr_fields[instruction_index+2]
		rtype("or")
	}
	else
	{
		printf("Error: Internal error: unknown pseudotype <%s>\n", opcode) > ERROR_OUT
		ERROR_OCCURRED = 1; exit 1
	}
}

function luitype(opcode){
	# Lui-type
	split_and_check_args(opcode, 2)

	instr_opcode	= get_opcode_field(instr_fields[instruction_index+0])
	instr_RS_field	= "00000"
	instr_RT	= get_register(instr_fields[instruction_index+1])
	instr_imm	= get_imm_field(instr_fields[instruction_index+2])

	instruction	= instr_opcode instr_RS_field instr_RT instr_imm

	instructions[current_address] = instruction
	current_address	+= 4
}

function jrtype(opcode){
	# Jr-type
	split_and_check_args(opcode, 1)

	instr_opcode	= get_opcode_field(instr_fields[instruction_index+0])
	instr_func	= get_func_field(instr_fields[instruction_index+0])
	instr_RS	= get_register(instr_fields[instruction_index+1])

	instruction	= instr_opcode instr_RS "000000000000000" instr_func

	instructions[current_address] = instruction
	current_address	+= 4
}

function jalrtype(opcode){
	# Jalr-type
	split_and_check_args(opcode, 2)

	instr_opcode	= get_opcode_field(instr_fields[instruction_index+0])
	instr_RS	= get_register(instr_fields[instruction_index+2])
	instr_RT_field	= "00000"
	instr_RD	= get_register(instr_fields[instruction_index+1])

	instruction	= instr_opcode instr_RS instr_RT_field instr_RD "00000001001"

	instructions[current_address] = instruction
	current_address	+= 4
}

function get_register(register_name){
	if (register_name in register)
		return register[register_name]
	printf("Error: Unknown register <%s> on line %d\n", register_name, NR) > ERROR_OUT
	ERROR_OCCURRED = 1; exit 1
}

function get_opcode_field(opcode_name){
	if (opcode_name in opcode_field)
		return opcode_field[opcode_name]
	printf("Error: Internal error: No opcode-field found for opcode <%s> on line %d\n", opcode, NR) > ERROR_OUT
	ERROR_OCCURRED = 1; exit 1
}

function get_func_field(opcode_name){
	if (opcode_name in func_field)
		return func_field[opcode_name]
	printf("Error: Internal error: No func-field found for opcode <%s> on line %d\n", opcode, NR) > ERROR_OUT
	ERROR_OCCURRED = 1; exit 1
}

function get_RT_field(opcode_name){
	if (opcode_name in rt_field)
		return rt_field[opcode_name]
	printf("Error: Internal error: No rt-field found for opcode <%s> on line %d\n", opcode, NR) > ERROR_OUT
	ERROR_OCCURRED = 1; exit 1
}

function get_address_register(address){
	split(address, address_fields, /[()]/)
	return get_register(address_fields[2])
}

function get_address_offset(address){
	split(address, address_fields, /[()]/)
	return get_number_field(address_fields[1], 16)
}

function get_imm_field(imm_field){
	return get_number_field(imm_field, 16)
}

function get_shamt_field(shamt_field){
	return get_number_field(shamt_field, 5)
}

function get_number_field(field, num_of_bits){
	if (field ~ /^[0-9][0-9a-zA-Z]*[hH]$/)		# Hex
		number = get_value(field, 16)
	else if (field ~ /^[0-7]+[Oo]$/)		# Oct
		number = get_value(field, 8)
	else if (field ~ /(^[+-]?[0-9]+$)/)		# Dec
		number = get_value(field, 10)
	else
	{
		printf("Error: invalid number <%s> on line %d\n", field, NR) >> ERROR_OUT
		ERROR_OCCURRED = 1; exit 1
	}

	if (number >= 2^num_of_bits)
	{
		print "Warning: number " number " on line " NR " is too large, set back to maximum supported value of " 2^num_of_bits - 1 > ERROR_OUT
		number = 2^num_of_bits - 1
	}

	return number_to_binary(number, num_of_bits)
}

function number_to_binary(number, num_of_bits,	i, hex_number, binary){
	hex_number = sprintf("%08X", number)
	for (i = 1; i <= length(hex_number); i++)
		binary = binary hex_to_bin[substr(hex_number, i, 1)]
	return substr(binary, length(binary)-(num_of_bits-1))
}

function split_and_check_args(opcode, n,		size){
	size = split($0, instr_fields, /[,]?[ \t]*/)

	size -= instruction_index

	if (size < n)
	{
		printf("Error: Insufficient number of arguments for opcode <%s> on line %d (expect %d, got %d)\n", opcode, NR, n, size) > ERROR_OUT
		ERROR_OCCURRED = 1; exit 1
	}
	else if (size > n)
	{
		printf("Error: To many arguments for opcode <%s> on line %d (expect %d, got %d)\n", opcode, NR, n, size) > ERROR_OUT
		ERROR_OCCURRED = 1; exit 1
	}
}

function get_value(string, base,	i, result, do_negate, digit){
	for (i = 1; i <= length(string); i++)
	{
		digit = substr(string, i, 1)

		if (digit == "-")
			do_negate = 1
		else if (digit in value)
			result = result * base + value[digit]
	}
	if (do_negate) result = -result

	return result
}


function backpatch(i){
	# Patch references to labels

	for (i in address_to_label)
	{
		if (address_to_label[i] in label_to_address)
		{
			if (i in jump_type && jump_type[i] == "jump")
			{
				instructions[i] = instructions[i] number_to_binary(int(label_to_address[address_to_label[i]]/4), 26)
			}
			else if (i in jump_type && jump_type[i] == "branch")
			{
				target_address	= label_to_address[address_to_label[i]]
				offset		= target_address - i - 4

				instructions[i]	= instructions[i] number_to_binary(int(offset/4), 16)
			}
			else
			{
				printf("Error: Internal error: jump-type unknown\n") >> ERROR_OUT
				ERROR_OCCURRED = 1; exit 1
			}
		}
		else
		{
			printf ("Error: undefined label <%s> on line %d\n", address_to_label[i], target_on_line[i]) > ERROR_OUT
			ERROR_OCCURRED = 1; exit 1
		}
	}
}

function print_pre_text(){
	print "library IEEE;"								> OUTPUT_FILE
	print "use IEEE.std_logic_1164.all;"						> OUTPUT_FILE
	print "use IEEE.numeric_std.all;"						> OUTPUT_FILE
	print ""									> OUTPUT_FILE
	print "entity memory is"							> OUTPUT_FILE
	print "	port"									> OUTPUT_FILE
	print "	("									> OUTPUT_FILE
	print "		clk			: in  std_logic;"			> OUTPUT_FILE
	print "		rst			: in  std_logic;"			> OUTPUT_FILE
	print "		memread			: in  std_logic;"			> OUTPUT_FILE
	print "		memwrite		: in  std_logic;"			> OUTPUT_FILE
	print "		address1		: in  std_logic_vector (31 downto 0);"	> OUTPUT_FILE
	print "		address2		: in  std_logic_vector (31 downto 0);"	> OUTPUT_FILE
	print "		writedata		: in  std_logic_vector (31 downto 0);"	> OUTPUT_FILE
	print "		instruction		: out std_logic_vector (31 downto 0);"	> OUTPUT_FILE
	print "		readdata		: out std_logic_vector (31 downto 0)"	> OUTPUT_FILE
	print "	);"									> OUTPUT_FILE
	print "end memory;"								> OUTPUT_FILE
	print ""									> OUTPUT_FILE
	print "architecture behavior of memory is"					> OUTPUT_FILE
	print "	type ramcell is array (0 to 255) of std_logic_vector (7 downto 0);"	> OUTPUT_FILE
	print "	signal ram			: ramcell;"				> OUTPUT_FILE
	print "	signal masked1, masked2		: std_logic_vector (7 downto 0);"	> OUTPUT_FILE
	print "	signal selector1, selector2	: natural range 0 to 255;"		> OUTPUT_FILE
	print "begin"									> OUTPUT_FILE
	print "	masked1 <= address1 (7 downto 2) & \"00\";"				> OUTPUT_FILE
	print "	masked2 <= address2 (7 downto 2) & \"00\";"				> OUTPUT_FILE
	print "	selector1 <= to_integer (unsigned (masked1));"				> OUTPUT_FILE
	print "	selector2 <= to_integer (unsigned (masked2));"				> OUTPUT_FILE
	print ""									> OUTPUT_FILE
	print "	process (clk, rst, memread, memwrite, address1, address2, writedata)"	> OUTPUT_FILE
	print "	begin"									> OUTPUT_FILE
	print "		if (rising_edge (clk)) then"					> OUTPUT_FILE
	print "			if (rst = '1') then"					> OUTPUT_FILE
}

function print_instructions(){
	i = 0
	while (i in instructions && i < 256)
	{
		if (i in program_code)
			printf("\t\t\t\tram (%3d) <= \"%s\"; -- %s\n", i+0, substr(instructions[i], 25, 8), program_code[i]) > OUTPUT_FILE
		else
			printf("\t\t\t\tram (%3d) <= \"%s\";\n", i+0, substr(instructions[i], 25, 8))	> OUTPUT_FILE
		printf("\t\t\t\tram (%3d) <= \"%s\";\n", i+1, substr(instructions[i], 17, 8))		> OUTPUT_FILE
		printf("\t\t\t\tram (%3d) <= \"%s\";\n", i+2, substr(instructions[i],  9, 8))		> OUTPUT_FILE
		printf("\t\t\t\tram (%3d) <= \"%s\";\n", i+3, substr(instructions[i],  1, 8))		> OUTPUT_FILE
		i += 4
	}
	if (256 in instructions) printf("Warning: Program is larger than the memory, truncated to 64 instructions\n") > ERROR_OUT
}

function print_post_text(){
	if (i < 256)
	{
		print "				for i in " i " to 255 loop"									> OUTPUT_FILE
		print "					ram (i) <= std_logic_vector (to_unsigned (0, 8));"					> OUTPUT_FILE
		print "				end loop;"											> OUTPUT_FILE
	}

	print "			else"														> OUTPUT_FILE
	print "				if (memwrite = '1') then"										> OUTPUT_FILE
	print "					ram (selector2 + 0) <= writedata (7 downto 0);"							> OUTPUT_FILE
	print "					ram (selector2 + 1) <= writedata (15 downto 8);"						> OUTPUT_FILE
	print "					ram (selector2 + 2) <= writedata (23 downto 16);"						> OUTPUT_FILE
	print "					ram (selector2 + 3) <= writedata (31 downto 24);"						> OUTPUT_FILE
	print "				end if;"												> OUTPUT_FILE
	print "			end if;"													> OUTPUT_FILE
	print "		end if;"														> OUTPUT_FILE
	print "	end process;"															> OUTPUT_FILE
	print "	instruction <= ram (selector1 + 3) & ram (selector1 + 2) & ram (selector1 + 1) & ram (selector1 + 0);"				> OUTPUT_FILE
	print "	with memread select"														> OUTPUT_FILE
	print "		readdata <=	std_logic_vector (to_unsigned (0, 32)) when '0',"							> OUTPUT_FILE
	print "				ram (selector2 + 3) & ram (selector2 + 2) & ram (selector2 + 1) & ram (selector2 + 0) when others;"	> OUTPUT_FILE
	print "end behavior;"															> OUTPUT_FILE
}
