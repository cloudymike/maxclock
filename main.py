
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

def isDST(month, day, wday):
	mywday=(wday+1) %7

	if month>3 and month<11:
		dst=True
	elif month==3 and (day-mywday)>7:
		dst=True
	elif month==11 and (day-mywday)<0:
		dst=True
	else:
		dst=False

	return(dst) 


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

# Offset in seconds for current timezone from UTC
# st, standard time ds, daylights saving
stoffset = -28800
dsoffset = -25200

# bootstrap with standard time
year,month,day,hour,minute,second,dow,dummy2 = time.localtime(time.time()+stoffset)
if isDST(month,day,dow):
	tzoffset = dsoffset
else:
	tzoffset = stoffset

screen.brightness(6)

#dummy startup values
oldMinute=66
oldSecond=66

while True:
	year,month,day,hour,minute,second,dow,dummy2 = time.localtime(time.time()+tzoffset)
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
		#brightness=math.floor(value/256)
		brightness=math.floor(value/512)
		screen.brightness(brightness)
		secondDisplay(screen, second)

		# Do housekeeping at 2am
		if ((hour==2) and (minute==0) and (second==0)):
			try:
				ntptime.settime()
			except:
				pass

			if isDST(month,day,dow):
				tzoffset = dsoffset
			else:
				tzoffset = stoffset


	oldSecond = second
	oldMinute = minute
	time.sleep_ms(100)

