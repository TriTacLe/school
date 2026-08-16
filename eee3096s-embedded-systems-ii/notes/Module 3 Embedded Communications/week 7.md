---
type: note
status: active
project: uct
course: EEE3096S
tags: [uct, embedded, stm32, course]
---
## L13a ES communications 1
### Intro to embedded communications
**Embedded Systems Communication Definition**
- An embedded system is a task-specific computer built into a larger system for controlling and monitoring
- Microcontroller or microprocessor is one part of that larger system
- Micros must interact with the larger system and the physical world
- This interaction occurs through wired and wireless interfaces
- Trade-off exists at every protocol level: power cost, range/distance, bandwidth, complexity

**Device-to-Cloud/Server/Other Device Communication**
- IoT devices connect to internet via multiple protocols
- Short range/distance: WiFi, Bluetooth, Zigbee, NFC, RFID
- Long range: LTE, 5G, LoRa
- Local networking: TCP/IP, CAN

**IC to IC, Sensor to Daughterboard Communication**
- I2C: common on-board protocol
- SPI: common peripheral communication
- CAN: automotive and industrial networks
- PWM and custom protocols for specific hardware

**Within a Microcontroller Hardware Module**
- Wishbone bus, Avalon, custom interconnects
- Handles communication between cores and peripherals
### View of Wired ES Comms Interface
**Classification Hierarchy**
- Wired Embedded Communication splits into:
  - Parallel: multiple bits sent in parallel
  - Serial: 1 bit sent at a time
- Serial splits into:
  - Asynchronous (no clock): 1-wire, CAN, USB, RS232
  - Synchronous (clocked): SPI, I2C, JTAG, SWD
- Focus in course: UART/RS232, SPI, I2C
### Parallel vs Serial Communications
**Parallel Interface Example**
- Multiple data lines (D0-D7 for 8 bits)
- Transmitting side sets all bits simultaneously
- Receiving side reads all bits at once
- Data transfer is 8 bits (or multiple bytes) in one time unit

**Serial Interface Example (MSB First)**
- Single data line transmits bits one at a time
- Bits sent sequentially: D7 (MSB), D6, D5, D4, D3, D2, D1, D0 (LSB)
- Requires coordination on timing

**Comparison: Parallel vs Serial**
- Parallel: multiple wires, simultaneous transmission, fast but complex
- Serial: one wire, sequential transmission, slower but simpler
- Serial may use full-duplex (simultaneous send/receive on different lines) or half-duplex (shared line)
### Wired Comms Endianness
**Endianness Definition**
- Order or sequence of bytes of a word of digital data in computer memory or in data transmission

**Big-Endian (BE)**
- Most Significant Byte (MSB) stored at smallest memory address
- Least Significant Byte (LSB) stored at largest address
- Example: 32-bit 0x0A0B0C0D stored as 0x0A at address a, 0x0B at a+1, 0x0C at a+2, 0x0D at a+3

**Little-Endian (LE)**
- LSB stored at smallest memory address
- MSB stored at largest address
- Example: 32-bit 0x0A0B0C0D stored as 0x0D at address a, 0x0C at a+1, 0x0B at a+2, 0x0A at a+3

**For Data Transmission**
- Big-Endian: MSB transmitted first
- Little-Endian: LSB transmitted first

**Endian Examples**
- Big-Endian: Address 0x00=0x12, 0x01=0x34, 0x02=0x56, 0x03=0x78 (MSB 0x12 first)
- Little-Endian: Address 0x00=0x78, 0x01=0x56, 0x02=0x34, 0x03=0x12 (LSB 0x78 first)

