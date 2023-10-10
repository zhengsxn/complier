.PHONY: test-fac,test-fib,clean
test-fac:
	arm-linux-gnueabihf-gcc fac.s -o fac.out
	qemu-arm -L /usr/arm-linux-gnueabihf ./fac.out
test-fib:
	arm-linux-gnueabihf-gcc fib.s -o fib.out
	qemu-arm -L /usr/arm-linux-gnueabihf ./fib.out
clean:
	rm -fr *.out
