# Enhanced Calculator with Lex and Yacc

This project implements a calculator that can evaluate arithmetic expressions using Lex for tokenization and Yacc for parsing. It includes support for floating-point numbers, exponentiation, and improved error reporting.

## Features

- Supports basic arithmetic operations: addition, subtraction, multiplication, and division
- Handles parentheses for expression grouping
- Supports floating-point numbers
- Supports exponentiation with both `^` and `**` operators
- Provides enhanced error handling and reporting
- Supports negative numbers

## Design Decisions

1. **Lexical Analysis**: The Lex specification (calculator.l) defines patterns for floating-point numbers, operators, and parentheses.
2. **Parsing**: The Yacc specification (calculator.y) defines grammar rules for arithmetic expressions.
3. **Operator Precedence**: Exponentiation has the highest precedence, followed by multiplication/division, then addition/subtraction.
4. **Error Handling**: The calculator provides detailed error messages with line numbers and error recovery.
5. **Floating-Point**: All calculations are performed using double precision floating-point.

## Building and Running

### Prerequisites

Make sure you have the following installed:
- flex (Lex)
- bison (Yacc)
- gcc
- make

### Running 
Use lex calculator.l to generate the Lex source code.
o Use yacc -d calculator.y to generate the Yacc source code.
**. Do not forget to add -lm to compile script .**
Compile the C code produced by Lex and Yacc with: gcc lex.yy.c y.tab.c -o calculator -lm

### Building
To build the calculator, run: ./calculator

### İf running steps do not work properly create a Makefile that contains:
CC = gcc
CFLAGS = -Wall

calculator: lex.yy.c y.tab.c
	$(CC) $(CFLAGS) -o calculator lex.yy.c y.tab.c -lfl -lm

lex.yy.c: calculator.l y.tab.h
	flex calculator.l

y.tab.c y.tab.h: calculator.y
	yacc -d calculator.y

clean:
	rm -f calculator lex.yy.c y.tab.c y.tab.h