**Endian Use Cases**
- Big-Endian Systems: older Motorola 68k, SPARC (Sun/Oracle), IBM PowerPC, game consoles (PS3, Xbox 360)
- Little-Endian Systems: Intel x86/x86-64, AMD processors, ARM, RISC-V (default)
- Networking Protocols: TCP/IP, IPv4/IPv6 always use big-endian (network byte order)
- Modern Systems: ARM runs little-endian by default, most laptops and phones are little-endian
### ES Wired Comms: Asynchronous
**Asynchronous Definition**
- Un-clocked: no separate clock signal
- Devices agree beforehand on how long it takes to transmit 1 bit
- Actions/decisions based on elapsed time, not a clock edge

**Timing Coordination**
- Two devices agree on transmission time per bit (baud rate)
- No external clock needed, timing encoded in data symbols

**Transmission Example**
- Device A sends 16-bit data to Device B
- No clock line, just data line
- Devices sample at agreed intervals

**Formal Definition**
- In telecommunications, transmission of data without an external clock signal
- Timing required to recover data is encoded within the symbols themselves
- Data can be transmitted intermittently rather than continuously
- Any timing required is encoded within the communication symbols
### ES Wired Comms: Synchronous
**Synchronous Definition**
- Clocked: separate clock signal used
- Clock synchronizes transmitter and receiver
- Actions/decisions occur on clock edge (rising or falling)

**Transmission Mechanism**
- Master device generates clock signal
- Transmitter sends data on one edge (rising or falling)
- Receiver samples data on defined edge (rising or falling)
- Both devices synchronized to same clock

**Timing Coordination**
- Clock edges provide unambiguous timing reference
- Eliminates timing recovery complexity
- Both devices must use same clock rate

**Synchronous Transmission Definition**
- Clocks in transmitting and receiving devices synchronized
- Running at same rate so receiver samples at correct time intervals
- No start/stop bits needed
- Signal is used to interpret timing
### Sampling on an Edge
**Edge-Triggered Sampling**
- Data valid when clock signal transitions
- Falling edge clock: sample when clock goes from high to low
- Rising edge clock: sample when clock goes from low to high
- Protocol specifies which edge triggers sampling

**Data Stability**
- Data line stable before clock edge
- Data captured at instant of clock edge
- Data may change after edge (old value used for that sample)

**Protocol Specification**
- Must specify if protocol is rising-edge or falling-edge triggered
- Different protocols use different edge conventions
- Critical for correct communication

**Exam Question Hint**
- Rising vs falling edge sampling produces different results
- Noise and timing jitter affect sampling reliability
- Protocol definition must specify edge behavior
### Wired Comms: Simplex vs Duplex
**Simplex**
- One-directional communication only
- One device transmits, other receives
- Cannot transmit and receive simultaneously
- Example: broadcast TV transmission

**Half-Duplex**
- Bidirectional communication but not simultaneous
- Transmit and receive share same data line
- One device transmits, other receives, then roles reverse
- Takes turns, only one direction at a time

**Full Duplex**
- Bidirectional simultaneous communication
- Separate data lines for transmit (Tx) and receive (Rx)
- Both devices can transmit and receive at same time
- More complex but higher throughput
### Parity Bit and Checking
**Parity Bit Definition**
- Single bit added to a string of binary code to provide low-cost error detection
- Usually applied to smallest transmission unit (e.g. single byte)

**Even Parity**
- Sum of '1's in data including parity bit must be even number
- Example: 7-bit data word with 4 ones, even parity bit = 0, final 8-bit = 0xE5 with parity 0 makes total ones even

**Odd Parity**
- Sum of '1's in data including parity bit must be odd number
- Example: 7-bit data word with 4 ones, odd parity bit = 1, final 8-bit includes parity to make total ones odd

