import time


def findDst(timeS):

	(year,month,day,hour,minute,sec,wday,doy,dummy3) = time.localtime(timeS)
	return(findDST(month,day,wday))

def findDST(month, day, wday):
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




hour=3600
day=24*hour
tzoffset = -28800

curT=time.time()+tzoffset
ts = time.localtime(curT)

print(ts)
print(findDst(curT))

newT=curT+3*hour
print(time.localtime(newT))

after=(2025, 3, 9, 4, 1, 1, 6, 68, 0)
afterT=time.mktime(after)
print(time.localtime(afterT))
print(findDst(afterT))

summer=(2025, 6, 4, 15, 1, 1, 2, 0, 0)
summerT=time.mktime(summer)
print(time.localtime(summerT))
print(findDst(summerT))

winter=(2025, 12, 24, 15, 1, 1, 2, 0, 0)
winterT=time.mktime(winter)
print(time.localtime(winterT))
print(findDst(winterT))

novaf=(2025, 11, 2, 15, 1, 1, 6, 0, 0)
novafT=time.mktime(novaf)
print(time.localtime(novafT))
print(findDst(novafT))

novbe=(2025, 11, 1, 15, 1, 1, 5, 0, 0)
novbeT=time.mktime(novbe)
print(time.localtime(novbeT))
print(findDst(novbeT))

