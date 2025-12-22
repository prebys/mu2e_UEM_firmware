#ifndef __FEI4__
#define __FEI4__

#define FEI4_CSR                      (*(volatile unsigned int *)(0xc8000000))
#define FEI4_LINKSYNC                 (*(volatile unsigned int *)(0xc8000010))
#define FEI4_IDELAY                   (*(volatile unsigned int *)(0xc8000014))
#define FEI4_SPY_FIFO_CSR             (*(volatile unsigned int *)(0xc8000024))
#define FEI4_SPY_FIFO_DATA            (*(volatile unsigned int *)(0xc8000028))
#define FEI4_CHAN_CSR(chan)           (*(volatile unsigned int *)(0xc8001000+0x100*(chan)))
#define FEI4_CMD(chan)                (*(volatile unsigned int *)(0xc8001004+0x100*(chan)))
#define FEI4_RDREG(chan)              (*(volatile unsigned int *)(0xc8001010+0x100*(chan)))
#define FEI4_CHAN_PIPE(chan)          ( (volatile unsigned int *)(0xc8001030+0x100*(chan)))
#define FEI4_DECODER_STAT(chan)       (*(volatile unsigned int *)(0xc8001040+0x100*(chan)))
#define FEI4_DECODER_EACNT(chan)      (*(volatile unsigned int *)(0xc8001044+0x100*(chan)))
#define FEI4_DECODER_EDCNT(chan)      (*(volatile unsigned int *)(0xc8001048+0x100*(chan)))
#define FEI4_DECODER_SFCNT(chan)      (*(volatile unsigned int *)(0xc800104c+0x100*(chan)))
#define FEI4_DECODER_EFCNT(chan)      (*(volatile unsigned int *)(0xc8001050+0x100*(chan)))
#define FEI4_DECODER_BFCNT(chan)      (*(volatile unsigned int *)(0xc8001054+0x100*(chan)))
#define FEI4_SREC_LATCH(chan)         (*(volatile unsigned int *)(0xc800107c+0x100*(chan)))
#define FEI4_SREC(chan,i)             (*(volatile unsigned int *)(0xc8001080+0x100*(chan)+4*i))

#endif
