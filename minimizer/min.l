/* Scanner for minimizing JavaScript and/or CSS files for optimized HTTP payload. 
 *
 * By CJ Barker
 */

NEWLINE [\n\r]*
WHITESPACE [ \t]* 
START_WHITESPACE ^[ \t]+
END_WHITESPACE [ \t]+$
A   [/]
B   [*]
C   [^/*]
%x COMMENT

%% 

"/*"                { BEGIN COMMENT;    /* switch to comment mode */ }
<COMMENT>.          |
<COMMENT>\n ;       /* throw away comment text */
<COMMENT>"*/"       { BEGIN INITIAL;    /* return to regular mode */ }

{A}({A}.*|{B}({A}|{C}|{B}+{C})*{B}+{A}) /* eat single-line comment */

{NEWLINE}           /* eat up leading space */
{START_WHITESPACE}  /* eat up leading space */
{WHITESPACE}        printf(" ");
{END_WHITESPACE}    /* eat up trailing space */

%%

main(int argc, char **argv) 
{
    ++argv, --argc;     /* skip program name */
    char *file_ext = NULL;
	int close_file = 0;

    if (argc > 0) {
        yyin = fopen(argv[0], "r");
		close_file = 1;
	}
    else 
        yyin = stdin;

    yylex();
    printf("\n");
	
	if (close_file && yyin) fclose(yyin);
}
int yywrap() { return 1; }
