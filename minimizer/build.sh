#!/bin/sh

rm -f minimizer lex.yy.c
flex min.l
gcc -o minimizer lex.yy.c
minimizer test_input.js