**Parity Table Example**
- 7-bit word 1010101 (4 ones), even parity bit = 0 (total 4 ones, even), odd parity bit = 1 (total 5 ones, odd)
- 7-bit word 1111111 (7 ones), even parity bit = 1 (total 8 ones, even), odd parity bit = 0 (total 7 ones, odd)
- 7-bit word 0000000 (0 ones), even parity bit = 0 (total 0 ones, even), odd parity bit = 1 (total 1 one, odd)
- 7-bit word 1001111 (5 ones), even parity bit = 1 (total 6 ones, even), odd parity bit = 0 (total 5 ones, odd)
### ES Wired Comms Summary
**Protocol Classification**
- Wired embedded communication tree: Parallel vs Serial, Asynchronous vs Synchronous, various standards at bottom level
- Advantages of Parallel: easy to use, no decoding hardware needed
- Disadvantages of Parallel: excess signal count, lower bandwidth due to timing skew
- Advantages of Serial: fewer lines, less PCB real estate, cheaper, smaller connectors
- Disadvantages of Serial: costs decoding hardware and cycles

**Serial Standards Covered**
- UART/RS232 (similar but wiring/voltages specific for RS232)
- Serial Peripheral Interface (SPI)
- Inter-Integrated Circuit (I2C)
- Plus JTAG, SWD for debugging

**Other Interfaces**
- Displays: HDMI, DVI
- Drives: SATA
- Thunderbolt, PCI-Express
- Wireless: many options
## L13b ES communications 2 I2C
### I2C Protocol Overview
**I2C Definition**
- Inter-Integrated Circuit, aka "eye squared C"
- Communication protocol invented by Philips Semiconductor in 1989
- Half duplex (both ends can send but not simultaneously)
- Serial (bits sent sequentially one at a time)
- Synchronous (uses shared clock)
- Simple, robust, low cost
- Easy to use when communication needed between chain of devices and microprocessor/microcontroller

**Wiring**
- Two wires only: SDA (Serial Data Line) and SCL (Serial Clock Line)
- SDA: state changes when SCL is low
- Pull-up resistors (typically 4.7k) keep lines high when idle
- Open-drain collectors: active pulling low, passive release to high

**Multiple Master/Slave Support**
- Supports multiple masters and multiple slaves
- Widely used for short distance on-board/nearby off-board comms
- Applications: RTC, temperature sensors, ADC, EEPROM

**Speed Modes**
- Standard mode: 100 kbit/s
- Fast mode: 400 kbit/s
- High speed: 3.4 Mbit/s

**Built-in Verification**
- Send-Acknowledge (ACK) signal is standard after every byte
- Receiver pulls SDA LOW to acknowledge reception
- Allows master to know if slave received data

**Address Byte Standardization**
- Address: 7-bit value, 10-bit value possible (rare)
- Standard modes: 100 kbit/s, fast mode: 400 kbit/s, high speed: 3.4 Mbit/s

**Hardware Configuration Details**
- Some bits of address set in hardware (PCB traces)
- Others defined by IC device itself
- Allows multiple same-chip devices on same bus
- Address assignment example: A2, A1, A0 held to ground = address 0x00, A6-A5-A4-A3 set by IC
### I2C Protocol Sequence
**Idle State**
- SDA and SCL signals HIGH (default state)
- No data transmission occurring

**Start Command**
- SDA transitions from HIGH to LOW while SCL is HIGH
- Pulling low is an active action
- Indicates master taking control

**Read Operation**
- Transmitter leaves SDA HIGH (logic 1) after address
- Data line remains high for read operation
- Slave releases control, allowing pull-up to keep line high

**Write Operation**
- Transmitter pulls SDA LOW (logic 0) after address
- Data line pulled low for write operation

**Acknowledge (ACK)**
- Receiver actively pulls SDA LOW
- Confirms reception of byte
- If address invalid, line left high by all = NACK (not acknowledge)

**Not Acknowledge (NACK)**
- Receiver doesn't pull SDA LOW
- Defaults to HIGH via pull-up resistor
- Master recognizes no slave responded
### I2C Protocol: Master Writes to Slave
**Idle State**
- SDA and SCL HIGH

**Start Command**
- Master transmits Start: SDA pulled LOW while SCL is high by master

**Slave Address Transmission**
- Master transmits 7-bit Slave address to indicated which slave should listen
- Address transmission shown in diagram: S A6 A5 A4 A3 A2 A1 A0

