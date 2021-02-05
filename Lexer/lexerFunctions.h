/* Andrew Lorber & Henry Son */
/* Compilers - Lexical Analyzer */
/* Helper Functions Header File */

#ifndef LEXERFUNCTIONS_H
#define LEXERFUNCTIONS_H

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>

void warn_error_message(char *filename, int line, char *message, char *type);
void append_string(char *buf, char escape);


#endif // LEXERFUNCTIONS_H