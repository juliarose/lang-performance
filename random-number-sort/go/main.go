package main

import (
	"fmt"
	"math/rand"
	"sort"
	"time"
	"github.com/floscodes/golang-thousands"
)

func main() {
	start := time.Now()

	var mylist []int

	for i := 0; i < 100000; i++ {
		mylist = append(mylist, rand.Intn(100000))
	}

	sort.Ints(mylist)
	
	var strings []string
	
	for i := 0; i < 100000; i++ {
		s, _ := thousands.Separate(mylist[i], "en")
		strings = append(strings, s)
	}
	
	fmt.Println(strings[99999])
	duration := time.Since(start)

	fmt.Println(duration)
}
