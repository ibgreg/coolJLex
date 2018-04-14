/*
 *  The scanner definition for COOL.
 */

import java_cup.runtime.Symbol;

%%

%{

/*  Stuff enclosed in %{ %} is copied verbatim to the lexer class
 *  definition, all the extra variables/functions you want to use in the
 *  lexer actions should go here.  Don't remove or modify anything that
 *  was there initially.  */

    // Max size of string constants
    static int MAX_STR_CONST = 1025;

    // For assembling string constants
    StringBuffer string_buf = new StringBuffer();

    private int curr_lineno = 1;
    int get_curr_lineno() {
	return curr_lineno;
    }

    private AbstractSymbol filename;

    void set_filename(String fname) {
	filename = AbstractTable.stringtable.addString(fname);
    }

    AbstractSymbol curr_filename() {
	return filename;
    }

    int comentarioLength = 0;
%}

%init{

/*  Stuff enclosed in %init{ %init} is copied verbatim to the lexer
 *  class constructor, all the extra initialization you want to do should
 *  go here.  Don't remove or modify anything that was there initially. */

    // empty for now
%init}

%eofval{

/*  Stuff enclosed in %eofval{ %eofval} specifies java code that is
 *  executed when end-of-file is reached.  If you use multiple lexical
 *  states and want to do something special if an EOF is encountered in
 *  one of those states, place your code in the switch statement.
 *  Ultimately, you should return the EOF symbol, or your lexer won't
 *  work.  */

    switch(yy_lexical_state) {
    case YYINITIAL:
	/* nothing special to do in the initial state */
	break;
		case COMENTARIO:
			yybegin(YYINITIAL);
          		return new Symbol(TokenConstants.ERROR, "Foi encontrado um EOF no comentario");
		case STRING:
			yybegin(YYINITIAL);
			return new Symbol(TokenConstants.ERROR, "Foi encontrado um EOF na string");
	
    }
    return new Symbol(TokenConstants.EOF);
%eofval}

%class CoolLexer
%cup

%state COMENTARIO
%state STRING
%state STRINGERRONULL

