#!/bin/bash
flex raj.l
yacc -d raj.y 
gcc lex.yy.c y.tab.c -ll -lm 
./a.out
  
