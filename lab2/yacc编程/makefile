.PHONY: test,clean
test:
	yacc yacc2.y -o yacc2.tab.c
	gcc yacc2.tab.c -o yacc2
	./yacc2
clean:
	rm -fr h.tab.c
