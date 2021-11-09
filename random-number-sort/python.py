import time
import random

start = time.time()
mylist = []

for _ in range(1000000):
    mylist.append(random.randint(0, 1000000))

mylist.sort()
mapped = map(lambda x : '{:,}'.format(x), mylist)
mylist = list(mapped)
end = time.time()

print(f"{round((end-start)*1000, 3)}ms")
