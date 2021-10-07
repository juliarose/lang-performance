import time
import random

start = time.time()
mylist = []

for _ in range(100000):
    mylist.append(random.randint(0, 100000))

mylist.sort()
mapped = map(lambda x : '{:,}'.format(x), mylist)
mylist = list(mapped)
end = time.time()

print(f"{(end-start)*1000}ms")