
import machine
import max7219
import time
import ntptime
import wlan
import math

def secondDisplay(screen, second):
	if second<30:
		screen.pixel(second+1,7,1)
	else:
		screen.pixel(second-29,7,0)
	screen.show()


# Initialize ADC (Analog to Digital Converter)
adc = machine.ADC(machine.Pin(36))  # The ESP32 pin GPIO36 (ADC0) connected to the light sensor
# Set the ADC width (resolution) to 12 bits
adc.width(machine.ADC.WIDTH_12BIT)
# Set the attenuation to 11 dB, allowing input range up to ~3.3V
adc.atten(machine.ADC.ATTN_11DB)

#Initialize the display
spi = machine.SPI(1, baudrate=10000000)
screen = max7219.Max7219(32, 8, spi, machine.Pin(15))
screen.fill(0)
screen.show()


mynetwork = wlan.do_connect('bigclock')
ip=mynetwork.ifconfig()
myip=ip[0]
screen.text(myip[-4:],0,0,1)
screen.show()
time.sleep(3)

rtc = machine.RTC()
try:
    ntptime.settime()
except:
    pass

tzoffset = -28800
#zoffset = 0


screen.brightness(6)

#dummy startup values
oldMinute=66
oldSecond=66

while True:
	year,month,day,hour,minute,second,dummy1,dummy2 = time.localtime(time.time()+tzoffset)
	hour12 = 12 if (hour%12)==0 else hour%12
	if oldMinute != minute:
		screen.fill(0)
		screen.text("{0:>2}".format(hour12), -1, 0, 1)
		screen.text("{:02d}".format(minute),16,0,1)
		screen.pixel(15,2,1)
		screen.pixel(15,5,1)
		screen.show()

	if oldSecond != second:
		value = adc.read()  # Read the 12-bit ADC value directly
		brightness=math.floor(value/256)
		screen.brightness(brightness)
		secondDisplay(screen, second)

	# Do housekeeping at 2am
	if ((hour==2) and (minute==0) and (second==0)):
		try:
			ntptime.settime()
		except:
			pass


	oldSecond = second
	oldMinute = minute
	time.sleep_ms(100)

