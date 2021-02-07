/* Andrew Lorber & Henry Son */
/* Compilers - Lexical Analyzer */
/* Helper Functions */

#include "lexerFunctions.h"
#define STRING_SIZE 4096

// Buffer to hold string being built
char string_buffer[STRING_SIZE];
int buf_pos = 0;

// Creates / begins string
void create_string() {
	// Clears buffer and sets pointer position to beginning
	memset(string_buffer, 0, sizeof(string_buffer));
	buf_pos = 0;
}

// Adds chars to string
void append_string(char *text) {
	string_buffer[buf_pos++] = text[0];
}

// Adds escape characters to string
// base: 0 -> simple escape
//		 8 -> Octal escape
//		 16 -> Hex escape
void append_escape(char* text, int base) {
	// Checks escape type
	if(base == 0) {
		string_buffer[buf_pos++] = '\\';
		string_buffer[buf_pos++] = text[1];
	} else if(base == 8) {
		string_buffer[buf_pos++] = strtol(text+1, NULL, 8);
	} else if(base == 16) {
		string_buffer[buf_pos++] = strtol(text+2, NULL, 16);
	} else {
		// Should never have incorrect input, but checks anyways
		// PRINT ERROR
	}
}

// Completes String
char* complete_string() {
	// Adds null terminator
	string_buffer[buf_pos++] = '\0';

	// Returns pointer to copy of string
	return strdup(string_buffer);
}

// Prints String
void print_string(char *string) {
	for(int i = 0; string[i] != '\0' && i < STRING_SIZE; i++) {
		printf("%c", string[i]);
	}
}

void print_error(char *filename, int line_num, char* text, char* message) {
	fprintf(stderr, "%s: line %d: %s - %s\n", filename, line_num, text, message);
}