**Write Bit**
- Master transmits Write bit: SDA pulled LOW for 1 bit by master (R/W=0)

**Data Transmission**
- Master transmits 8-bits of data normally, address byte shown as separate frame
- Two 8-bit data bytes transmitted

**Acknowledge (ACK)**
- Receiving Slave (addressed) transmits ACK: SDA is actively pulled LOW for 1 bit by addressed slave
- All other slaves leave line high
- If address was invalid line is left high by all = NACK

**ACK Timing Details**
- SDA pulled LOW to acknowledge transmission
- Master waits for slave ACK after address byte and after each data byte

**Stop Command**
- Master transmits Stop: SDA transitions from LOW to HIGH while SCL is high
- Release control of line

**Example Sequence Details**
- Start, Address (7 bits), R/W bit (0 for write), ACK, Data byte 1 (8 bits), ACK, Data byte 2 (8 bits), ACK, Stop
- Diagram shows gray blocks where master drives, white blocks where slave drives
### I2C Arbitration and Clock Stretching
**Arbitration Definition**
- With multiple masters on bus, each monitors for idle (both lines high) and only uses bus when free
- If two masters attempt to use bus simultaneously, first to pull SDA low while trying to transmit '0' wins
- Other master backs off

**Arbitration Mechanism**
- Each master tries to transmit
- Monitors SDA line
- If SDA should be high but reads low, another master is transmitting
- Back off immediately and retry later

**Clock Stretching Definition**
- Any device can hold SCL low if device wishes to slow the clock
- If device needs more time to process, simply holds SCL low longer than is otherwise anticipated

**Clock Stretching Use**
- Slave can hold CLK low to reduce frequency
- Allows slower slave to keep up with faster master
- Master waits when SCL held low
### I2C Hardware
**I2C Interface Pins**
- Open drain collector on both clock and data pins
- A 4.7k is a standard recommendation for pull-up resistors to use
- Bus signals always default to logic high and so must be actively pulled low for operation
- If a device dies the lines will return high and be available for other devices to continue functioning
- If needed a slave can hold the clk low to reduce frequency
- Different VCCs on the same lines can exist (provided other devices can tolerate highest level)

**Pull-up and Pull-down Resistors**
- Pull-up resistors remove chance of floating/undefined values
- Some ICs include pull-up/down internally (check datasheet)
- Resistor value depends on pin impedance and leakage current
### Recap: Integrated Circuit Input/Outputs
**Digital Logic Levels**
- Digital logic can be High/Low/Floating
- Pull-up resistors default to high (connected to VCC)
- Pull-down resistors default to low (connected to GND)
- Floating (undefined) removed by resistor creating known state

**Pull-up Resistor Circuit**
- Connected between pin and VCC
- When pin is high impedance (not driven), resistor pulls to VCC
- When pin actively pulled low, resistor provides return path

**Pull-down Resistor Circuit**
- Connected between pin and GND
- When pin is high impedance, resistor pulls to GND
- When pin actively pulled high, resistor provides return path

**Resistor Value Selection**
- Depends on pin impedance and leakage current
- Larger resistor = less current draw, slower transitions
- Smaller resistor = more current draw, faster transitions
### I2C in Context
**Key Disadvantages**
- Frame overhead (address and ACK bits) costs time
- Hardware complexity increases as master/slave devices are added

**Key Advantages**
- Only 2 wires
- ACK facilitates reliable operation
- Easy support for multiple Vdd levels (assuming all ICs can tolerate highest level)
## L14 ES communications 3
### SPI Protocol Overview
**SPI Definition**
- Serial Peripheral Interface
- Communication protocol developed by Motorola (Freescale) in 1979
- Full duplex (both ends can send and receive simultaneously)
- Serial (bits sent sequentially)
- Synchronous (uses a shared clock)
- Faster than I2C, but slightly more complex
- Requires more lines than I2C
- Supports multiple slave devices on same bus with single master

