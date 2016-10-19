/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xil_io.h"
#include "sleep.h"
#include "limits.h"

#define OCI2CBASEFMC	0x43c00000		// I2C core for FMC1-2 I2C bus
#define OCI2CBASEFE		0x43c10000		// I2C core for FASEC EEPROM
#define FHWTEST			0x43c20000		// FASEC HW-TEST core base
#define OCI2CF1TEST		0x43c30000		// FMC1 TESTER EDA-2327
#define OCI2CF2TEST		0x43c40000		// FMC2 TESTER EDA-2327

// I2C OC registers
#define PREL	0x0		// clock prescale low
#define PREH	0x1		// clock prescale high
#define CTR		0x2		// control register
#define TXR		0x3		// transmit register (W)
#define RXR		0x3		// receive register (R)
#define CR		0x4		// command register (W)
#define SR		0x4		// status register (R)
// masks
#define CTR_EN 7
#define CR_STA 7
#define CR_STO 6
#define CR_RD 5
#define CR_WR 4
#define CR_ACK 3
#define SR_RXACK 7
#define SR_TIP 1

// FMC Tester addressing
#define FT_IC2		0x24
#define FT_IC1		0x27
#define FHWTEST_FMC1	0x0
#define FHWTEST_FMC2	0x4

// misc
#define TIMEOUT 2000	// high timeout needed because of I2C clock = 100 kHz

u32 readReg(u32 base, u32 addr){
	return Xil_In32(base + (addr<<2));
}
void writeReg(u32 base, u32 addr, u32 val){
	Xil_Out32(base + (addr<<2), val);
}

int waitTransfer(u32 base){
	int i;
	for(i=TIMEOUT;i!=0;i--){
		if ((readReg(base, SR) & 1<<SR_TIP) == 0x0){
//			usleep(100);	// sleep 100 us otherwise spurious 'no RxACK' -- no influence
			return 0;
		}
	}
	print("ERROR: transfer not completed\n\r");
	writeReg(base, CR, 1<<CR_STO);	// stop signal to abort data transfer
	return (i==0)?1:0;	// return 0 when success
}

int waitAck(u32 base){
	if ((readReg(base, SR) & 1<<SR_RXACK) != 0x0){
		print("ERROR: no byte RxACK from slave seen!\n\r");
		writeReg(base, CR, 1<<CR_STO);	// stop signal to abort data transfer
		return 2;
	} else{
		return 0;
	}
}
int OCI2C_init(u32 base){
	if ((readReg(base, CTR) & 1<<CTR_EN) == 1<<CTR_EN)
		writeReg(base, CTR, 0<<CTR_EN);	// disable EN bit so we can set the prescale value
	writeReg(base, PREL, 0xC8);	// 100MHz/(5*0.1MHz)
	writeReg(base, PREH, 0x00);
	print("prescale value set \n\r");
	writeReg(base, CTR, 1<<CTR_EN);	// enable core without interrupts
	return 0;
}

u32 readReg_24AA64(u32 base, u8 slave, u8 readAddrH, u8 readAddrL){
	// send control byte (write)
	writeReg(base, TXR, slave<<1 | 0x0);	// address & write-bit
	writeReg(base, CR, 1<<CR_STA | 1<<CR_WR);
	if (waitTransfer(base)!=0)
		return 1;
	// send read-addresses high
//		print("sending read address high\n\r");
	if (waitAck(base)!=0)
		return 2;
	writeReg(base, TXR, readAddrH);
	writeReg(base, CR, 1<<CR_WR);
	if (waitTransfer(base)!=0)
		return 1;
	// send read-addresses low
//		print("sending read address low\n\r");
	if (waitAck(base)!=0)
		return 2;
	writeReg(base, TXR, readAddrL);
	writeReg(base, CR, 1<<CR_WR);
	if (waitTransfer(base)!=0)
		return 1;
	// send control byte (read)
//		print("sending control byte for reading\n\r");
	if (waitAck(base)!=0)
		return 2;
	writeReg(base, TXR, slave<<1 | 0x1);	// address & read-bit
	writeReg(base, CR, 1<<CR_STA | 1<<CR_WR);
	if (waitTransfer(base)!=0)
		return 1;
	// send CR byte to prepare read
//		print("reading ...\n\r");
	if (waitAck(base)!=0)
		return 2;
	writeReg(base, CR, 1<<CR_RD | 1<<CR_ACK | 1<<CR_STO);
	if (waitTransfer(base)!=0)
		return 1;
	// read output
	return readReg(base, RXR);
}

