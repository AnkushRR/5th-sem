#!/bin/bash
flex 2.l
yacc -d 2.y 
gcc lex.yy.c y.tab.c -ll -lm 
./a.out
  