**Key Characteristics**
- No Start/Stop commands or addressing, instead dedicated slave select line used
- No Start/Stop bits or addressing, instead a dedicated slave select line is used
- Supports multiple slave devices on same bus with a single master

**Also Used On**
- On PCBs and between nearby chips (only works over short distances)
- Applications: ADC, temperature sensor, RTC, SD card, EEPROM
### SPI Overview: Interface Lines
**Required Lines**
- SCLK: Clock generated by master
- MOSI: Master Out Slave In
- MISO: Master In Slave Out
- ISS: Slave Select, active low (hence !SS to indicate active low)

**Operation**
- Master-generated CLK moves data onto the data transfer lines (MOSI, MISO) and from/into the end point shift registers simultaneously
- Master-generated CLK moves data onto MOSI and MISO from/into the shift registers

**Shift Register Operation**
- Master-generated CLK moves data from shift register bits
- Both MOSI and MISO data lines transfer data simultaneously (full duplex)
### SPI Protocol
**State Diagram (Top) and Signal Behavior (Bottom)**
- Idle state: SCLK not transitioning, ISS is high
- Start command: SS goes low to enable slave
- Control and data bits: clock cycles move data on MOSI and MISO
- Stop command: SS high to disable slave
- Idle state: SCLK does not transition, ISS is high

**Three Simple Parts**
1. Idle state: SCLK not switching, ISS HIGH
2. ISS pulled LOW: starts data transfer from 1st clk edge (rising or falling depending on mode)
3. ISS going HIGH: disables any slaves and stops data movement

**Implementation Details**
- SCLK does not transition and ISS is high in idle
- SS goes low to enable slave
- Control and data bits transferred with clock cycles
- SS high to disable slave, SCLK does not transition and ISS is high
### Example Transmission in SPI
**Read Waveform (Figure 7-1)**
- CS line pulls low to enable slave
- SCK provides clock (number 0-31 shown below waveform)
- SI shows input data (control opcode 03h then address bits A15-A0)
- SO shows output data (high impedance initially then data byte 1 shown as bits MMSB to LLSB)
- Timing diagram shows exact bit sequence and timing
### SPI Protocol Clock Phase (CPHA) Settings
**Clock Phase (CPHA)**
- Determines at which edge the data is sampled
- CPHA = 1 (rising edge): data sampled on first clock edge (rising)
- CPHA = 0 (falling edge): data sampled on second clock edge (falling)

**Clock Polarity (CPOL)**
- Determines idle state of clock line
- CPOL = 0 (Low): clock idles low
- CPOL = 1 (High): clock idles high

**CPHA and CPOL Combinations**
- Mode 0 (CPOL=0, CPHA=0): Clock idles low, data sampled on rising edge
- Mode 1 (CPOL=0, CPHA=1): Clock idles low, data sampled on falling edge
- Mode 2 (CPOL=1, CPHA=0): Clock idles high, data sampled on falling edge
- Mode 3 (CPOL=1, CPHA=1): Clock idles high, data sampled on rising edge

**Waveform Examples**
- Falling edge clock with data sampled on first (rising) edge: shows clock starting low, data valid at rising edges
- Rising edge clock with data sampled on second (falling) edge: shows clock starting high, data valid at falling edges
- Diagram shows exact timing for both modes with MOSI/MISO data lines
### SPI Modes
**CPHA Clock Phase**
- Determines at which edge data is sampled
- CPHA = 1 (rising edge): data sampled on first clock edge
- CPHA = 0 (falling edge): data sampled on second clock edge

**CPOL Clock Polarity**
- Determines idle state of clock line
- CPOL = 0 (Low): clock idles low
- CPOL = 1 (High): clock idles high