u32 readReg_mcp23017(u32 base, u8 slave, u8 readAddr){
//		print("sending control byte - write\n\r");
	writeReg(base, TXR, slave<<1 | 0x0);	// address & write-bit
	writeReg(base, CR, 1<<CR_STA | 1<<CR_WR);
	if (waitTransfer(base)!=0)
		return 1;
//		print("sending read address\n\r");
	if (waitAck(base)!=0)
		return 2;
	writeReg(base, TXR, readAddr);
	writeReg(base, CR, 1<<CR_WR);
	if (waitTransfer(base)!=0)
		return 1;
//		print("sending control byte for reading\n\r");
	if (waitAck(base)!=0)
		return 2;
	writeReg(base, TXR, slave<<1 | 0x1);	// address & read-bit
	writeReg(base, CR, 1<<CR_STA | 1<<CR_WR);
	if (waitTransfer(base)!=0)
		return 1;
//		print("reading ...\n\r");
	if (waitAck(base)!=0)
		return 2;
	writeReg(base, CR, 1<<CR_RD | 1<<CR_ACK | 1<<CR_STO);
	if (waitTransfer(base)!=0)
		return 1;
	// read output
	return readReg(base, RXR);
}

int writeReg_mcp23017(u32 base, u8 slave, u8 writeAddr, u8 val){
	/*
	 * IOCON all 0 by default, hence:
	 *  same bank reg - sequential regs
	 *  address pointer increments
	 */
//		print("sending control byte - write\n\r");
	writeReg(base, TXR, slave<<1 | 0x0);	// address & write-bit
	writeReg(base, CR, 1<<CR_STA | 1<<CR_WR);
	if (waitTransfer(base)!=0)
		return 1;
//		print("sending write address\n\r");
	if (waitAck(base)!=0)
		return 2;
	writeReg(base, TXR, writeAddr);
	writeReg(base, CR, 1<<CR_WR);
	if (waitTransfer(base)!=0)
		return 1;
//		print("sending control byte for writing\n\r");
	if (waitAck(base)!=0)
		return 2;
	writeReg(base, TXR, slave<<1 | 0x0);	// address & write-bit
	writeReg(base, CR, 1<<CR_STA | 1<<CR_WR);
	if (waitTransfer(base)!=0)
		return 1;
//		print("sending data byte for write ...\n\r");
	if (waitAck(base)!=0)
		return 2;
	writeReg(base,TXR,val);
	writeReg(base, CR, 1<<CR_STO | 1<<CR_WR);
	if (waitTransfer(base)!=0)
		return 1;
	if (waitAck(base)!=0)
		return 2;
	// finished
	return 0;
}

