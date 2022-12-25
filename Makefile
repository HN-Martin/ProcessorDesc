GHDL=/usr/bin/ghdl
GHDL_OP = -v
C_MOD_DIR = ../C_model/
all : main_tb

ram.o : ram.vhdl
	${GHDL} -a ${GHDL_OP} ram.vhdl

icache.o : icache.vhdl ram.o
	${GHDL} -a ${GHDL_OP} icache.vhdl

dcache.o : dcache.vhdl ram.o
	${GHDL} -a ${GHDL_OP} dcache.vhdl

main_tb.o : main_tb.vhdl icache.o dcache.o ram.o 
	${GHDL} -a ${GHDL_OP} main_tb.vhdl

arm_core.o : arm_core.vhdl ifetch.o decod.o exec.o mem.o
	${GHDL} -a ${GHDL_OP} arm_core.vhdl
	
ifetch.o : ifetch.vhdl fifo_generic.o
	${GHDL} -a ${GHDL_OP} ifetch.vhdl

decod.o : ../DECOD/decod.vhdl fifo_32b.o fifo_127b.o reg.o
	${GHDL} -a ${GHDL_OP} ../DECOD/decod.vhdl

reg.o : ../DECOD/reg.vhdl 
	${GHDL} -a ${GHDL_OP} ../DECOD/reg.vhdl

exec.o : ../EXEC/exec.vhdl fifo_72b.o alu.o shifter.o
	${GHDL} -a ${GHDL_OP} ../EXEC/exec.vhdl

fifo_72b.o : ../FIFO/fifo_72b.vhdl
	${GHDL} -a ${GHDL_OP} ../FIFO/fifo_72b.vhdl

fifo_32b.o : ../FIFO/fifo_32b.vhdl
	${GHDL} -a ${GHDL_OP} ../FIFO/fifo_32b.vhdl

fifo_127b.o : ../FIFO/fifo_127b.vhdl
	${GHDL} -a ${GHDL_OP} ../FIFO/fifo_127b.vhdl

alu.o : ../EXEC/alu.vhdl
	${GHDL} -a ${GHDL_OP} ../EXEC/alu.vhdl

shifter.o : ../EXEC/shifter.vhdl
	${GHDL} -a ${GHDL_OP} ../EXEC/shifter.vhdl

mem.o : mem.vhdl
	${GHDL} -a ${GHDL_OP} mem.vhdl

main_tb : main_tb.o ram.o icache.o dcache.o arm_core.o ${C_MOD_DIR}/lib/arm_ghdl.o
	${GHDL} -e ${GHDL_OP} -Wl,${C_MOD_DIR}/lib/mem.o -Wl,${C_MOD_DIR}/lib/arm_ghdl.o -Wl,${C_MOD_DIR}/ReadElf/lib/ElfObj.o main_tb

clean :
	rm *.o main_tb work-obj93.cf *.vcd