**Falling Edge Default**
- Towards the default
### SPI: Multiple Slaves
**Typical SPI Bus Configuration**
- One master with multiple slaves
- Each slave has independent ISS (slave select) line
- Master can select one slave at a time
- SCLK, MOSI, MISO shared among all slaves
- In this configuration each new slave requires an additional ISS line
- Example: Master and three slaves, requiring separate SS1, SS2, SS3 lines

**Daisy-Chained SPI Bus**
- Master and cooperative slaves
- Each slave forwards MOSI input to MISO output on next SCLK
- Allows more devices connected with fewer cables
- Trades line count for more complex shifting logic
- Can allow for more devices connected up with shorter cables but catch is higher complexity and is not standard for all devices
### SPI in Context
**Key Disadvantage**
- Only 1 master possible
- If independent access to many slaves required the number of ISS lines quickly grows

**Key Advantages**
- No overhead of addressing and start/stop/ACK
- Full duplex
- Higher speed than I2C
## L14 ES communications 3 (continued)
### UART
**What is Meant by UART**
- Universal Asynchronous Receiver Transmitter (UART) refers to generic hardware interface Tx/Rx control module, not to a protocol
- UART is hardware interface used to control RS232 protocol (and similar)
- Could be an underlying driver for other protocols

**Simplest Implementation**
- It is simply 1 bit sent per protocol

**UART Connection Example**
- Device A UART with Tx and Rx, Device B UART with Rx and Tx connected to each other
- Each device has its own baud rate (should match)
- Simple point-to-point connection
### UART and RS232
**RS-232 Definition**
- Asynchronous serial communication interface standard
- Introduced in 1960 for serial communication transmission of data
- Formally defines signals connecting between DTE (data terminal equipment) such as computer, and DCE (data circuit-terminating equipment) such as modem
- Has 25 and 9 pin connector options (25 pin ver. seldom used, few benefits over 9 pin)

**Connection Process**
- UART module in microcontroller controls RS232 lines via UART
- Adding voltage conditioning (MAX232) converts UART 0-3.3V levels to RS232 +3V to -12V levels
- Necessary for longer distance communication and noise immunity

**RS-232 Standard Voltage Levels**
- Logic 1: -3V to -15V (negative voltage)
- Logic 0: +3V to +15V (positive voltage)
- Inverted from typical TTL logic

**RS-232 Speeds**
- 1.2 kbps, 2.4 kbps, 4.8 kbps, 9.6 kbps, 14.4 kbps, 19.2 kbps, 115.2 kbps
- RS232 originally intended for bit rates lower than 20 kbps
- Kept going and still useable way beyond that

**Limitations**
- Supports only one transmitter and one receiver on communication bus
- Allows data transfer for distances less than 15m
- Signal lines (tx and rx) are referenced w.r.t ground and performance degrades quickly when there is noise present
- Allows rather limited speed of data transfer (especially for lengths beyond about 1m)
### UART and RS-232 Connectors
**DB9 (D-Subminiature 9-pin) Connector**
- Standard connector for RS-232 serial communications
- Two variants: DB9-F (female) and DB9-M (male)
- 9-pin configuration common on legacy equipment

| Pin# | Signal | Function |
|------|--------|----------|
| 1 | DCD | Data Carrier Detect (modem to DTE) |
| 2 | RX | Receive Data (input) |
| 3 | TX | Transmit Data (output) |
| 4 | DTR | Data Terminal Ready (DTE to modem) |
| 5 | GND | Ground (signal reference) |
| 6 | DSR | Data Set Ready (modem to DTE) |
| 7 | RTS | Request To Send (DTE to modem) |
| 8 | CTS | Clear To Send (modem to DTE) |
| 9 | RI | Ring Indicator (modem to DTE) |

**Essential Connections**
- Minimum functioning setup: TX, RX, GND (3 wires)
- Full handshaking adds DTR, DSR, RTS, CTS control lines
- 25-pin RS-232 connector also exists but rarely used (few advantages over 9-pin)
### RS-485
**What is RS-485**
- Enhanced version of RS-232
- Electrical interface standard
- Also usually uses UART hardware interface to drive the data exchange
- RS-485 was developed to overcome limitations of RS-232