int main()
{
	u32 readVal;
	u32 readAddrH;
	int i;
	char inputChar;
	u8 slave_addr;
	u32 oic_base;

	print("** FMC1 I2C tests starting **\n\r");
    init_platform();

    oic_base = OCI2CBASEFMC;
	for (i=PREL; i<SR+1;i++){
		printf("I2C master register %#010x: %#010x \n\r", (unsigned int)oic_base + (i<<2),
				(unsigned int)readReg(oic_base, i));
	}

	print("FMC1 I2C tests finished \n\r");

	// init all OCI2C cores
	OCI2C_init(OCI2CBASEFMC);
	OCI2C_init(OCI2CBASEFE);
	OCI2C_init(OCI2CF1TEST);
	OCI2C_init(OCI2CF2TEST);

	slave_addr = 0x50;	// for FMC1 with GA=00
	print("Menu enabled, use keyboard input\n\r");
	// send control byte (write)
	for (;;){
		setvbuf(stdin, NULL, _IONBF, 0);	// unbuffered stdin to avoid having to hit enter after char
		inputChar = getchar();
		if (inputChar=='a'){
			xil_printf("I2C cores: 1- FMC1-2; 2- FASEC EEPROM; 3- FMC1 TESTER; 4- FMC2 TESTER\n\r");
			setvbuf(stdin, NULL, _IONBF, 0);	// unbuffered stdin to avoid having to hit enter after char
			inputChar = getchar();
			if (inputChar=='2')
				oic_base = OCI2CBASEFE;	// needs slave addr 0x50
			else if (inputChar=='3')
				oic_base = OCI2CF1TEST;
			else if (inputChar=='4')
				oic_base = OCI2CF2TEST;
			else
				oic_base = OCI2CBASEFMC;
			printf("OCI2C core set to %#10x \n\r", (unsigned int)oic_base);
		} else if (inputChar=='r'){
			// read 12 first bytes when addressing EEPROM
			if( oic_base!=OCI2CBASEFE && oic_base!=OCI2CBASEFMC ){
				xil_printf("Incorrect I2C core, ignoring...\n\r");
			} else{
				readAddrH = 0x0;
				xil_printf("-----------------------------------\n\r");
				for (i=0;i<12;i++){
					readVal = readReg_24AA64(oic_base, slave_addr,readAddrH,(u8)i);
					printf("EEPROM register %#06x: %#04x \n\r", (unsigned int)(readAddrH<<8 | i), (unsigned int)readVal);
				}
				xil_printf("-----------------------------------\n\r");
			}
		} else if (inputChar=='s'){
			if (slave_addr==0x50)
				slave_addr=0x52;
			else
				slave_addr=0x50;
			printf("EEPROM slave address now %#04x \n\r", (unsigned int)slave_addr);
		}else if (inputChar=='e'){
			xil_printf("exiting from main..\n\r");
			return 0;
		}else if (inputChar=='t'){
			// FMC1 slot depends on I2C-core selection 'a'
			slave_addr = FT_IC2;
			xil_printf("-----------------------------------\n\r");
			for (i=0;i<4;i++){
				readVal = readReg_mcp23017(oic_base, slave_addr,(u8)i);
				printf("FMC1 MCP23017 register %#04x: %#04x \n\r", (unsigned int)i, (unsigned int)readVal);
			}
			xil_printf("-----------------------------------\n\r");
		}else if (inputChar=='h'){
			xil_printf("-----------------------------------\n\r");
			for (i=0; i<8;i++){
				printf("FASEC HW-TEST core register %#010x: %#010x \n\r", (unsigned int)FHWTEST + (i<<2),
					(unsigned int)readReg(FHWTEST, i));
			}
			xil_printf("-----------------------------------\n\r");
		} else if(inputChar=='w'){
			// FMC1 slot depends on I2C-core selection 'a'
			slave_addr = FT_IC2;
			// enabling 2 LSB outputs (IODIRB)
			writeReg_mcp23017(oic_base, slave_addr,0x01,0xfc);
			// writing counter value
			writeReg_mcp23017(oic_base, slave_addr,0x13,0x00);
			xil_printf("write finished\n\r");
		} else if(inputChar=='c'){
			//TODO: find a faster way to verify all lines
			//TODO: add word 2 and 3, however some high-Z needed!!
			//TODO: stop test if I2C error thrown
			u32 cntr, cntr_min, cntr_max;
			cntr_min = 0xfffff000;
			cntr_max = 0xffffffff;
			xil_printf("starting counter test (%d values, might take a while)...\n\r", cntr_max-cntr_min);
			for (cntr=cntr_min; cntr<cntr_max; cntr++){	// 0-4294967295
				// send lower 16 bits
				slave_addr = FT_IC2;
				// enabling 8 LSB outputs (IODIRB); 8 MSB outputs (IODIRA)
				writeReg_mcp23017(oic_base, slave_addr,0x01,0x00);
				writeReg_mcp23017(oic_base, slave_addr,0x00,0x00);
				// writing 16 LSB counter value
				writeReg_mcp23017(oic_base, slave_addr,0x13,(cntr&0x00ff));
				writeReg_mcp23017(oic_base, slave_addr,0x12,(cntr&0xff00)>>8);
				// send lower 16 bits
				slave_addr = FT_IC1;
				// enabling 8 LSB outputs (IODIRB); 8 MSB outputs (IODIRA)
				writeReg_mcp23017(oic_base, slave_addr,0x01,0x00);
				writeReg_mcp23017(oic_base, slave_addr,0x00,0x00);
				// writing 32-16 bits counter value
				writeReg_mcp23017(oic_base, slave_addr,0x13,(cntr&0x00ff0000)>>16);
				writeReg_mcp23017(oic_base, slave_addr,0x12,(cntr&0xff000000)>>24);
				// sleep for comm and propagation delays
				usleep(1000);
				i = (oic_base==OCI2CF1TEST)?FHWTEST_FMC1:FHWTEST_FMC2;
				if (cntr!=readReg(FHWTEST, i+1))
					printf("counter value sent (I2C) vs read (FPGA): %u vs %u\n\r", cntr, readReg(FHWTEST, i+1));
			}
			xil_printf("write test done, successful if no errors thrown\n\r");
		}
		else{
			xil_printf("Help Menu \n\r");
			xil_printf("--------- \n\r");
			xil_printf("a: change I2C-core address\n\r");
			xil_printf("r: read first 12 bytes from EEPROM \n\r");
			xil_printf("e: exit from main() \n\r");
			xil_printf("s: swap between FMC1-2 EEPROM addresses\n\r");
			xil_printf("t: Tester FMCs, read bytes from IC2\n\r");
			xil_printf("h: Read bytes from FASEC HW-TEST core\n\r");
			xil_printf("w: write to Tester FMCs\n\r");
			xil_printf("c: start Tester FMC line counter validation\n\r");
		}
	}

    cleanup_platform();
    return 0;
}