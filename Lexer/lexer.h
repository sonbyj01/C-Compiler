/* Andrew Lorber & Henry Son */
/* Compilers - Lexical Analyzer Header File */

#ifndef LEXER_H
#define LEXER_H

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>

// ENUM for number size-specifiers
enum num_sizes {
    FLOAT = 1,
    DOUBLE,
    LONGDOUBLE,
    INT,
    LONG,
    LONGLONG
};

// Defines struct to store number info
typedef struct {
    int sign = 1; /* 0 = unsigned */
    int size_specifier = INT; /* See enum */ 
    /* Variables to store possible number types */
    long double d_value;
    long long int i_value;
} num_type;

// Defines union to store semantic values
typedef union {
    num_type number;
    char c;
    char *string;
    char *ident;
} YYSTYPE;

YYSTYPE yylval;

#endif // LEXER_H