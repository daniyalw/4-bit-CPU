VERILOG = iverilog
CONFIG = -g2012

AND_4bit:
	$(VERILOG) $(CONFIG) -o AND_4bit.o AND_4bit.v AND_4bit_tb.v
	vvp AND_4bit.o

wave_AND_4bit:
	gtkwave AND_4bit_tb.vcd