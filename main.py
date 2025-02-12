
import machine
import max7219
import time
import ntptime
import wlan

def secondDisplay(screen, second):
	if second<30:
		screen.pixel(int(second),7,1)
	else:
		screen.pixel(int(second-30),7,0)
	screen.show()


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


screen.brightness(6)

#dummy startup values
oldMinute=66
oldSecond=66

while True:
	year,month,day,hour,minute,second,dummy1,dummy2 = time.localtime(time.time()+tzoffset)
	if oldMinute != minute:
		screen.fill(0)
		screen.text(str(hour), -1, 0, 1)
		screen.text(str(minute),16,0,1)
		screen.pixel(15,2,1)
		screen.pixel(15,5,1)
		screen.show()

	if oldSecond != second:
		secondDisplay(screen, second)
	oldSecond = second
	oldMinute = minute
	time.sleep_ms(100)

