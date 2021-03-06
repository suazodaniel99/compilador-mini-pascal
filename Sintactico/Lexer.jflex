import java_cup.runtime.*;
import java.io.Reader;

import java_cup.runtime.Symbol;
import java_cup.runtime.ComplexSymbolFactory;
import java_cup.runtime.ComplexSymbolFactory.Location;

%%
%unicode
%int
%line
%column
%caseless
%cup

%class lexer

%state COMMENT
%state TEXT

%{
  public static String texto = "";
  
  private Symbol symbol(String name, int sym) {
		//System.out.println("name: " + name + " sym: " + sym);
		return new Symbol(sym, yyline, yycolumn);
	}

	private Symbol symbol(String name, int sym, Object val) {
		//System.out.println("name: " + name + " sym: " + sym + " val: " + val);
		return new Symbol(sym, yyline, yycolumn, val);
	}
%}

comentarioIn = \{
comentarioOut = \}

comillas= \'

int = [iI][nN][tT][eE][gG][eE][rR]
char = [cC][hH][aH][rR]
boolean = [bB][oO][oO][lL][eE][aA][nN]
record = [rR][eE][cC][oO][rR][dD]
string = [sS][tT][rR][iI][nN][gG]


read = [rR][eE][aA][dD]
write = [wW][rR][iI][tT][eE]

program = [pP][rR][oO][gG][rR][aA][mM]
function = [fF][uU][nN][cC][tT][iI][oO][nN]
procedure = [pP][rR][oO][cC][eE][dD][uU][rR][eE]

var = [vV][aA][rR]
type = [tT][yY][pP][eE]

do = [dD][oO]
begin = [bB][eE][gG][iI][nN]
end = [eE][nN][dD]

true = [tT][rR][uU][eE]
false = [fF][aA][lL][sS][eE]

while = [wW][hH][iI][lL][eE]
for = [fF][oO][rR]
repeat = [rR][eE][pP][eE][aA][tT]
if = [iI][fF]
else = [eE][lL][sS][eE] 
parIzq = "("
parDer = ")"
then = [tT][hH][eE][nN]
to = [tT][oO]
until = [uU][nN][tT][iI][lL]

espacios = [\ \n\r\t\f]+

opsum = [+-]
opmult = [*\/]|[dD][iI][vV]|[mM][oO][dD]
opand = [aA][nN][dD]
opor = [oO][rR]
oprel = <>|=|>|<|>=|<=
not = ("!"|[nN][oO][tT])
assig = :=
colon = :

id = {letra}({letra}|{num})*

constchar = {comillas}{letra}{comillas}

num = [0-9]
nums = {num}+

coma = ,

period = "."

semcolon = ;

letra = [a-zA-Z_]

%%
<YYINITIAL>{
  {constchar}     {return symbol("CONSTCHAR", sym.CONSTCHAR, yytext());}            
  {comentarioIn}  {yybegin(COMMENT);}            
  {espacios}      {}
  {comillas}      {texto = "";yybegin(TEXT);}            
  {program}       {return symbol("PROGRAM", sym.PROGRAM);}       
  {function}      {return symbol("FUNCTION", sym.FUNCTION);}
  {procedure}     {return symbol("PROCEDURE", sym.PROCEDURE);}
  {do}            {return symbol("DO", sym.DO);}       
  {var}           {return symbol("VAR", sym.VAR);}
  {type}          {return symbol("TYPE", sym.TYPE);}
  {begin}         {return symbol("BEGIN", sym.BEGIN);}       
  {end}           {return symbol("END", sym.END);}       
  {for}           {return symbol("FOR", sym.FOR);}
  {while}         {return symbol("WHILE", sym.WHILE);}
  {repeat}        {return symbol("REPEAT", sym.REPEAT);}
  {if}            {return symbol("IF", sym.IF);}
  {else}          {return symbol("ELSE", sym.ELSE);}
  {true}          {return symbol("TRUE", sym.TRUE);}
  {false}         {return symbol("FALSE", sym.FALSE);}
  {parIzq}        {return symbol("PARIZQ", sym.PARIZQ);}
  {parDer}        {return symbol("PARDER", sym.PARDER);}
  {then}          {return symbol("THEN", sym.THEN);}
  {to}            {return symbol("TO", sym.TO);}
  {until}         {return symbol("UNTIL", sym.UNTIL);}
  {read}          {return symbol("READ", sym.READ);}
  {write}         {return symbol("WRITE", sym.WRITE);}            
  //{parDer}        {return symbol("PARDER", sym.PARDER);}            
  {opsum}         {return symbol("OPSUM", sym.OPSUM, yytext().toLowerCase());}
  {opmult}        {return symbol("OPMULT", sym.OPMULT, yytext().toLowerCase());}
  {opand}         {return symbol("OPAND", sym.OPAND);}
  {opor}          {return symbol("OPOR", sym.OPOR);}
  {oprel}         {return symbol("OPREL", sym.OPREL, yytext().toLowerCase());}
  {not}           {return symbol("NOT", sym.NOT);}
  {assig}         {return symbol("ASSIG", sym.ASSIG);}            
  {colon}         {return symbol("COLON", sym.COLON);}
  {int}           {return symbol("INT", sym.INT);}
  {char}          {return symbol("CHAR", sym.CHAR);}
  {boolean}       {return symbol("BOOLEAN", sym.BOOLEAN);}
  {record}        {return symbol("RECORD", sym.RECORD);}            
  {string}        {return symbol("STRING", sym.STRING);}            
  {nums}          {return symbol("NUMS", sym.NUMS, yytext().toLowerCase());}            
  {id}            {return symbol("ID", sym.ID, yytext().toLowerCase());}            
  {coma}          {return symbol("COMA", sym.COMA);}
  {period}        {return symbol("PERIOD", sym.PERIOD);}
  {semcolon}      {return symbol("SEMCOLON", sym.SEMCOLON);}
  .               {System.out.println("Error Lexico:\nSimbolo no reconocido: " + yytext() + " en la linea " + yyline + ", columna " + yycolumn);}
}

<COMMENT>{
  {comentarioOut} {yybegin(YYINITIAL);}
  {espacios}      {}
  .               {}
}

<TEXT>{
  {comillas}  { yybegin(YYINITIAL);
                return symbol("CONSTSTR", sym.CONSTSTR, texto);
              }
  .           {texto += yytext();}
}