/* Andrew Lorber & Henry Son */
/* Compilers - Lexical Analyzer */

/* ------------- */
/*  Definitions  */
/* ------------- */

%option noyywrap

%{
#include "tokens-manual.h"
#include "lexer.h"

extern YYSTYPE yylval;

char filename[256] = "<stdin>";
int line_number = 1;
%}

/* STATES */
%x FILE_INFO
%x CHARLIT
%x STRING
%x INT_NUM
%x FLOAT_NUM
%x COMMENT

/* NUMERIC CONSTANTS */
DEC     [1-9]+[0-9]*
OCT     0[0-7]+
HEX     0[xX][a-fA-F0-9]+
FLO     [0-9]*\.[0-9]*
EXP     [eE][+-]?{DEC}+
P       [pP][+-]?{DEC}+

%%
 /* ------- */
 /*  RULES  */
 /* ------- */

 /* FILE INFORMATION */
#                                   {BEGIN FILE_INFO;}
<FILE_INFO>^[0-9]+                  { /* Get line number in base 10 */
                                    line = (int)strtol(yytext, (char **)NULL, 10;)}

<FILE_INFO>\"(\\.|[^\\\"])*\"       { /* copy file name */
                                    strncpy(filename, yytext + 1, strlen(yytext) - 2);
                                    filename[strlen(yytext) - 2] = '\0';}

<FILE_INFO>\n                       {BEGIN INITIAL;}

<FILE_INFO>.                        {/* Ignores everything not listed */;}

 /* WHITE SPACES */
[\t\r\v\f ]+        {;}
[\n]                {line_number++;}

 /* COMMENTS */
"//".*\n            {line_number++;}
"/*"                {BEGIN COMMENT;}
<COMMENT>"*/"       {BEGIN INITIAL;}
<COMMENT>.+         {/* Ignores comment */;}
<COMMENT>\n         {line_number++;}

 /* NUMBERS */
{DEC}           {yylval.number.i_value = strtoll(yytext, NULL, 10);
                 BEGIN INT_NUM;}
{OCT}           {yylval.number.i_value = strtoll(yytext, NULL, 8);
                 BEGIN INT_NUM;}
{HEX}           {yylval.number.i_value = strtoll(yytext, NULL, 16);
                 BEGIN INT_NUM;}
{FLO}           |
{DEC}{EXP}      |
{FLO}{EXP}      |
{HEX}{P}        {yylval.number.d_value = strtod(yytext, NULL);
                 yylval.number.size_specifier = DOUBLE;
                 BEGIN FLOAT_NUM;}

<INT_NUM>[uU]       {yylval.number.sign = 0;}
<INT_NUM>(ll|LL)    {yylval.number.size_specifier = LONGLONG}
<INT_NUM>[lL]       {yylval.number.size_specifier = LONG}
<FlOAT_NUM>[fF]     {yylval.number.size_specifier = FLOAT}
<FlOAT_NUM>[lL]     {yylval.number.size_specifier = LONGDOUBLE}
<INT_NUM,FLOAT_NUM>[\t\r\v\f ]+     {BEGIN INITIAL; 
                                     return NUMBER;}
<INT_NUM,FLOAT_NUM>[\n]             {line_number++; 
                                     BEGIN INITIAL; 
                                     return NUMBER}

 /* OPERATORS */
[!%&\|\+\-\*\/\^=\<\>\(\)\[\]\{\}\~\.\?,;:]     {return yytext[0];}

indsel          {return INDSEL}
"++"            {return PLUSPLUS}
"--"            {return MINUSMINUS}
"<<"            {return SHL}
">>"            {return SHR}
"<="            {return LTEQ}
">="            {return GTEQ}
"=="            {return EQEQ}
"!="            {return NOTEQ}
"&&"            {return LOGAND}
"||"            {return LOGOR}
"..."           {return ELLIPSIS}
"*="            {return TIMESEQ}
"/="            {return DIVEQ}
"%="            {return MODEQ}
"+="            {return PLUSEQ}
"-="            {return MINUSEQ}
"<<="           {return SHLEQ}
">>="           {return SHREQ}
"&="            {return ANDEQ}
"|="            {return OREQ}
"^="            {return XOREQ}

 /* KEYWORDS */
auto            {return AUTO;}
break           {return BREAK;}
case            {return CASE;}
char            {return CHAR;}
const           {return CONST;}
continue        {return CONSTANT;}
default         {return DEFAULT;}
do              {return DO;}
double          {return DOUBLE;}
else            {return ELSE;}
enum            {return ENUM;}
extern          {return EXTERN;}
float           {return FLOAT;}
for             {return FOR;}
goto            {return GOTO;}
if              {return IF;}
inline          {return INLINE;}
int             {return INT;}
long            {return LONG;}
register        {return REGISTER;}
restrict        {return RESTRICT;}
return          {return RETURN;}
short           {return SHORT;}
signed          {return SIGNED;}
sizeof          {return SIZEOF;}
static          {return STATIC;}
struct          {return STRUCT;}
switch          {return SWITCH;}
typedef         {return TYPEDEF;}
union           {return UNION;}
unsigned        {return UNSIGNED;}
void            {return VOID;}
volatile        {return VOLATILE;}
while           {return WHILE;}
_bool           {return _BOOL;}
_complex        {return _COMPLEX;}
_imaginary      {return _IMAGINARY;}

 /* IDENTIFIERS */
[a-zA-Z_][a-zA-Z0-9_]*		{yylval.ident = strdup(yytext); return IDENT;}

 /* CHARACTER LITERALS */


 /* STRINGS */




%%
/* ----------- */
/*  USER CODE  */
/* ----------- */

void warn_error_message(char *filename, int line, char *message, char *warn_error_message) {
	fprintf(stderr, "%s: %d: %s: %s\n", filename, line, message, warn_error_message);
}

void append_string(char *buf, char escape) {
	if(buf == (char *)NULL) {
		yylval.string.word[yylval.string.length] = c;
		yylval.string.length++;
	} else {
		for(int i = 0; i < strlen(buf); i++) {
			yylval.string.word[yylval.string.length + i] = buf[i];
		}
		yylval.string.length += strlen(buf);
	}
}