CLASS = [Cc][Ll][Aa][Ss][Ss]
ELSE = [Ee][Ll][Ss][Ee]
IF = [Ii][Ff]
FI = [Ff][Ii]
IN = [Ii][Nn]
INHERITS = [Ii][Nn][Hh][Ee][Rr][Ii][Tt][Ss]
ISVOID = [Ii][Ss][Vv][Oo][Ii][Dd]
LET = [Ll][Ee][Tt]
LOOP = [Ll][Oo][Oo][Pp]
POOL = [Pp][Oo][Oo][Ll]
THEN = [Tt][Hh][Ee][Nn]
WHILE = [Ww][Hh][Ii][Ll][Ee]
CASE = [Cc][Aa][Ss][Ee]
ESAC = [Ee][Ss][Aa][Cc]
NEW = [Nn][Ee][Ww]
OF = [Oo][Ff]
NOT = [Nn][Oo][Tt]
TRUE = t[Rr][Uu][Ee]
FALSE = f[Aa][Ll][Ss][Ee]
DIGITOS = [0-9]
TIPOIDENT = [A-Z][A-Za-z0-9_]*
OBJIDENT = [a-z][A-Za-z0-9_]*
CHAR = .|\r
STRINGINICIO = \"
STRINGCHAR  = [^\"\0\n\\]+
STRINGFIM = \"
COMENTARIOLINHA = --[^\n]*
COMENTARIOTXTINICIO = \(\*
COMENTARIOTXTFIM = \*\)
ESPACOBRANCO = [ \t\r\f\32]
NOVALINHA = \n
SOMA = "+"
SUBTRAI = "-" 
MULTIPLICA = "*"
DIVIDE = "/"
IGUAL = "="
MENOR = "<"
MENORIGUAL = "<="
NEGATIVO = "~"
PONTOVIRGULA = ";"
DOISPONTOS = ":"
PONTO = "."
VIRGULA = ","
ABREPARENTESIS = "("
FECHAPARENTESIS = ")"
ABRECHAVE = "{"
FECHACHAVE = "}"
ATTRIB = "<-"
AT = "@"
ARROW = "=>"


%%

<COMENTARIO,YYINITIAL>{COMENTARIOTXTINICIO}  { 
			yybegin(COMENTARIO);
			comentarioLength++;
}
<COMENTARIO>{COMENTARIOTXTFIM}              { 
			comentarioLength--;
			if(comentarioLength == 0) {
				 yybegin(YYINITIAL); 
			} 
}
<YYINITIAL>{COMENTARIOTXTFIM}        { return new Symbol(TokenConstants.ERROR, "O caractere de fechamento nao foi encontrado"); }
<YYINITIAL>{COMENTARIOLINHA}         { ; }
<COMENTARIO>{CHAR}                   { ; }
<YYINITIAL>{ESPACOBRANCO}            { ; }

<YYINITIAL>{TIPOIDENT}               { return new Symbol(TokenConstants.TYPEID, new IdSymbol(yytext(), yytext().length(), yytext().hashCode())); }
<YYINITIAL>{OBJIDENT}                { return new Symbol(TokenConstants.OBJECTID, new IdSymbol(yytext(), yytext().length(), yytext().hashCode())); }

<YYINITIAL>{ELSE}                    { return new Symbol(TokenConstants.ELSE); }
<YYINITIAL>{IF}                      { return new Symbol(TokenConstants.IF); }
<YYINITIAL>{FI}                      { return new Symbol(TokenConstants.FI); }
<YYINITIAL>{IN}                      { return new Symbol(TokenConstants.IN); }
<YYINITIAL>{INHERITS}                { return new Symbol(TokenConstants.INHERITS); }
<YYINITIAL>{ISVOID}                  { return new Symbol(TokenConstants.ISVOID); }
<YYINITIAL>{LET}                     { return new Symbol(TokenConstants.LET); }
<YYINITIAL>{LOOP}                    { return new Symbol(TokenConstants.LOOP); }
<YYINITIAL>{POOL}                    { return new Symbol(TokenConstants.POOL); }
<YYINITIAL>{THEN}                    { return new Symbol(TokenConstants.THEN); }
<YYINITIAL>{WHILE}                   { return new Symbol(TokenConstants.WHILE); }
<YYINITIAL>{CASE}                    { return new Symbol(TokenConstants.CASE); }
<YYINITIAL>{ESAC}                    { return new Symbol(TokenConstants.ESAC); }
<YYINITIAL>{NEW}                     { return new Symbol(TokenConstants.NEW); }
<YYINITIAL>{OF}                      { return new Symbol(TokenConstants.OF); }
<YYINITIAL>{NOT}                     { return new Symbol(TokenConstants.NOT); }
<YYINITIAL>{CLASS}                   { return new Symbol(TokenConstants.CLASS); }

<YYINITIAL>{TRUE}                    { return new Symbol(TokenConstants.BOOL_CONST, "true"); }
<YYINITIAL>{FALSE}                   { return new Symbol(TokenConstants.BOOL_CONST, "false"); }

<YYINITIAL>{SOMA}                    { return new Symbol(TokenConstants.PLUS); }
<YYINITIAL>{SUBTRAI}                 { return new Symbol(TokenConstants.MINUS); }
<YYINITIAL>{MULTIPLICA}              { return new Symbol(TokenConstants.MULT); }
<YYINITIAL>\{DIVIDE}                 { return new Symbol(TokenConstants.DIV); }

<YYINITIAL>{IGUAL}                   { return new Symbol(TokenConstants.EQ); }
<YYINITIAL>{MENOR}                   { return new Symbol(TokenConstants.LT); }
<YYINITIAL>{MENORIGUAL}              { return new Symbol(TokenConstants.LE); }
<YYINITIAL>{NEGATIVO}                { return new Symbol(TokenConstants.NEG); }

<YYINITIAL>{PONTOVIRGULA}            { return new Symbol(TokenConstants.SEMI); }
<YYINITIAL>{DOISPONTOS}              { return new Symbol(TokenConstants.COLON); }
<YYINITIAL>{PONTO}                   { return new Symbol(TokenConstants.DOT); }
<YYINITIAL>{VIRGULA}                 { return new Symbol(TokenConstants.COMMA); }

<YYINITIAL>{ABREPARENTESIS}          { return new Symbol(TokenConstants.LPAREN); }
<YYINITIAL>{FECHAPARENTESIS}         { return new Symbol(TokenConstants.RPAREN); }
<YYINITIAL>{ABRECHAVE}               { return new Symbol(TokenConstants.LBRACE); }
<YYINITIAL>{FECHACHAVE}              { return new Symbol(TokenConstants.RBRACE); }
<YYINITIAL>{ARROW}                   { return new Symbol(TokenConstants.DARROW); }
<YYINITIAL>{ATTRIB}                  { return new Symbol(TokenConstants.ASSIGN); }
<YYINITIAL>{AT}                      { return new Symbol(TokenConstants.AT); }

<YYINITIAL>{DIGITOS}+                { return new Symbol(TokenConstants.INT_CONST, new IntSymbol(yytext(), yytext().length(), yytext().hashCode())); }

<YYINITIAL>{STRINGINICIO}            { string_buf.setLength(0); yybegin(STRING); }

<STRING>\x00                       { 
		yybegin(STRINGERRONULL);
		return new Symbol(TokenConstants.ERROR, "Foi encontrado um caractere nulo na string"); 
}
<STRING>\\b                        { string_buf.append("\b"); }
<STRING>\\f                        { string_buf.append("\f"); }
<STRING>\\t                        { string_buf.append("\t"); }
<STRING>\\\\n                      { string_buf.append("\\n"); }
<STRING>\\n                        { string_buf.append("\n"); }
<STRING>\\\n                       { string_buf.append("\n"); }
<STRING>\\\"                       { string_buf.append("\""); }
<STRING>\\\\                       { string_buf.append("\\"); }
<STRING>\\                         { ; }
<STRING>{STRINGCHAR}              { string_buf.append(yytext()); }

<STRING>\n                         { 
		string_buf.setLength(0);
                yybegin(YYINITIAL);
                return new Symbol(TokenConstants.ERROR, "A string nao foi fechada"); 
}

<STRING>{STRINGFIM}               { 
		yybegin(YYINITIAL);
                String s = string_buf.toString();
                
		if(s.length() >= MAX_STR_CONST) {
                	return new Symbol(TokenConstants.ERROR, "String muito longa");
                } else {
                	return new Symbol(TokenConstants.STR_CONST, new StringSymbol(s, s.length(), s.hashCode()));
                }
}


<STRINGERRONULL>\n               { yybegin(YYINITIAL); }
<STRINGERRONULL>\"               { yybegin(YYINITIAL); }
<STRINGERRONULL>.                { ; }
\n                               { curr_lineno++; }

.                               { /* This rule should be the very last
                                     in your lexical specification and
                                     will match match everything not
                                     matched by other lexical rules. */
                                  return new Symbol(TokenConstants.ERROR, "Caractere desconhecido: " + yytext()); }
