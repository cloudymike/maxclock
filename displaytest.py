
from machine import Pin, SPI
import max7219
from time import sleep
import gfx



spi = SPI(1, baudrate=10000000)
screen = max7219.Max7219(32, 8, spi, Pin(15))


print("fill0")
screen.fill(0)
screen.show()
sleep(1)


screen.text('2',-1,0,1)
screen.show()
sleep(1)

for level in range(12):
	screen.fill(0)
	screen.brightness(level)
	screen.text(str(level),0,0,1)
	screen.show()
	sleep(1)

print("numbers")
screen.brightness(8)
screen.fill(0)
screen.text('1234', 0, 0, 1)
screen.show()
sleep(1)

print("whipe and text")
screen.fill(0)
screen.text('ABCD', 0, 0, 1)
screen.show()
sleep(1)

screen.fill(0)
graphics = gfx.GFX(32, 8, screen.pixel)
graphics.fill_circle(16, 4, 3, 1)
screen.show()
sleep(1)

screen.brightness(8)
screen.fill(0)
screen.text(' 9', -1, 0, 1)
screen.text('23',16,0,1)
screen.pixel(15,2,1)
screen.pixel(15,5,1)
screen.show()
sleep(1)
for number in range(30):
	screen.pixel(number+1,7,1)
	screen.show()
	sleep(1)
for number in range(30):
	screen.pixel(number+1,7,0)
	screen.show()
	sleep(1)

