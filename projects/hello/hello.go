package main

import (
	"fmt"

	"example.com/greetings"
)

func main() {
	message := greetings.Hello("Ingrid")
	fmt.Println(message)
}
