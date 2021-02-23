#include "ast.h"

struct ast_node *ast_node_alloc(int node_type) {
    struct ast_node *n = malloc(sizeof(struct ast_node));
    
    if(n == NULL) {
        fprintf(stderr, "ERROR: Unable to allocate new AST Node: %s \n", strerror(errno));
        return NULL;
    }

    n->node_type = node_type;
    return n;
}

void print_ast(struct ast_node *root, int level) {

}

void ast_node_link(struct ast_node **head, struct ast_node **tail, struct ast_node *ins) {
    if(*head == NULL) {
        *head = ins;
    }

    if(*tail == NULL) {
        *tail = ins;
    } else {
        (*tail)->next = ins;
        *tail = ins;
    }

    while((*tail)->next != NULL) {
        *tail = (*tail)->next;
    }
}