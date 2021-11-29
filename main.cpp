#include <cmath>
#include <types.hpp>
#include <array>
#include <xil_mmu.h>
#include <xil_cache.h>
#include <xil_cache_l.h>
#include <xpseudo_asm.h>
#include "basis_io_picozed7030_based_processor_board.h"

#define USE_CPU_TO_CPU_IRQ 1
extern u32 MMUTable;

void SetTlbAttributes(uint32_t addr, uint32_t attrib){
	uint32_t *ptr;
	uint32_t section;

	mtcp(XREG_CP15_INVAL_UTLB_UNLOCKED, 0);
	dsb();

	mtcp(XREG_CP15_INVAL_BRANCH_ARRAY, 0);
	dsb();
	Xil_L1DCacheFlush();

	section = addr / 0x100000;
	ptr = &MMUTable + section;
	*ptr = (addr & 0xFFF00000) | attrib;
	dsb();
}


int main(void){
	// Disable L1 cache for OCM ( Communication tunnel )
	SetTlbAttributes(0xFFFF0000,0x04de2);           // S=b0 TEX=b100 AP=b11, Domain=b1111, C=b0, B=b0

	//Disable access to 0x0000 0000 - 0x37FF FFFF (Linux and Golden Bootloader)
	for (uint32_t i = 0; i < 0x380; ++i)
		SetTlbAttributes( 0x100000UL * i, 0x00);

	//Set FPGA register space to non-cached strongly ordered
	for (uint32_t i = 0x400; i < 0x500; ++i)
		SetTlbAttributes( 0x100000UL * i, 0x0C02);

	// Disable L1 and L2 cache for DMA_DDR_buffer
	//SetTlbAttributes(0x3F000000,0x04de2);           // S=b0 TEX=b100 AP=b11, Domain=b1111, C=b0, B=b0

	while(true){
		++cntr_background;
	}
	return 0;
}
