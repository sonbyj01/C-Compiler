/* Andrew Lorber & Henry Son */
/* Compilers - Lexical Analyzer */
/* Helper Functions */

#include "lexerFunctions.h"

void warn_error_message(char *filename, int line, char *message, char *warn_error_message) {
	fprintf(stderr, "%s: %d: %s: %s\n", filename, line, message, warn_error_message);
}

void append_string(char *buf, char escape) {
	
}