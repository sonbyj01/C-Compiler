/* Andrew Lorber & Henry Son */
/* Compilers - Lexical Analyzer */
/* Helper Functions */

#include "lexerFunctions.h"
#define STRING_SIZE 4096

// Buffer to hold string being built
char string_buffer[STRING_SIZE];
int buf_pos = 0;

// Creates / begins string
void create_string();

// Adds chars to string
void append_string();

// Completes String
void complete_string();

// Prints String
void print_string();

void warn_error_message(char *filename, int line, char *message, char *warn_error_message) {
	fprintf(stderr, "%s: %d: %s: %s\n", filename, line, message, warn_error_message);
}