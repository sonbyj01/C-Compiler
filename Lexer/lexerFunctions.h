/* Andrew Lorber & Henry Son */
/* Compilers - Lexical Analyzer */
/* Helper Functions Header File */

#ifndef LEXERFUNCTIONS_H
#define LEXERFUNCTIONS_H

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>

// Creates / begins string
void create_string();

// Adds chars to string
void append_string(char *text);

// Adds escape characters to string
void append_escape(char* text, int base);

// Completes String
void complete_string();

// Prints String
void print_string();

// Prints error message
void warn_error_message(char *filename, int line, char *message, char *type);



#endif // LEXERFUNCTIONS_H