**RS-232 Limitations Addressed**
- Supports only one transmitter and one receiver on communication bus
- Allows data transfer for distances less than 15m
- Signal lines referenced w.r.t ground, performance degrades in noise
- Limited speed of data transfer

**How is RS-485 Different to RS-232**

1. Tri-State Differential Line Driver
- RS-485 uses tri-state differential line driver to provide three states:
- Logic low: +1.5V to +6V
- Logic high: +1.5V to +6V
- High impedance: Not connected
- Advantage of this adjustment: allows multiple devices on same bus

2. Differential Signaling
- Uses differential signaling on two lines rather than single-ended with voltage referenced to ground
- One line has negative voltage or complementary signal of other line
- Receiver amplifies difference between two signals
- Makes RS-485 more noise immune than RS-232

3. Twisted Pair Cable
- Recommended to use twisted pair cable to transmit RS-485 signals
- Twisted pair minimizes gap between two wires, minimizes noise picked up by both wires and improves noise immunity
- Diagram shows twisted pair cable connecting RS485 boards with D+/D- lines and separate return lines
- Component of half duplex RS-485 network

4. Multiple Transmitters and Receivers
- Supports up to 32 transmitters and 32 receivers on one communication bus
- All receivers fully connected to communication bus
- Line drivers disconnected or put in high impedance state when not transmitting
- Communication bus line terminated in load matching resistance to minimize signal reflections

**RS-485 Network Configuration**
- Shows multiple receivers (R) and transmitters/drivers (D) connected to two-wire bus
- Bus terminated at end with resistance
- Multiple nodes can be on bus simultaneously
- Line termination minimizes reflections
### RS-485 versus RS232 Summary
| Parameter | RS232 | RS485 |
|-----------|-------|-------|
| Cabling | Single-ended | Differential |
| Numbers of devices | 1 transmitter 1 receiver | 32 transmitters 32 receivers |
| Mode of operation | Simplex or full duplex | Simplex or half duplex |
| Maximum cable length | 50 feet | 4000 feet |
| Maximum data rate | 20 kbits/s | 10 Mbits/s |
| Signaling | Unbalanced | Balanced |
| Typical logic levels | ±5 to ±15V | ±1.5 to ±6V |
| Minimum receiver input impedance | 3-7kOhm | 12kOhm |
| Receiver sensitivity | ±3V | ±200mA |
### RS-485 Applications
**Where is RS-485 used**
- Commercial aircraft cabins
- Building automation
- Connecting electrical meters
- Industrial control systems
- Security electronics
- Example diagram shows host connected via converter to multiple terminals on RS-485 network
## References
[1] Endianness
https://en.wikipedia.org/wiki/Endianness

[2] Parallel communication
https://en.wikipedia.org/wiki/Parallel_communication

[3] Classification of Embedded Systems with Applications
https://www.watelectronics.com/classification-of-embedded-systems/

[4] Importance of IoT in Education
https://ilmversity.com/importance-of-iot-in-education/

[5] Raspberry Pi Zero WH, built-in WiFi, presoldered headers
https://www.waveshare.com/raspberry-pi-zero-wh.htm

**Suggested Further Reading**

Understanding the I2C Bus (Texas Instruments application note)
https://www.ti.com/lit/an/slva704/slva704.pdf

Serial Peripheral Interface (wikipedia)
https://en.wikipedia.org/wiki/Serial_Peripheral_Interface

Resolving I2C Address Conflicts
https://embeddedartistry.com/blog/2021/08/02/resolving-i2c-address-conflicts/
(This consolidates I2C understanding and awareness of advantages and drawbacks of I2C addressing)

STM32F0 MINI TUTORIAL - USING THE I2C (in C)
MikroC SPI Library (shows some STM code examples but these are more direct H/W register access, gives a view of what happens within STM32CubeIDE HAL layer)
