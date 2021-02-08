/* Andrew Lorber & Henry Son */
/* Compilers - Lexical Analyzer */
/* Helper Functions Header File */

#ifndef LEXERFUNCTIONS_H
#define LEXERFUNCTIONS_H

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <ctype.h>

// Creates / begins string
void create_string();

// Adds chars to string
void append_string(char *text);

// Adds escape characters to string
void append_escape(char* text, int base);

// Completes string
char* complete_string();

// Prints string
void print_string(char *string);

// Prints error message
void print_error(char *filename, int line_num, char* text, char* message);

#endif // LEXERFUNCTIONS_H