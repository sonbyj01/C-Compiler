%debug
%{
#include "ast.h"
#include <stdio.h>
#include <stdlib.h>

%}

%error-verbose

/* YYLVAL */
%union {
    struct identifier {
        char *name;
    } ident;

    struct stringlit {
        char word[4096];
        int length;
    } string;

    struct number {
        unsigned long long intval;
        long double floatval;
        int sign;
        int type;
    } num;

    char charlit;
    struct ast_node *astn;
}


%token <num.intval> IDENT CHARLIT STRING NUMBER INDSEL PLUSPLUS MINUSMINUS SHL SHR LTEQ GTEQ EQEQ NOTEQ LOGAND LOGOR ELLIPSIS TIMESEQ DIVEQ MODEQ PLUSEQ MINUSEQ SHLEQ SHREQ ANDEQ OREQ XOREQ AUTO BREAK CASE CHAR CONST CONTINUE DEFAULT DO DOUBLE ELSE ENUM EXTERN FLOAT FOR GOTO IF INLINE INT LONG REGISTER RESTRICT RETURN SHORT SIGNED SIZEOF STATIC STRUCT SWITCH TYPEDEF UNION UNSIGNED VOID VOLATILE WHILE _BOOL _COMPLEX _IMAGINARY

%type <astn> primary_expr constant_expr parenthesized_expr
%type <astn> postfix_expr subscript_expr component_expr function_call postincrement_expr postdecrement_expr
%type <astn> expr_list cast_expr unary_expr sizeof_expr unary_minus unary_plus log_neg_expr bit_neg_expr addr_expr deref_expr
%type <astn> preincr_expr predecr_expr mult_expr add_expr shift_expr relation_expr equal_expr
%type <astn> bit_or_expr bit_xor_expr bit_and_expr log_or_expr log_and_expr conditional_expr assignment_expr expr
%type <num.intval> assignment_op
%type <astn> expr_statement
%type <astn> decl_func_list decl_func func decl_stmt_list decl_stmt compound_stmt decl decl_specs type_spec type_qual stg_spec direct_decl declarator pointer type_qual_list decl_list
%type <astn> stmt iter_stmt for_stmt while_stmt init_clause switch_stmt return_stmt continue_stmt break_stmt goto_stmt label named_label case_label labeled_stmt

%left ','
%right TIMESEQ
%right '='
%right '?' ':'
%left LOGOR
%left LOGAND
%left '|'
%left '^'
%left '&'
%left EQEQ NOTEQ
%left '>' '<' LTEQ GTEQ
%left SHL SHR
%left '+' '-'
%left '*' '/' '%'
%left PLUSPLUS MINUSMINUS
%left '.'
%left '[' ']'
%left '(' ')'

%start decl_func_list

%%

decl_func_list : decl_func {}
               | decl_func_list decl_func {}
               ;

decl_func      : decl_stmt {}
               | func {}
               ;

func           : decl_specs declarator '{' {
                struct sym *search = NULL;
                if(head->u.ident.name != NULL){
                  search = search_all(curr_scope, head->u.ident.name, ID_FUNC);
                }
                if(search == NULL){
                  ast_node_link(&head, &tail, $1);
                  struct sym *n = add_sym(head, curr_scope, filename, line);
                  add_stg_class(n);
                  head = (struct ast_node *)NULL;
                  tail = (struct ast_node *)NULL;
                  print_sym(n, 0);
                } else if(search->e.func.complete == 1){
                  /* previously defined func */
                } else{
                  print_sym(search, 0);
                  head = (struct ast_node *)NULL;
                  tail = (struct ast_node *)NULL;
                }
                enter_scope(SCOPE_FUNC);
               }  decl_stmt_list '}' {
                struct sym_tab *tmp = curr_scope;
                exit_scope();
                curr_scope->symsE->e.func.complete = 1;
                print_ast($$, 0);
                /* PRINT AST DUMP FOR FUNC */
               }
               ;

decl_stmt_list : decl_stmt {}
               | decl_stmt_list decl_stmt {}
               ;

decl_stmt      : decl {}
               | stmt {}
               ;

init_clause    : expr
               | decl
               ;

stmt           : expr_statement
               | compound_stmt
               | iter_stmt
               | switch_stmt
               | return_stmt
               | continue_stmt
               | break_stmt
               | goto_stmt
               | labeled_stmt
               | ';' {
                 /* NULL STATEMENT */
               }
               ;

switch_stmt    : SWITCH '(' expr ')' stmt {

               }
               ;

return_stmt    : RETURN expr ';' {

               }
               | RETURN ';' {

               }
               ;

continue_stmt  : CONTINUE ';' {

               }
               ;

/* TODO: CONTINUE */
%%