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
	
	for i := 0; i < 1000000; i++ {
		mylist = append(mylist, rand.Intn(1000000))
	}

	sort.Ints(mylist)
	
	var strings []string
	
	for i := 0; i < 1000000; i++ {
		s, _ := thousands.Separate(mylist[i], "en")
		strings = append(strings, s)
	}
	
	duration := time.Since(start)
	div := float64(1000)
	micros := float64(duration.Microseconds())
	duration_ms := float64(micros / div)
	
	// fmt.Println(duration)
	fmt.Printf("%.3fms", duration_ms) 
}
